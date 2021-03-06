; --------------------------------------------------------------------------------------------------
;                           vdmdbg.inc Copyright The MASM32 SDK 1998-2010
; --------------------------------------------------------------------------------------------------

IFNDEF VDMDBG_INC
VDMDBG_INC equ <1>

VDMBreakThread PROTO STDCALL :DWORD,:DWORD

VDMDetectWOW PROTO STDCALL
IFDEF __UNICODE__
  VDMDetectWO equ <VDMDetectWOW>
ENDIF

VDMEnumProcessWOW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  VDMEnumProcessWO equ <VDMEnumProcessWOW>
ENDIF

VDMEnumTaskWOW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  VDMEnumTaskWO equ <VDMEnumTaskWOW>
ENDIF

VDMEnumTaskWOWEx PROTO STDCALL :DWORD,:DWORD,:DWORD
VDMGetAddrExpression PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
VDMGetContext PROTO STDCALL :DWORD,:DWORD,:DWORD
VDMGetDbgFlags PROTO STDCALL :DWORD
VDMGetModuleSelector PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
VDMGetPointer PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
VDMGetSegmentInfo PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
VDMGetSegtablePointer PROTO STDCALL
VDMGetSelectorModule PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
VDMGetSymbol PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
VDMGetThreadContext PROTO STDCALL :DWORD,:DWORD
VDMGetThreadSelectorEntry PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
VDMGlobalFirst PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
VDMGlobalNext PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
VDMIsModuleLoaded PROTO STDCALL :DWORD

VDMKillWOW PROTO STDCALL
IFDEF __UNICODE__
  VDMKillWO equ <VDMKillWOW>
ENDIF

VDMModuleFirst PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
VDMModuleNext PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
VDMProcessException PROTO STDCALL :DWORD
VDMSetContext PROTO STDCALL :DWORD,:DWORD,:DWORD
VDMSetDbgFlags PROTO STDCALL :DWORD,:DWORD
VDMSetThreadContext PROTO STDCALL :DWORD,:DWORD

VDMStartTaskInWOW PROTO STDCALL :DWORD,:DWORD,:DWORD
IFDEF __UNICODE__
  VDMStartTaskInWO equ <VDMStartTaskInWOW>
ENDIF

VDMTerminateTaskWOW PROTO STDCALL :DWORD,:DWORD
IFDEF __UNICODE__
  VDMTerminateTaskWO equ <VDMTerminateTaskWOW>
ENDIF

ELSE
  echo -----------------------------------------
  echo WARNING duplicate include file vdmdbg.inc
  echo -----------------------------------------
ENDIF
