#!/usr/bin/env python3
"""
Site Monitoring Script for Cron
Single check of sqlize.online availability and triggers Docker Compose restart if down.
Designed to run periodically via cron, not as a continuous service.
"""

import socket
import json
import sys
import syslog
from urllib.request import urlopen, Request
from urllib.error import URLError, HTTPError

# Configuration
CONFIG = {
    'SITE_URL': 'https://sqlize.online',
    'TIMEOUT': 10,  # seconds for HTTP request timeout
    
    # Management server settings
    'MGMT_HOST': '127.0.0.1',  # Management server IP
    'MGMT_PORT': 9999,
    'MGMT_KEY': 'RESTART_COMPOSE',  # Must match server's SECRET_KEY
}


def log(message, level=syslog.LOG_INFO):
    """Log message to syslog and stdout"""
    syslog.syslog(level, message)
    print(message)


def check_site(url, timeout):
    """Check if the site is available"""
    try:
        # Create request with user agent
        req = Request(url)
        req.add_header('User-Agent', 'SiteMonitor/1.0 (Cron)')
        
        # Try to open URL
        response = urlopen(req, timeout=timeout)
        status_code = response.getcode()
        
        if status_code == 200:
            log(f"Site {url} is UP (Status: {status_code})", syslog.LOG_INFO)
            return True
        else:
            log(f"Site {url} returned non-200 status: {status_code}", syslog.LOG_WARNING)
            return False
            
    except HTTPError as e:
        log(f"HTTP Error checking {url}: {e.code} - {e.reason}", syslog.LOG_WARNING)
        return False
        
    except URLError as e:
        log(f"URL Error checking {url}: {e.reason}", syslog.LOG_WARNING)
        return False
        
    except socket.timeout:
        log(f"Request to {url} timed out after {timeout} seconds", syslog.LOG_WARNING)
        return False
        
    except Exception as e:
        log(f"Unexpected error checking {url}: {str(e)}", syslog.LOG_ERR)
        return False


def send_restart_command(host, port, secret_key):
    """Send restart command to management server"""
    try:
        log(f"Connecting to management server at {host}:{port}...", syslog.LOG_INFO)
        
        # Create socket
        client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client.settimeout(30)
        
        # Connect
        client.connect((host, port))
        
        # Prepare command
        command = json.dumps({
            'key': secret_key,
            'action': 'RESTART'
        })
        
        # Send command
        log("Sending RESTART command to management server", syslog.LOG_INFO)
        client.sendall(command.encode('utf-8'))
        
        # Receive response
        response = client.recv(4096).decode('utf-8')
        client.close()
        
        # Parse response
        try:
            response_data = json.loads(response)
            status = response_data.get('status', 'unknown')
            message = response_data.get('message', 'No message')
            
            if status == 'success':
                log(f"Docker Compose restart successful: {message}", syslog.LOG_NOTICE)
                return True
            else:
                log(f"Docker Compose restart failed: {message}", syslog.LOG_ERR)
                return False
                
        except json.JSONDecodeError:
            log(f"Invalid response from management server: {response}", syslog.LOG_ERR)
            return False
            
    except socket.timeout:
        log("Connection to management server timed out", syslog.LOG_ERR)
        return False
        
    except ConnectionRefusedError:
        log(f"Connection refused. Management server not running on {host}:{port}", syslog.LOG_ERR)
        return False
        
    except Exception as e:
        log(f"Error communicating with management server: {str(e)}", syslog.LOG_ERR)
        return False


def main():
    """Main entry point - single check execution"""
    # Initialize syslog
    syslog.openlog('site_monitor', syslog.LOG_PID, syslog.LOG_DAEMON)
    
    try:
        log(f"Starting site availability check for {CONFIG['SITE_URL']}", syslog.LOG_INFO)
        
        # Check site availability
        is_up = check_site(CONFIG['SITE_URL'], CONFIG['TIMEOUT'])
        
        if is_up:
            # Site is up, nothing to do
            log("Site is available - no action needed", syslog.LOG_INFO)
            sys.exit(0)
        else:
            # Site is down, trigger restart
            log(f"Site {CONFIG['SITE_URL']} is DOWN - triggering Docker Compose restart", syslog.LOG_WARNING)
            
            # Send restart command
            success = send_restart_command(
                CONFIG['MGMT_HOST'],
                CONFIG['MGMT_PORT'],
                CONFIG['MGMT_KEY']
            )
            
            if success:
                log("Docker Compose restart initiated successfully", syslog.LOG_NOTICE)
                sys.exit(0)
            else:
                log("Failed to restart Docker Compose", syslog.LOG_ERR)
                sys.exit(1)
                
    except Exception as e:
        log(f"Fatal error in site monitor: {str(e)}", syslog.LOG_ERR)
        sys.exit(1)
    finally:
        syslog.closelog()


if __name__ == '__main__':
    main()
