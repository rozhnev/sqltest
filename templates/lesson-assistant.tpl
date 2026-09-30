{* Lesson assistant panel (see LESSON_ASSISTANT_PLAN.md, Stage 5): the shared AI assistant panel with the
   lesson's endpoint and texts ({lang}/lesson-assistant.tpl, picked by the "part" parameter).
   Params: mobile (bool) - render as a bottom sheet opened by a floating button. *}
{include file='ai-assistant.tpl' assistantId='lesson-assistant' endpoint="/{$Lang}/lesson/{$LessonData.id}/assistant"
    text=$LessonAssistantTemplate history=$LessonAssistantHistory mobile=$mobile}
