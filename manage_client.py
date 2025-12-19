#!/usr/bin/env python3
"""
Client script to send commands to the Docker Compose Management Server
"""

import socket
import json
import sys
import argparse


def send_command(host, port, action, secret_key):
    """Send command to management server"""
    try:
        # Create socket
        client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client.settimeout(30)
        
        # Connect to server
        print(f"Connecting to {host}:{port}...")
        client.connect((host, port))
        
        # Prepare command
        command = json.dumps({
            'key': secret_key,
            'action': action
        })
        
        # Send command
        print(f"Sending command: {action}")
        client.sendall(command.encode('utf-8'))
        
        # Receive response
        response = client.recv(4096).decode('utf-8')
        client.close()
        
        # Parse and display response
        try:
            response_data = json.loads(response)
            print(f"\nStatus: {response_data.get('status', 'unknown')}")
            print(f"Message: {response_data.get('message', 'No message')}")
            if 'timestamp' in response_data:
                print(f"Timestamp: {response_data['timestamp']}")
            
            return response_data.get('status') == 'success'
        except json.JSONDecodeError:
            print(f"Response: {response}")
            return False
            
    except socket.timeout:
        print("Error: Connection timed out")
        return False
    except ConnectionRefusedError:
        print(f"Error: Connection refused. Is the server running on {host}:{port}?")
        return False
    except Exception as e:
        print(f"Error: {str(e)}")
        return False


def main():
    parser = argparse.ArgumentParser(description='Docker Compose Management Client')
    parser.add_argument('action', choices=['restart', 'status'], help='Action to perform')
    parser.add_argument('--host', default='127.0.0.1', help='Server host (default: 127.0.0.1)')
    parser.add_argument('--port', type=int, default=9999, help='Server port (default: 9999)')
    parser.add_argument('--key', default='RESTART_COMPOSE', help='Secret key')
    
    args = parser.parse_args()
    
    success = send_command(args.host, args.port, args.action, args.key)
    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
