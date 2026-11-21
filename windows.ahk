#Requires AutoHotkey v2.0.2+
#SingleInstance
#Include "%A_ScriptDir%\corp.ahk"
; DetectHiddenWindows True

; Reload flag rides in env var: new instance inherits parent's environment
if EnvGet("AHK_RELOADED") {
    EnvSet("AHK_RELOADED")
    ToolTip("AHK config reloaded")
    SetTimer(() => ToolTip(), -1500)
}

:*:gggc::gnaw.gnep@gmail.com
::grlm::
{
    SendInput(
    (
    "{Raw}Interview me relentlessly about every aspect of this plan until we reach a shared understanding.  Walk down each branch of the design tree, resolving dependencies between decisions one-by-one.  For each question, provide your recommended answer. If a question can be answered by exploring the codebase, explore the codebase instead."
    ))
}

+!r:: (EnvSet("AHK_RELOADED", "1"), Reload())

Capslock::LCtrl
^Esc:: SetCapsLockState(!GetKeyState("CapsLock", "T"))

!q:: Send("{ALT DOWN}{F4}{ALT UP}")  
!Space:: ToggleSearch()

!+a:: Run "https://portal.azure.com"

#+d:: Run(EnvGet("USERPROFILE")  "\Downloads")

#!Space:: Send("{Media_Play_Pause}")
#!h:: Send("{Media_Prev}")
#!j:: Send("{Volume_Down}")
#!k:: Send("{Volume_Up}")
#!l:: Send("{Media_Next}")

^!g:: SetupComTools() 

#!m:: SoundSetMute(-1)
#!z:: HideDesktopIcons(-1)
#F2:: MonitorOff()
#+^d:: ToggleWindowsTheme()

!+q:: SearchSelectedText()
!+w:: TranslateSelectedText()
!Up:: CenterActiveWindow()

!j:: Send("#1")
!k:: Send("#2")
!l:: Send("#3")
!;:: Send("#4")
!':: Send("#5")
#+^1:: SetDpiScale(100, 2)
#+^2:: SetDpiScale(125, 2)
#+^3:: SetDpiScale(200, 2)

; mostly for check vpn connection status
#+z::Send("#b{Enter}")

; Win11 search runs in SearchHost.exe, Win10 in SearchApp.exe
ToggleSearch() {
    KeyWait("Space")
    if WinActive("ahk_exe SearchHost.exe") || WinActive("ahk_exe SearchApp.exe")
        Send("{Esc}")
    else
        Send("#s")
}

MonitorOff() {
    SendMessage(0x112, 0xF170, 2, , "Program Manager")
}

TranslateSelectedText() {
    Send("^c")
    RUN "https://www.bing.com/translator?from=en-US&to=zh-CN&text=" A_Clipboard
}

SearchSelectedText() {
    Send("^c")
    RUN "https://www.google.com/search?q=" A_Clipboard
}

HideDesktopIcons(Show := -1) {
    local hProgman := WinExist("ahk_class WorkerW", "FolderView") ? WinExist()
        : WinExist("ahk_class Progman", "FolderView")

    local hShellDefView := DllCall("user32.dll\GetWindow", "ptr", hProgman, "int", 5, "ptr")
    local hSysListView := DllCall("user32.dll\GetWindow", "ptr", hShellDefView, "int", 5, "ptr")

    if (DllCall("user32.dll\IsWindowVisible", "ptr", hSysListView) != Show)
        DllCall("user32.dll\SendMessage", "ptr", hShellDefView, "ptr", 0x111, "ptr", 0x7402, "ptr", 0)
}

; hwnd -> {x, y, w, h, state, tx, ty, tw, th}; saved layout + centered target
global CenteredWindows := Map()

CenterActiveWindow() {
    hwnd := WinExist("A")
    if !hwnd
        return

    ; second press: window still at centered target -> restore saved layout
    if CenteredWindows.Has(hwnd) {
        s := CenteredWindows[hwnd]
        CenteredWindows.Delete(hwnd)
        WinGetPos(&cx, &cy, &cw, &ch, hwnd)
        if (WinGetMinMax(hwnd) = 0
            && Abs(cx - s.tx) <= 8 && Abs(cy - s.ty) <= 8
            && Abs(cw - s.tw) <= 8 && Abs(ch - s.th) <= 8) {
            MoveWindowTwice(hwnd, s.x, s.y, s.w, s.h)
            if (s.state = 1)
                WinMaximize(hwnd)
            return
        }
        ; window changed since centering: fall through, center afresh
    }

    ; resolve monitor BEFORE restore: restore can change position
    WinGetPos(&px, &py, &pw, &ph, hwnd)
    pcx := px + pw // 2
    pcy := py + ph // 2
    mon := MonitorGetPrimary()
    Loop MonitorGetCount() {
        MonitorGet(A_Index, &ml, &mt, &mr, &mb)
        if (pcx >= ml && pcx < mr && pcy >= mt && pcy < mb) {
            mon := A_Index
            break
        }
    }
    MonitorGetWorkArea(mon, &wl, &wt, &wr, &wb)

    state := WinGetMinMax(hwnd)
    if (state != 0)
        WinRestore(hwnd)
    WinGetPos(&x, &y, &w, &h, hwnd)   ; normal (restored) rect

    areaW := wr - wl
    areaH := wb - wt
    winW := Round(areaW > 2000 ? areaW * 0.75 : areaW)
    winH := areaH
    winX := Round(wl + (areaW - winW) / 2)

    CenteredWindows[hwnd] := {x: x, y: y, w: w, h: h, state: state
        , tx: winX, ty: wt, tw: winW, th: winH}
    MoveWindowTwice(hwnd, winX, wt, winW, winH)
}

; move, then repeat: mixed-DPI monitors rescale window after first move
MoveWindowTwice(hwnd, x, y, w, h) {
    WinMove(x, y, w, h, hwnd)
    WinMove(x, y, w, h, hwnd)
}

ToggleWindowsTheme() {
    personalizeKey := "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    current := RegRead(personalizeKey, "AppsUseLightTheme", 1)
    next := current ? 0 : 1

    RegWrite(next, "REG_DWORD", personalizeKey, "AppsUseLightTheme")
    RegWrite(next, "REG_DWORD", personalizeKey, "SystemUsesLightTheme")

    ; Broadcast theme change asynchronously to avoid hokey blocking
    SetTimer(() => BroadcastThemeChange(), -100)
}

BroadcastThemeChange() {
    HWND_BROADCAST := 0xFFFF
    WM_SETTINGCHANGE := 0x001A
    SMTO_ABORTIFHUNG := 0x0002
    DllCall(
        "user32\SendMessageTimeout"
        , "ptr", HWND_BROADCAST
        , "uint", WM_SETTINGCHANGE
        , "ptr", 0
        , "str", "ImmersiveColorSet"
        , "uint", SMTO_ABORTIFHUNG
        , "uint", 300
        , "ptr*", 0
    )
}


SetDpiScale(percent, monitorIndex := 0) {
    static steps := [100, 125, 150, 175, 200, 225, 250, 300, 350, 400, 450, 500]
    static QDC_ONLY_ACTIVE_PATHS := 2
    static GET_DPI := -3, SET_DPI := -4        ; undocumented DISPLAYCONFIG_DEVICE_INFO_TYPE values
    static PATH_SIZE := 72, MODE_SIZE := 64

    ; Convert percent to index in the step table
    target := 0
    for i, v in steps
        if (v = percent)
            target := i
    if !target {
        MsgBox("Unsupported scale: " percent "%`nUse one of: 100, 125, 150, 175, 200, 225, 250, 300, 350, 400, 450, 500")
        return
    }

    ; Get active display paths
    nPaths := 0, nModes := 0
    rc := DllCall("user32\GetDisplayConfigBufferSizes", "UInt", QDC_ONLY_ACTIVE_PATHS
        , "UInt*", &nPaths, "UInt*", &nModes, "Int")
    if rc {
        MsgBox("GetDisplayConfigBufferSizes failed: " rc)
        return
    }
    paths := Buffer(nPaths * PATH_SIZE, 0)
    modes := Buffer(nModes * MODE_SIZE, 0)
    rc := DllCall("user32\QueryDisplayConfig", "UInt", QDC_ONLY_ACTIVE_PATHS
        , "UInt*", &nPaths, "Ptr", paths, "UInt*", &nModes, "Ptr", modes, "Ptr", 0, "Int")
    if rc {
        MsgBox("QueryDisplayConfig failed: " rc)
        return
    }

    ; Single monitor: ignore monitorIndex, use the only one
    if (nPaths = 1)
        monitorIndex := 0

    results := ""
    Loop nPaths {
        idx := A_Index
        if (monitorIndex && idx != monitorIndex)
            continue

        ; sourceInfo.adapterId (LUID) at offset 0, sourceInfo.id at offset 8
        base := (idx - 1) * PATH_SIZE
        luidLow  := NumGet(paths, base,     "UInt")
        luidHigh := NumGet(paths, base + 4, "Int")
        srcId    := NumGet(paths, base + 8, "UInt")

        ; --- GET: header(20) + min/cur/max relative scale (3 x Int) = 32 bytes
        get := Buffer(32, 0)
        NumPut("Int", GET_DPI, "UInt", 32, "UInt", luidLow, "Int", luidHigh, "UInt", srcId, get)
        rc := DllCall("user32\DisplayConfigGetDeviceInfo", "Ptr", get, "Int")
        if rc {
            results .= "Display " idx ": GET failed (" rc ")`n"
            continue
        }
        minRel := NumGet(get, 20, "Int")
        curRel := NumGet(get, 24, "Int")
        maxRel := NumGet(get, 28, "Int")

        ; minRel is negative of the recommended step's index (0-based)
        recIdx := Abs(minRel) + 1                 ; 1-based index into steps
        rel := target - recIdx                    ; value relative to recommended

        if (rel < minRel || rel > maxRel) {
            results .= "Display " idx ": " percent "% not supported (allowed "
                . steps[recIdx + minRel] "%-" steps[recIdx + maxRel] "%)`n"
            continue
        }

        ; --- SET: header(20) + relative scale (Int) = 24 bytes
        set := Buffer(24, 0)
        NumPut("Int", SET_DPI, "UInt", 24, "UInt", luidLow, "Int", luidHigh, "UInt", srcId
            , "Int", rel, set)
        rc := DllCall("user32\DisplayConfigSetDeviceInfo", "Ptr", set, "Int")
        results .= "Display " idx ": " (rc ? "SET failed (" rc ")"
            : steps[recIdx + curRel] "% -> " percent "%") "`n"
    }

    ToolTip(Trim(results, "`n"))
    SetTimer(() => ToolTip(), -2500)
}

; Leftmost portrait monitor (height > width); fall back to primary
GetPortraitMonitor() {
    best := 0, bestL := ""
    Loop MonitorGetCount() {
        MonitorGetWorkArea(A_Index, &l, &t, &r, &b)
        if ((b - t) > (r - l) && (bestL = "" || l < bestL))
            best := A_Index, bestL := l
    }
    return best ? best : MonitorGetPrimary()
}

; Move so the VISIBLE frame lands exactly on x,y,w,h (compensates invisible DWM borders)
PlaceVisible(hwnd, x, y, w, h) {
    WinRestore(hwnd)
    MoveWindowTwice(hwnd, x, y, w, h)            ; settle DPI rescale first
    WinGetPos(&wx, &wy, &ww, &wh, hwnd)
    r := Buffer(16, 0)
    if DllCall("dwmapi\DwmGetWindowAttribute", "ptr", hwnd, "uint", 9, "ptr", r, "uint", 16)
        return                                    ; DWMWA_EXTENDED_FRAME_BOUNDS failed
    dl := NumGet(r, 0, "int") - wx
    dt := NumGet(r, 4, "int") - wy
    dr := (wx + ww) - NumGet(r, 8, "int")
    db := (wy + wh) - NumGet(r, 12, "int")
    MoveWindowTwice(hwnd, x - dl, y - dt, w + dl + dr, h + dt + db)
}

Place(criteria, x, y, w, h, launchCmd := "") {
    if !WinExist(criteria) {
        if (launchCmd = "")
            return
        try Run(launchCmd)
        catch {
            MsgBox "Could not launch: " launchCmd
            return
        }
        if !WinWait(criteria, , 15)
            return
    }
    PlaceVisible(WinExist(criteria), x, y, w, h)
}

SetupComTools() {
    ; per-monitor-v2 so coords are physical on every monitor regardless of scale
    old := DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr")
    MonitorGetWorkArea(GetPortraitMonitor(), &L, &T, &R, &B)
    W := R - L, H := B - T
    row := H // 3
    Place("ahk_exe olk.exe",        L, T,           W, row,         "olk.exe")           ; New Outlook
    Place("ahk_exe ms-teams.exe",   L, T + row,     W, row,         "ms-teams.exe")      ; New Teams
    Place("ahk_exe copilotapp.exe", L, T + row * 2, W, H - row * 2, "C:\Program Files (x86)\Microsoft\Copilot\Application\copilotapp.exe")   ; Copilot
    DllCall("SetThreadDpiAwarenessContext", "ptr", old, "ptr")
}
