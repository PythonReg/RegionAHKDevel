DllCall("Winhttp.dll\WinHttpSetOption", "Ptr", 0, "UInt", 31, "UInt*", 0x00000800, "UInt", 4)
OnMessage(0x0133, "WM_CTLCOLOR_EDIT_AND_STATIC") ; WM_CTLCOLOREDIT
OnMessage(0x0134, "WM_CTLCOLOR_EDIT_AND_STATIC") ; WM_CTLCOLORSTATIC
OnMessage(0x0133, "WM_CTLCOLOR_MAIN_GUI")
OnMessage(0x0201, "WM_LBUTTONDOWN") ; Включает перетаскивание окна мышкой


#SingleInstance Force ; Принудительно закрывает старую копию скрипта при запуске новой
#NoEnv
SendMode Input
ListLines Off
Process, Priority, , A

Global CurrentVersion := "2.0"
Global UpdateURL      := "https://raw.githubusercontent.com/PythonReg/RegionHelperUpdate/main/version.txt"
Global DownloadURL    := "https://github.com/PythonReg/RegionHelperUpdate/raw/main/Region%20help.exe"

PunishPath := A_WorkingDir "\Punishment.txt"
if !FileExist(PunishPath)
{
    FileAppend, /jail ID time Причина`n, %PunishPath%, UTF-8
}
FormatTime, CurrentDate,, ddMM
IniRead, DayANS, Settings.ini, Counter, DayANS, 0
IniRead, WeekANS, Settings.ini, Counter, WeekANS, 0
IniRead, ovX, Settings.ini, Counter, ovX, 10
IniRead, ovY, Settings.ini, Counter, ovY, 10
IniRead, ShowOverlay, Settings.ini, Counter, ShowOverlay, 1
if (DayANS = "" or DayANS = "ERROR")
    DayANS := 0
if (WeekANS = "" or WeekANS = "ERROR")
    WeekANS := 0

; Чтение горячих клавиш (пример для первых нескольких, остальные подгрузятся так же)
Loop, 20 {
    IniRead, KEY%A_Index%, Settings.ini, KeySetup, KEY%A_Index%, Нет
}
IniRead, KEY11, Settings.ini, KeySetup, KEY11, Нет
IniRead, Radio3, Settings.ini, Settings, Male, 1
IniRead, Radio4, Settings.ini, Settings, Female, 0
IniRead, Radio8, Settings.ini, Settings, /gm, 0
IniRead, Radio9, Settings.ini, Settings, /esp4, 0
IniRead, Radio10, Settings.ini, Settings, /templeader 5, 0
IniRead, Radio11, Settings.ini, Settings, /hide, 0

Loop, 20 {
    IniRead, key%A_Index%, Settings.ini, KeySetup, KEY%A_Index%, % ""
}

IniRead, KeyTele, Settings.ini, KeySetup, KeyTele, F4
IniRead, KeyPunish, Settings.ini, KeySetup, KeyPunish, Delete
IniRead, KeyAns, Settings.ini, KeySetup, KeyAns, End
IniRead, KeyCmd, Settings.ini, KeySetup, KeyCmd, F5
IniRead, KeyGreet, Settings.ini, KeySetup, KeyGreet, %A_Space%
IniRead, KeyGo, Settings.ini, KeySetup, KeyGo, %A_Space%
IniRead, KeyWait, Settings.ini, KeySetup, KeyWait, %A_Space%
IniRead, KeyPlay, Settings.ini, KeySetup, KeyPlay, %A_Space%
if (KeyGreet != "")
    Hotkey, %KeyGreet%, GreetLabel, UseErrorLevel
if (KeyGo != "")
    Hotkey, %KeyGo%, GoLabel, UseErrorLevel
if (KeyWait != "")
    Hotkey, %KeyWait%, WaitLabel, UseErrorLevel
if (KeyPlay != "")
    Hotkey, %KeyPlay%, PlayLabel, UseErrorLevel
IniRead, KEY13, Settings.ini, KeySetup, KEY13, PgUp
IniRead, qdis, Settings.ini, Discord, qdis, % ""
IniRead, gadis, Settings.ini, Discord, gadis, % ""
IniRead, zgadis, Settings.ini, Discord, zgadis, % ""
Version := "v.2.0" ; Версия твоего скрипта
Gosub, CheckForUpdates
if qdis=ERROR
{
IniWrite, Ваш дискорд, Settings.ini, Discord, qdis
IniWrite, lorenze, Settings.ini, Discord, gadis
IniWrite, sanemirgn, Settings.ini, Discord, zgadis
reload
}
IniRead, qX, Settings.ini, Coords, qX
IniRead, qY, Settings.ini, Coords, qY
if qX=ERROR
{
IniWrite, 0, Settings.ini, Coords, qX
IniWrite, 0, Settings.ini, Coords, qY
reload
}
Hotkey, %KEY1%, Off, UseErrorLevel
Hotkey, %KEY1%, Reports, On, UseErrorLevel
Hotkey, %KEY2%, Off, UseErrorLevel
Hotkey, %KEY2%, delv, On, UseErrorLevel
Hotkey, %KEY3%, Off, UseErrorLevel
Hotkey, %KEY3%, gm, On, UseErrorLevel
Hotkey, %KEY4%, Off, UseErrorLevel
Hotkey, %KEY4%, tp, On, UseErrorLevel
Hotkey, %KEY5%, Off, UseErrorLevel
Hotkey, %KEY5%, fastrep, On, UseErrorLevel
Hotkey, %KEY6%, Off, UseErrorLevel
Hotkey, %KEY6%, fastans, On, UseErrorLevel
Hotkey, %KEY7%, Off, UseErrorLevel
Hotkey, %KEY7%, dl, On, UseErrorLevel
Hotkey, %KEY8%, Off, UseErrorLevel
Hotkey, %KEY8%, mtp, On, UseErrorLevel
Hotkey, %KEY9%, Off, UseErrorLevel
Hotkey, %KEY9%, gcar, On, UseErrorLevel
Hotkey, %KEY10%, Off, UseErrorLevel
Hotkey, %KEY10%, rep, On, UseErrorLevel
Hotkey, %KEY11%, vhod, On, UseErrorLevel
Hotkey, %KEY12%, resc, On, UseErrorLevel
Hotkey, %KEY13%, PunishmentHandler, On, UseErrorLevel
Hotkey, %KEY14%, memo, On, UseErrorLevel
Hotkey, %KEY15%, gh, On, UseErrorLevel
Hotkey, %KEY16%, chide, On, UseErrorLevel
Hotkey, %KEY17%, zzdebug, On, UseErrorLevel
Hotkey, %KEY18%, esp, On, UseErrorLevel
Hotkey, %KEY19%, killplayer, On, UseErrorLevel
Hotkey, %KEY20%, vetir, On, UseErrorLevel
Hotkey, %KeyTele%, Телепорты, On, UseErrorLevel
Hotkey, %KeyPunish%, Наказания, On, UseErrorLevel
Hotkey, %KeyAns%, Ответы, On, UseErrorLevel
Hotkey, %KeyCmd%, Команды, On, UseErrorLevel
Hotkey, %KeyGreet%, GreetLabel, On, UseErrorLevel
Hotkey, %KeyGo%, GoLabel, On, UseErrorLevel
Hotkey, %KeyWait%, WaitLabel, On, UseErrorLevel
Hotkey, %KeyPlay%, PlayLabel, On, UseErrorLevel

; --- НАСТРОЙКИ ОКНА ---
Gui, 2: Destroy
Gui, 2: +LastFound +E0x40000 -0xC00000 -0x80000
Gui, 2: Color, 11141A

; --- ШАПКА И СИСТЕМНЫЕ КНОПКИ ---
Gui, 2: Font, s11 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x20 y15 w400 h25 +0x200 BackgroundTrans, REGION HELPER

; Вывод версии (исправлен баг с двойной "vv.")
Gui, 2: Font, s8 Medium c64748B, Segoe UI
Gui, 2: Add, Text, x700 y17 w60 h20 +BackgroundTrans +Right, %Version%

; Кнопка СВЕРНУТЬ [ — ] (Стильная квадратная плитка)
Gui, 2: Font, s10 Bold c64748B, Segoe UI
Gui, 2: Add, Text, x805 y12 w26 h26 Center +0x200 Background1F242F hwndH_MinBtn gMinimizeMainGui, —

; Кнопка ЗАКРЫТЬ [ ✕ ] (Стильная квадратная плитка)
Gui, 2: Font, s8 Bold cEF4444, Segoe UI
Gui, 2: Add, Text, x845 y12 w26 h26 Center +0x200 Background1F242F hwndH_CloseBtn g2GuiClose, ✕

; Главная горизонтальная линия под шапкой
Gui, 2: Add, Progress, x20 y44 w860 h1 Background252D3A c252D3A, 100

; --- БОКОВОЕ МЕНЮ (Sidebar) ---
Gui, 2: Font, s8 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x20 y60 w120 h20, НАВИГАЦИЯ
Gui, 2: Add, Progress, x20 y77 w120 h1 Background252D3A c252D3A, 100

Gui, 2: Font, s9 Medium cD1D5DB, Segoe UI
Gui, 2: Add, Text, x20 y85 w120 h28 Center Background1F242F +0x200 gПомощь, Помощь
Gui, 2: Add, Text, x20 y120 w120 h28 Center Background1F242F +0x200 gТелепорты, Телепорты
Gui, 2: Add, Text, x20 y155 w120 h28 Center Background1F242F +0x200 gКоманды, Команды
Gui, 2: Add, Text, x20 y190 w120 h28 Center Background1F242F +0x200 gОтветы, Ответы
Gui, 2: Add, Text, x20 y225 w120 h28 Center Background1F242F +0x200 gНаказания, Наказания
Gui, 2: Add, Text, x20 y260 w120 h28 Center Background1F242F +0x200 gСокращения, Сокращения
Gui, 2: Add, Text, x20 y295 w120 h28 Center Background1F242F +0x200 gChangelog, Changelog 
Gui, 2: Add, Text, x20 y330 w120 h28 Center Background1F242F +0x200 gPamytka, Памятка ответов
; Добавлена новая кнопка, которая открывает меню ссылок (Gui, 15)
Gui, 2: Add, Text, x20 y365 w120 h28 Center Background1F242F +0x200 gLinksMenu, Полезные ссылки

; --- РАЗДЕЛ НАКАЗАНИЯ ---
Gui, 2: Font, s8 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x20 y410 w120 h20, НАКАЗАНИЯ 
Gui, 2: Add, Progress, x20 y427 w120 h1 Background252D3A c252D3A, 100

Gui, 2: Font, s9 Medium cD1D5DB, Segoe UI
Gui, 2: Add, Text, x20 y435 w120 h28 Center Background1F242F +0x200 gOpenPunishmentFile, Редактор наказаний

; Кнопка автоматической выдачи из файла
Gui, 2: Add, Text, x20 y470 w120 h28 Center Background1F242F +0x200 gPunishmentHandler, Выдать по списку


; --- ЦЕНТРАЛЬНЫЙ БЛОК (ГОРЯЧИЕ КЛАВИШИ) ---
Gui, 2: Font, s10 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x170 y60 w410 h25, ГОРЯЧИЕ КЛАВИШИ
Gui, 2: Add, Progress, x170 y82 w410 h1 Background252D3A c252D3A, 100

; Левая колонка биндов (list1)
Gui, 2: Font, s9 Medium cE2E8F0, Segoe UI
y_p := 95
list1 := [["Удалить транспорт", 2], ["GM", 3], ["ТП к игроку", 4], ["Быстрый репорт", 5], ["Быстрый ответ", 6], ["ТП на метку", 8], ["ТП авто к себе", 9], ["Добавить +1 репорт", 10]]
for i, item in list1 {
    vIdx := item[2], vName := "Hot" . vIdx
    ; Опции цвета и фона удалены из строки, за перекраску теперь отвечает OnMessage(0x0133)
    Gui, 2: Add, Hotkey, x170 y%y_p% w50 h24 v%vName%, % KEY%vIdx%
    Gui, 2: Add, Text, x230 y%y_p% w135 h24 +0x200 BackgroundTrans, % item[1]
    y_p += 31
}

; Правая колонка биндов (list2)
y_p := 95
list2 := [["Убить игрока", 19], ["Воскресить игрока", 12], ["ТП к себе", 15], ["Памятка", 14], ["Вкл/Выкл ESP", 18], ["/veh rs520", 20]]
for i, item in list2 {
    vIdx := item[2], vName := "Hot" . vIdx
    ; Опции цвета и фона удалены из строки, за перекраску теперь отвечает OnMessage(0x0133)
    Gui, 2: Add, Hotkey, x385 y%y_p% w50 h24 v%vName%, % KEY%vIdx%
    Gui, 2: Add, Text, x445 y%y_p% w135 h24 +0x200 BackgroundTrans, % item[1]
    y_p += 31
}

; --- ПРАВАЯ ПАНЕЛЬ ---
Gui, 2: Font, s10 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x610 y60 w270 h25, ПЕРСОНАЛИЗАЦИЯ
Gui, 2: Add, Progress, x610 y82 w270 h1 Background252D3A c252D3A, 100

Gui, 2: Font, s9 Medium cD1D5DB, Segoe UI
Gui, 2: Add, Text, x610 y95 w270 h30 Center Background1F242F +0x200 gdiscord, Установить Discord

Gui, 2: Add, Text, x610 y135 w130 h30 Center Background1F242F +0x200 gdiscordga, ДС ГА
Gui, 2: Add, Text, x750 y135 w130 h30 Center Background1F242F +0x200 gdiscordzga, ДС зГА

; Выбор разрешения
Gui, 2: Font, s9 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x610 y180 w270 h20, РАЗРЕШЕНИЕ ЭКРАНА
Gui, 2: Add, Progress, x610 y197 w270 h1 Background252D3A c252D3A, 100

Gui, 2: Font, s9 Medium cE2E8F0, Segoe UI
Gui, 2: Add, DropDownList, x610 y210 w270 vScreenRes gUpdateRes cE2E8F0 Background24282E, 2560x1440|2554x1411|1920x1080|1920x1080 (5:4)|1680x1050|1600x900|1440x900|1366x768|1366x768 (5:3)|1280x1024|1280x960
IniRead, SavedRes, Settings.ini, Settings, SelectedRes, 1920x1080
ScreenRes := SavedRes
GuiControl, 2: ChooseString, ScreenRes, %ScreenRes%

; Выбор гендера
Gui, 2: Font, s9 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x610 y255 w270 h20, ВАШ ПОЛ
Gui, 2: Add, Progress, x610 y272 w270 h1 Background252D3A c252D3A, 100

Gui, 2: Font, s9 Medium cE2E8F0, Segoe UI
Gui, 2: Add, Radio, x615 y285 w110 h20 Group vRadio3 Checked%Radio3% BackgroundTrans, Мужской
Gui, 2: Add, Radio, x735 y285 w110 h20 vRadio4 Checked%Radio4% BackgroundTrans, Женский

; --- ЦЕНТРАЛЬНЫЙ БЛОК: СТАТИСТИКА РЕПОРТОВ ---
Gui, 2: Font, s10 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x170 y375 w380 h25 +Center, 📊 СТАТИСТИКА РЕПОРТОВ
Gui, 2: Add, Progress, x170 y398 w380 h1 Background252D3A c252D3A, 100 

; Дневная статистика (Левая плашка)
Gui, 2: Add, Progress, x170 y405 w185 h45 Background1F242F c1F242F, 100
Gui, 2: Font, s22 Bold c00F2FE, Segoe UI
Gui, 2: Add, Text, x170 y405 w185 h45 +Center +0x200 BackgroundTrans vDayText, %DayANS%

; Недельная статистика (Правая плашка)
Gui, 2: Add, Progress, x365 y405 w185 h45 Background1F242F c1F242F, 100
Gui, 2: Font, s22 Bold cE2E8F0, Segoe UI
Gui, 2: Add, Text, x365 y405 w185 h45 +Center +0x200 BackgroundTrans vWeekText, %WeekANS%

; Подписи под плашками
Gui, 2: Font, s8 Bold c64748B, Segoe UI
Gui, 2: Add, Text, x170 y455 w185 +Center, ДЕНЬ
Gui, 2: Add, Text, x365 y455 w185 +Center, НЕДЕЛЯ

; --- РЯД УПРАВЛЕНИЯ И СБРОСА ---
; Кнопки управления счетчиками (Выровнены и распределены строго по центру под надписью "ДЕНЬ")
Gui, 2: Font, s16 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x220 y480 w25 h25 Center BackgroundTrans gAddRep, +
Gui, 2: Add, Text, x280 y480 w25 h25 Center BackgroundTrans gSubRep, -

; Кнопка Сброса (Строго по центру под надписью "НЕДЕЛЯ")
Gui, 2: Font, s9 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x365 y483 w185 h25 Center BackgroundTrans gResetStats, СБРОС СТАТИСТИКИ

; --- РЯД ОВЕРЛЕЯ И НАСТРОЙКИ ---
; Чекбокс оверлея (Слева, возвращен к x170 для ровного левого края блока)
Gui, 2: Font, s9 Medium cE2E8F0, Segoe UI
Gui, 2: Add, CheckBox, x170 y525 w90 h26 vShowOverlay gToggleOverlay Checked%ShowOverlay% BackgroundTrans, Оверлей

; Настройка позиции оверлея (Строго по центру под кнопкой сброса)
Gui, 2: Font, s9 Bold c64748B, Segoe UI
Gui, 2: Add, Text, x365 y527 w185 h25 Center BackgroundTrans gOpenOvSettings, Настроить позицию


; --- НИЖНИЙ БЛОК: АВТО-ВХОД ---
Gui, 2: Font, s10 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x610 y375 w270 h25, ⚙️ АВТО-ВХОД
Gui, 2: Add, Progress, x610 y398 w270 h1 Background252D3A c252D3A, 100

Gui, 2: Font, s9 Medium cE2E8F0, Segoe UI
Gui, 2: Add, Text, x610 y412 w60 h24 +0x200 BackgroundTrans, Клавиша:
; Из строки хоткея авто-входа также убраны параметры цвета
Gui, 2: Add, Hotkey, x675 y410 w205 h24 vHot11, %KEY11%

Gui, 2: Add, CheckBox, x610 y445 w85 h20 vRadio8 gSaveCheck Checked%Radio8% BackgroundTrans, /gm
Gui, 2: Add, CheckBox, x700 y445 w85 h20 vRadio9 gSaveCheck Checked%Radio9% BackgroundTrans, /esp 4
Gui, 2: Add, CheckBox, x610 y470 w85 h20 vRadio10 gSaveCheck Checked%Radio10% BackgroundTrans, /leader 5
Gui, 2: Add, CheckBox, x700 y470 w85 h20 vRadio11 gSaveCheck Checked%Radio11% BackgroundTrans, /hide

Gui, 2: Add, Progress, x610 y505 w270 h1 Background252D3A c252D3A, 100

Gui, 2: Font, s9 Bold c7F56D9, Segoe UI
Gui, 2: Add, Text, x610 y510 w270 h35 Center Background1F242F +0x200 gSaveData, СОХРАНИТЬ

Gui, 2: Font, s9 Bold c64748B, Segoe UI
Gui, 2: Add, Text, x610 y550 w270 h35 Center Background1F242F +0x200 gOpenKeySettings, ИЗМЕНИТЬ БИНДЫ

Gui, 2: Show, w900 h610, REGION HELPER
Gosub, CreateOverlay
Return

; ==============================================================================
; МЕТКИ ДЛЯ СИСТЕМНЫХ КНОПОК ШАПКИ
; ==============================================================================
MinimizeMainGui:
    Gui, 2: Minimize
return

; ==============================================================================
; СИСТЕМНЫЕ ФУНКЦИИ И ПЕРЕХВАТЧИКИ ИНТЕРФЕЙСА
; ==============================================================================
WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
    PostMessage, 0xA1, 2,,, ahk_id %hwnd%
}

WM_CTLCOLOR_MAIN_GUI(wParam, lParam) {
    critical
    static hBrush := 0
    if (!hBrush) {
        hBrush := DllCall("CreateSolidBrush", "UInt", 0x2E2824, "UPtr")
    }
    WinGetClass, ControlClass, ahk_id %lParam%
    if (ControlClass = "Edit" || ControlClass = "msctls_hotkey32" || ControlClass = "ComboBox") {
        DllCall("SetTextColor", "UPtr", wParam, "UInt", 0xF0E8E2)
        DllCall("SetBkColor", "UPtr", wParam, "UInt", 0x2E2824)
        DllCall("SetBkMode", "UPtr", wParam, "Int", 2)
        return hBrush
    }
}

; ==============================================================================
; --- ЛОГИКА И СИСТЕМНЫЕ ФУНКЦИИ (ОСТАВЛЕНЫ БЕЗ ИЗМЕНЕНИЙ) ---
; ==============================================================================

WinSet_Click_Through(I, T="254") {
    IfWinExist, % "ahk_id " I
    {
        If (T == "Off")
        {
            WinSet, AlwaysOnTop, Off, % "ahk_id " I
            WinSet, Transparent, Off, % "ahk_id " I
            WinSet, ExStyle, -0x20, % "ahk_id " I
        }
        Else
        {
            WinSet, AlwaysOnTop, On, % "ahk_id " I
            If(T < 0 || T > 254 || T == "On")
                T := 254
            WinSet, Transparent, % T, % "ahk_id " I
            WinSet, ExStyle, +0x20, % "ahk_id " I
        }
    }
    Else
        Return 0
}

; Создание прозрачного клик-через оверлея
Gui, +LastFound +ToolWindow
ID := WinExist()
Gui, Show, NoActivate, Hide x0 y0 w0 h0, Overlay
WinSet_Click_Through(ID, "On")
GuiControl,, Un-Clickable
CustomColor := "#00FF00"
return

UpdateRes:
    GuiControlGet, ScreenRes, 2:, ScreenRes 
    IniWrite, %ScreenRes%, Settings.ini, Settings, SelectedRes
    IniDelete, Settings.ini, Settings, ScreenRes
return

SaveData:
    Gui, 2: Submit, NoHide
    IniWrite, %ScreenRes%, Settings.ini, Settings, SelectedRes
    IniWrite, %Radio3%, Settings.ini, Settings, Male
    IniWrite, %Radio4%, Settings.ini, Settings, Female
    IniWrite, %Radio8%, Settings.ini, Settings, /gm
    IniWrite, %Radio9%, Settings.ini, Settings, /esp4
    IniWrite, %Radio10%, Settings.ini, Settings, /templeader 5
    IniWrite, %Radio11%, Settings.ini, Settings, /hide

    ; Сохранение всех Hotkeys циклом
    Loop, 20 {
        current_key := Hot%A_Index%
        IniWrite, %current_key%, Settings.ini, KeySetup, KEY%A_Index%
    }

    IniWrite, %qX%, Settings.ini, Coords, qX
    IniWrite, %qY%, Settings.ini, Coords, qY
    Gui, 2: Destroy
    Sleep, 100
    Reload
return

; --- СОХРАНЕНИЕ КООРДИНАТ ОВЕРЛЕЯ (Gui 3) ---
SaveData1:
    Gui, 3: Submit, NoHide
    IniWrite, %qX%, Settings.ini, Coords, qX
    IniWrite, %qY%, Settings.ini, Coords, qY
    Gui, 3: Destroy ; Плавное закрытие чит-листа перед перезапуском
    Reload
return

; --- СОХРАНЕНИЕ ДАННЫХ ВАШЕГО DISCORD (Gui 4) ---
SaveData2:
    Gui, 4: Submit, NoHide
    IniWrite, %qdis%, Settings.ini, Discord, qdis
    IniWrite, %qtag%, Settings.ini, Discord, qtag
    Gui, 4: Destroy ; Уничтожаем окно ввода вашего Discord ID
    Reload
return

; --- СОХРАНЕНИЕ ДИСКОРДА ГА (Gui 5) ---
SaveData3:
    Gui, 5: Submit, NoHide
    IniWrite, %gadis%, Settings.ini, Discord, gadis
    IniWrite, %gatag%, Settings.ini, Discord, gatag
    Gui, 5: Destroy ; Уничтожаем окно ввода Discord ID Главного Администратора
    Reload
return

; --- СОХРАНЕНИЕ ДИСКОРДА зГА (Gui 6) ---
SaveData4:
    Gui, 6: Submit, NoHide
    IniWrite, %zgadis%, Settings.ini, Discord, zgadis
    IniWrite, %zgatag%, Settings.ini, Discord, zgatag
    Gui, 6: Destroy ; Уничтожаем окно ввода Discord ID Зам. Главного Администратора
    Reload
return

; --- БЫСТРОЕ СОХРАНЕНИЕ ГЕНДЕРА (Без перезапуска скрипта) ---
SaveGender:
    Gui, 2: Submit, NoHide
    IniWrite, %Radio3%, Settings.ini, Settings, Male
    IniWrite, %Radio4%, Settings.ini, Settings, Female
return

ShortCommands:
Gui, 9: Destroy ; Предотвращает наложение при повторном открытии (номер изменен на 9)
Gui, 9: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 9: Color, 11141A ; Глубокий темно-синий/черный фон

; --- ГЛАВНЫЙ ЗАГОЛОВОК ---
Gui, 9: Font, s11 Bold c7F56D9, Segoe UI ; Фирменный фиолетовый цвет
Gui, 9: Add, Text, x10 y15 w430 +Center, ⚡ ПОЛНЫЙ СПИСОК КОМАНД
Gui, 9: Add, Progress, x20 y42 w410 h1 Background252D3A c252D3A, 100

; --- ТЕКСТОВЫЙ HTML БЛОК КОМАНД ---
Gui, 9: Add, ActiveX, x10 y50 w430 h415 vDoc, HTMLFile
Doc.write("
(
    <style>
        body { 
            background-color: #11141A; 
            color: #D1D5DB; 
            font-family: 'Segoe UI', sans-serif; 
            font-size: 13px; 
            margin: 10px 20px; 
            overflow-x: hidden; 
        }
        /* Фирменный стиль заголовков под разделы лаунчера */
        .header { 
            color: #7F56D9; 
            font-weight: bold; 
            border-bottom: 1px solid #252D3A; 
            margin-top: 18px; 
            margin-bottom: 6px; 
            padding-bottom: 3px; 
            text-transform: uppercase; 
            font-size: 11px; 
            letter-spacing: 0.5px;
        }
        .cmd-row { 
            margin-bottom: 4px; 
            display: block; 
            line-height: 1.5; 
        }
        /* Команды теперь подсвечиваются мягким неоновым цианом */
        .cmd { 
            color: #00F2FE; 
            font-family: 'Consolas', monospace; 
            font-weight: bold; 
        }
        .desc { 
            color: #E2E8F0; 
        }
    </style>
    
    <div class='header'>📍 Телепорты</div>
    <div class='cmd-row'><span class='cmd'>.мвд</span> — <span class='desc'>МВД</span></div>
    <div class='cmd-row'><span class='cmd'>.цгб</span> — <span class='desc'>ЦГБ</span></div>
    <div class='cmd-row'><span class='cmd'>.дпс</span> — <span class='desc'>ДПС</span></div>
    <div class='cmd-row'><span class='cmd'>.сми</span> — <span class='desc'>СМИ</span></div>
    <div class='cmd-row'><span class='cmd'>.армия</span> — <span class='desc'>Армия</span></div>

    <div class='header'>Семья и Организация</div>
    <div class='cmd-row'><span class='cmd'>/tf , .еа</span> — <span class='desc'>/tempfamily</span></div>
    <div class='cmd-row'><span class='cmd'>/sm , .ыь</span> — <span class='desc'>/setmaterials</span></div>
    <div class='cmd-row'><span class='cmd'>/cn , /ст</span> — <span class='desc'>/changename</span></div>
    <div class='cmd-row'><span class='cmd'>/kf , .ла</span> — <span class='desc'>/kickfrac</span></div>
    <div class='cmd-row'><span class='cmd'>.уьздуфвук , .ед , /tl</span> — <span class='desc'>/templeader</span></div>
    <div class='cmd-row'><span class='cmd'>.фгтшмшеу</span> — <span class='desc'>/auninvite</span></div>
    <div class='cmd-row'><span class='cmd'>.фгтсгаа / .фсгаа</span> — <span class='desc'>/auncuff / /acuff</span></div>

    <div class='header'>Наказания и Контроль</div>
    <div class='cmd-row'><span class='cmd'>.цфкт</span> — <span class='desc'>/warn</span></div>
    <div class='cmd-row'><span class='cmd'>/k , .л , .лшсл</span> — <span class='desc'>/kick</span></div>
    <div class='cmd-row'><span class='cmd'>.од , .гтофшд , .фофшд</span> — <span class='desc'>/jail / /unjail</span></div>
    <div class='cmd-row'><span class='cmd'>.ылшсл</span> — <span class='desc'>/skick</span></div>
    <div class='cmd-row'><span class='cmd'>.ифт / .рфквифт</span> — <span class='desc'>/ban / /hardban</span></div>
    <div class='cmd-row'><span class='cmd'>.ьгеу / .гтьгеу</span> — <span class='desc'>/mute / /unmute</span></div>

    <div class='header'>Транспорт</div>
    <div class='cmd-row'><span class='cmd'>.мур</span> — <span class='desc'>/veh</span></div>
    <div class='cmd-row'><span class='cmd'>/gc , .пс , .пуесфк</span> — <span class='desc'>/getcar</span></div>
    <div class='cmd-row'><span class='cmd'>.фку , .кузфшк</span> — <span class='desc'>/arepair / /repair</span></div>
    <div class='cmd-row'><span class='cmd'>.фкуз</span> — <span class='desc'>/repairvehrange</span></div>
    <div class='cmd-row'><span class='cmd'>.учсфк / .вудмур</span> — <span class='desc'>/excar / /delveh</span></div>
    <div class='cmd-row'><span class='cmd'>.агуд / .езсфк</span> — <span class='desc'>/fuel / /tpcar</span></div>
    <div class='cmd-row'><span class='cmd'>.згддекгтл / .вудшеуь</span> — <span class='desc'>/pulltunk / /delitem</span></div>
    <div class='cmd-row'><span class='cmd'>.scd , .ыуесфквшь</span> — <span class='desc'>/setcardim</span></div>
    <div class='cmd-row'><span class='cmd'>.ымд</span> — <span class='desc'>/setvehdim</span></div>

    <div class='header'>Слежка и Персонаж</div>
    <div class='cmd-row'><span class='cmd'>.шв , .иды</span> — <span class='desc'>/id / /ids</span></div>
    <div class='cmd-row'><span class='cmd'>.ез</span> — <span class='desc'>/tp | <span class='cmd'>.штсфк</span> — /incar</span></div>
    <div class='cmd-row'><span class='cmd'>.ызус , /sp , .ыз</span> — <span class='desc'>/spec</span></div>
    <div class='cmd-row'><span class='cmd'>.ызусщаа , .ыщ , /so</span> — <span class='desc'>/unspec (+Ins)</span></div>
    <div class='cmd-row'><span class='cmd'>.акууя , .акууяф</span> — <span class='desc'>/freez / /freeze</span></div>
    <div class='cmd-row'><span class='cmd'>.рз / .рф</span> — <span class='desc'>/hp</span></div>
    <div class='cmd-row'><span class='cmd'>/kill , .лшдд</span> — <span class='desc'>/hp 0</span></div>
    <div class='cmd-row'><span class='cmd'>.куысгу , .рес</span> — <span class='desc'>/rescue</span></div>
    <div class='cmd-row'><span class='cmd'>.штм</span> — <span class='desc'>/playerinv</span></div>

    <div class='header'>Общение и Мир</div>
    <div class='cmd-row'><span class='cmd'>.ку</span> — <span class='desc'>Приветствую.</span></div>
    <div class='cmd-row'><span class='cmd'>.ф</span> — <span class='desc'>/a (Admin Chat)</span></div>
    <div class='cmd-row'><span class='cmd'>.ьып</span> — <span class='desc'>/msg</span></div>
    <div class='cmd-row'><span class='cmd'>.ршву / .ср</span> — <span class='desc'>/hide / /chide</span></div>
    <div class='cmd-row'><span class='cmd'>.уыз / .пр</span> — <span class='desc'>/esp / /gh</span></div>
    <div class='cmd-row'><span class='cmd'>.пшв</span> — <span class='desc'>/gid</span></div>
    <div class='cmd-row'><span class='cmd'>.ыуевшь , /sd , .ыв</span> — <span class='desc'>/setdim</span></div>
    <div class='cmd-row'><span class='cmd'>.афк</span> — <span class='desc'>/a afk мин</span></div>
    <div class='cmd-row'><span class='cmd'>.умутещт / .умутещаа</span> — <span class='desc'>/eventon / off</span></div>
    <div class='cmd-row'><span class='cmd'>.фв / /ad / .фвьшты</span> — <span class='desc'>/admins</span></div>
    <div class='cmd-row'><span class='cmd'>.з / /p / .здфнукы</span> — <span class='desc'>/players</span></div>
    <div class='cmd-row'><span class='cmd'>.пь</span> — <span class='desc'>/gm</span></div>
    <div class='cmd-row'><span class='cmd'>.пиздец</span> — <span class='desc'>Сигнал SOS (Discord)</span></div>
)")

; --- НИЖНЯЯ ПАНЕЛЬ С КНОПКОЙ ---
Gui, 9: Font, s8 Medium c64748B, Segoe UI
Gui, 9: Add, Text, x20 y492 w120 h20 +0x200 +BackgroundTrans, Сборка: %Version%

Gui, 9: Font, s9 Bold c64748B, Segoe UI
Gui, 9: Add, Text, x140 y485 w170 h35 Center Background1F242F +0x200 gCloseShort, ПОНЯТНО

Gui, 9: Show, w450 h535, Справочник сокращений
return

CloseShort:
Gui, 9: Destroy
return

OpenOvSettings:
Gui, 11: Destroy
Gui, 11: +AlwaysOnTop -Caption +ToolWindow +LastFound +Owner2 ; Убран Caption для плоского вида
Gui, 11: Color, 11141A ; Глубокий темно-синий/черный фон

; Заголовок
Gui, 11: Font, s10 Bold c7F56D9, Segoe UI
Gui, 11: Add, Text, x10 y15 w180 h20 +Center, ПОЗИЦИЯ ОВЕРЛЕЯ
Gui, 11: Add, Progress, x20 y38 w160 h1 Background252D3A c252D3A, 100

; Текст описания и инпуты координат
Gui, 11: Font, s9 Medium cE2E8F0, Segoe UI
Gui, 11: Add, Text, x20 y52 w90 h24 +0x200, Координата X:
Gui, 11: Add, Edit, x110 y52 w70 h24 vovX gUpdatePos -E0x200, %ovX%

Gui, 11: Add, Text, x20 y87 w90 h24 +0x200, Координата Y:
Gui, 11: Add, Edit, x110 y87 w70 h24 vovY gUpdatePos -E0x200, %ovY%

; Кастомная плоская кнопка "Закрыть"
Gui, 11: Font, s9 Bold c64748B, Segoe UI
Gui, 11: Add, Text, x20 y125 w160 h30 Center Background1F242F +0x200 g11GuiClose, ЗАКРЫТЬ

; Размер окна скорректирован под новые отступы элементов
Gui, 11: Show, w200 h170, Настройка X/Y
return

11GuiClose:
Gui, 11: Destroy
return

; === ЛОГИКА ИГРОВОГО ОВЕРЛЕЯ (GUI 10) ===
CreateOverlay:
Gui, 10: Destroy
if (ShowOverlay = 0)
    return

; --- НАСТРОЙКИ СТИЛЯ (Компактная темная плашка) ---
Gui, 10: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 10: Color, 11141A ; Оригинальный фон лаунчера

; Прозрачность и скругление углов (Ширина расширена до 190px для крупных чисел)
WinSet, Transparent, 220 
WinSet, Region, 0-0 w190 h28 R10-10 

; Блок ДЕНЬ
Gui, 10: Font, s8 Medium c64748B, Segoe UI ; Приглушенный серый для подписей
Gui, 10: Add, Text, x12 y6 w32 h20 +0x200 BackgroundTrans, День:

Gui, 10: Font, s9 Bold c00F2FE, Segoe UI ; Насыщенный неоновый циан для цифры дня
; w35 позволяет числу свободно расти до 999 без обрезания
Gui, 10: Add, Text, x+3 y5 w35 h20 +0x200 BackgroundTrans vOvDay, %DayANS%

; Блок НЕДЕЛЯ (Позиционируется автоматически относительно цифры дня благодаря x+12)
Gui, 10: Font, s8 Medium c64748B, Segoe UI
Gui, 10: Add, Text, x+12 y6 w45 h20 +0x200 BackgroundTrans, Неделя:

Gui, 10: Font, s9 Bold cE2E8F0, Segoe UI ; Мягкий белый для цифры недели
Gui, 10: Add, Text, x+3 y5 w35 h20 +0x200 BackgroundTrans vOvWeek, %WeekANS%

; Показываем оверлей в заданных координатах (Размер w190 синхронизирован с регионом)
Gui, 10: Show, x%ovX% y%ovY% w190 h28 NoActivate
WinSet, ExStyle, +0x20 ; Полностью сквозной клик (не мешает стрелять в игре)
return

; ==============================================================================
; ФУНКЦИЯ ПЕРЕХВАТА И ОКРАСКИ ПОЛЕЙ ВВОДА ДЛЯ ОКНА НАСТРОЕК Gui, 11
; ==============================================================================
WM_CTLCOLOR_OV_SETTINGS(wParam, lParam) {
    critical
    static hBrush := 0
    if (!hBrush) {
        ; Создаем темную кисть BGR для фона инпутов (#24282E)
        hBrush := DllCall("CreateSolidBrush", "UInt", 0x2E2824, "UPtr")
    }
    
    WinGetClass, ControlClass, ahk_id %lParam%
    if (ControlClass = "Edit") {
        DllCall("SetTextColor", "UPtr", wParam, "UInt", 0xF0E8E2) ; Светлый текст #E2E8F0
        DllCall("SetBkColor", "UPtr", wParam, "UInt", 0x2E2824)   ; Темный фон #24282E
        DllCall("SetBkMode", "UPtr", wParam, "Int", 2)
        return hBrush
    }
}

; === ОБРАБОТЧИКИ СОБЫТИЙ ===

UpdatePos:
    Gui, 11: Submit, NoHide
    ; Принудительно очищаем от пробелов и делаем проверку на числа
    ovX := Trim(ovX), ovY := Trim(ovY)
    currentX := (ovX = "" || ovX < 0) ? 0 : ovX
    currentY := (ovY = "" || ovY < 0) ? 0 : ovY
    
    IniWrite, %currentX%, Settings.ini, Counter, ovX
    IniWrite, %currentY%, Settings.ini, Counter, ovY
    
    if (ShowOverlay)
        Gui, 10: Show, x%currentX% y%currentY% NoActivate
return

ToggleOverlay:
    Gui, 2: Submit, NoHide
    IniWrite, %ShowOverlay%, Settings.ini, Counter, ShowOverlay
    Gosub, CreateOverlay
return

AddRep:
    ; Преобразуем в чистый числовой формат перед математическим действием
    DayANS := Abs(DayANS) + 1
    WeekANS := Abs(WeekANS) + 1
    Gosub, UpdateStatsUI
return

SubRep:
    ; Преобразуем в чистый числовой формат перед проверкой
    DayANS := Abs(DayANS)
    WeekANS := Abs(WeekANS)
    if (DayANS > 0)
    {
        DayANS -= 1
        WeekANS -= 1
        Gosub, UpdateStatsUI
    }
return

UpdateStatsUI:
    ; Явно преобразуем переменные в числа, чтобы убрать возможные скрытые символы
    DayANS := DayANS + 0
    WeekANS := WeekANS + 0

    ; Обновляем цифры в главном меню
    GuiControl, 2:, DayText, %DayANS%
    GuiControl, 2:, WeekText, %WeekANS%
    
    ; Обновляем оверлей (Gui 10), если он включен
    if (ShowOverlay) {
        GuiControl, 10:, OvDay, %DayANS%
        GuiControl, 10:, OvWeek, %WeekANS%
    }
    
    ; Сохраняем в INI
    IniWrite, %DayANS%, Settings.ini, Counter, DayANS
    IniWrite, %WeekANS%, Settings.ini, Counter, WeekANS
return

; --- КАСТОМНОЕ ОКНО ПОДТВЕРЖДЕНИЯ СБРОСА СТАТИСТИКИ ---
ResetStats:
    Gui, ResetGui: Destroy
    Gui, ResetGui: +AlwaysOnTop -Caption +ToolWindow +LastFound
    Gui, ResetGui: Color, 11141A ; Глубокий темный фон

    Gui, ResetGui: Font, s10 Bold c7F56D9, Segoe UI
    Gui, ResetGui: Add, Text, x10 y15 w380 +Center, СБРОС СТАТИСТИКИ
    Gui, ResetGui: Add, Progress, x20 y38 w360 h1 Background252D3A c252D3A, 100

    Gui, ResetGui: Font, s9 Medium cE2E8F0, Segoe UI
    Gui, ResetGui: Add, Text, x10 y55 w380 +Center, Выберите тип сброса собираемой статистики:

    ; Кнопка 1: Только день (Оранжевый/Желтый акцент)
    Gui, ResetGui: Font, s8 Bold cD97706, Segoe UI 
    Gui, ResetGui: Add, Text, x20 y95 w110 h30 Center Background1F242F +0x200 gResetDayOnly, ТОЛЬКО ДЕНЬ

    ; Кнопка 2: Полный сброс (Красный акцент)
    Gui, ResetGui: Font, s8 Bold cEF4444, Segoe UI 
    Gui, ResetGui: Add, Text, x145 y95 w110 h30 Center Background1F242F +0x200 gConfirmReset, ПОЛНЫЙ СБРОС

    ; Кнопка 3: Отмена (Серый акцент)
    Gui, ResetGui: Font, s8 Bold c64748B, Segoe UI 
    Gui, ResetGui: Add, Text, x270 y95 w110 h30 Center Background1F242F +0x200 gCancelReset, ОТМЕНА

    ; Ширина окна увеличена до 400, чтобы три кнопки встали в один ряд
    Gui, ResetGui: Show, w400 h145, ResetConfirm
return

ResetDayOnly:
    DayANS := 0
    Gosub, UpdateStatsUI
    Gui, ResetGui: Destroy
return

; Вариант 2: Полный сброс (День + Неделя)
ConfirmReset:
    DayANS := 0
    WeekANS := 0
    Gosub, UpdateStatsUI
    Gui, ResetGui: Destroy
return

; Вариант 3: Закрытие окна без изменений
CancelReset:
    Gui, ResetGui: Destroy
return

; Метки для кнопок навигации
Сокращения:
    if (A_ThisLabel = "Сокращения")
        Gosub, ShortCommands
return

SaveData11:
    Gui, 11: Submit, NoHide
    IniWrite, %ovX%, Settings.ini, Counter, ovX
    IniWrite, %ovY%, Settings.ini, Counter, ovY
    Gui, 11: Destroy ; Закрываем окно перед перезапуском, чтобы оно не висло на экране
    Reload
return

2GuiClose:
    ExitApp

;; Памятка
memo:
State2:=!State2
If state2
{
CustomColor2 = 	EEAA99
Gui 3: +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui 3: Color, black
Gui 3: Font, s8
Gui 3: Font, w3000
Gui 3: Font, cFFFFFF
Gui 3: Add, Text,, =================================================================================================================================================================================================================================================================================================================================================================================
; --- НАСТРОЙКИ СТИЛЯ ОКНА ЧИТ-ЛИСТА ---
Gui 3: Destroy
Gui 3: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui 3: Color, 11141A ; Глубокий темно-синий/черный фон лаунчера
Gui 3: Font, s9 Medium, Segoe UI

; Установка полупрозрачности (190 из 255) — игра отлично видна на заднем плане
WinSet, Transparent, 190

; ================= БЛОК 1: ЧАСТЫЕ НАРУШЕНИЯ =================
Gui 3: Font, s10 Bold c7F56D9
Gui 3: Add, Text, x20 y15 w490, 🧱 ЧАСТЫЕ НАРУШЕНИЯ
Gui 3: Add, Progress, x20 y38 w490 h1 Background252D3A c252D3A, 100

; Разделение на названия (cE2E8F0) и сроки (c94A3B8)
Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y48, 🔴 DM п.4.9 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x130 y48, Gunban 60-360ч / Dmg 50-120м / WARN / Ban 1-30д

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y71, 🚗 DB п.4.3 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x125 y71, Demorgan 30-120 м. / WARN / Ban 1-10 д.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y94, 👤 NRP п.4.1 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x135 y94, Demorgan 30-90 м. / WARN / Ban 3-15д

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y117, 🦖 PG п. 4.7 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x130 y117, Demorgan 50-120 м. / WARN / Ban 3-10 д.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y140, 🏠 SK п.4.6 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x130 y140, GunBan 60-360м / Dmg 30-120м / WARN / Ban 1-30д

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y163, 🚜 NRD п.4.2 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x135 y163, Demorgan 10 - 120 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y186, 🚪 Уход от RP 4.14:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x140 y186, Dmg 30-90 / WARN / Ban 3-10 д.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y209, 🔊 Громкие звуки 3.8:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x155 y209, Mute 10 - 50 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y232, 🎵 Музыка в ЗЗ 1.5:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x145 y232, Mute 20 - 60 м.


; ================= БЛОК 2: ОТЫГРОВКИ / АДМ / ЧАТЫ =================
Gui 3: Font, s10 Bold c7F56D9
Gui 3: Add, Text, x535 y15 w490, 💬 ОТЫГРОВКИ / АДМ / ЧАТЫ
Gui 3: Add, Progress, x535 y38 w490 h1 Background252D3A c252D3A, 100

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y48, 🎭 Оск.отыгровки 5.2 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x685 y48, Demorgan 10 - 30 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y71, 🤥 Обман в /do 5.1 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x665 y71, Demorgan 10-30 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y94, 🧧 Отыгрыш в свою пользу 5.1.2:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x725 y94, Demorgan 20-60 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y117, 🛑 Помеха адм. 4.18 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x680 y117, Kick / Dmg 10-90 м. / Ban 1-10 д.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y140, 🛠 Обман администрации:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x695 y140, [ В разработке ]

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y163, 🤬 Оск. адм. 3.7 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x660 y163, Mute 60-90 м. / Ban / Hard 5-30 д.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y186, 🧑‍🎤 Трап 2.3 / Non-RP ник 2.6:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x715 y186, Dmg 720 м. (до смены)

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y209, ✉️ Спам/флуд в чат 3.5 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x695 y209, Mute 10 - 40 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y232, 🌐 OOC in IC 3.12 ОП:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x670 y232, Mute 10-50м / Dmg 30-60м / Ban 1-5д


; ================= БЛОК 3: КРИМИНАЛЬНЫЕ НАРУШЕНИЯ =================
Gui 3: Font, s10 Bold c7F56D9
Gui 3: Add, Text, x1050 y15 w490, 🥷 КРИМИНАЛЬНЫЕ НАРУШЕНИЯ
Gui 3: Add, Progress, x1050 y38 w490 h1 Background252D3A c252D3A, 100

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y48, 🛑 3.4 ПОиП (ТС < 2 чел/2 ТС):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1240 y48, Dmg 10-30м

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y71, 👥 3.2 ПОиП (Меньше 2х граб.):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1245 y71, Dmg 10-30 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y94, ⛓ 2.1 ПОиП (Меньше 6 похит.):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1245 y94, Dmg 20-60 / WARN

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y117, 🧎 3.7 ПОиП (Унижение жертвы):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1260 y117, Mute 30-60 м. / Dmg 10-30 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y140, 💵 3.1 ПОиП (Ограб не через функц):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1280 y140, Dmg 30-90 м. / Warn

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y163, 👕 1.2 ПСО (Одежда не цвет фамы):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1285 y163, Dmg 30-50 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y186, 🚘 1.3.1 ПОиП (Авто не в цвет):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1270 y186, Dmg 10-30 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y209, 🏃 1.4 ПиЗ (Уход в ЗЗ):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1210 y209, Demorgan 20-90 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y232, ◽ [ Свободная строка ]


; ================= БЛОК 4: СПЕЦИАЛЬНЫЕ / ГОС / ТУЛЕВО =================
Gui 3: Font, s10 Bold c7F56D9
Gui 3: Add, Text, x20 y275 w1520, ⚖️ СПЕЦИАЛЬНЫЕ / ГОС / ТУЛЕВО
Gui 3: Add, Progress, x20 y298 w1520 h1 Background252D3A c252D3A, 100

; Левый подстолбец
Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y310, 🌍 3.3 ОП (Соц/Гендер):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x165 y310, Mute 30-240 / Dmg 30-120 / Ban 3-15

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y333, 👪 3.4 ОП (Оск родни):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x165 y333, Dmg 30-120 / Ban 3-15 д.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x25 y356, 📑 1.3 ПГО (Злоуп функц):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x165 y356, Dmg 30-90 / Warn / Ban / Hard 1-30д

; Центральный подстолбец
Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y310, 🏃 Стрельба по пешим 4.17:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x710 y310, GunBan 60-180 м. / Dmg 30-90 м.

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y333, 🎯 Стрельба в ЗЗ 1.2 ПиЗЗ:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x710 y333, GunBan 1-3 ч. / Dmg 20-60 / Ban 3-15

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x540 y356, 💻 Читы / Софт голос 3.9:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x705 y356, HardBan 9999 д. / Mute 30-120

; Правый подстолбец
Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y310, 🪪 1.4 ПГО (Жетон):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1175 y310, Dmg 15-30м | 1.8 Патруль личка: Dmg 15м

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y333, 🗣 1.16 ПГО (Оск игроков):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1205 y333, Mute 30-60 / Dmg 10-40 / Warn

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y356, 🎭 1.16.1 Bad Cop:
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1175 y356, Dmg 30-90/Warn | 1.7 Взятка: Dmg 40-80/Warn

Gui 3: Font, s9 Medium cE2E8F0
Gui 3: Add, Text, x1055 y379, 🎖 1.17 ПГО (Треб.Жетон):
Gui 3: Font, s9 Medium c94A3B8
Gui 3: Add, Text, x1200 y379, Dmg 40 м. / Ban 1-5д.


; --- ПОЗИЦИОНИРОВАНИЕ В ЛЕВЫЙ НИЖНИЙ УГОЛ ---
SysGet, Mon, MonitorWorkArea
GuiWidth := 1560
GuiHeight := 415
YPos := MonBottom - GuiHeight

Gui 3: Show, x0 y%YPos% w%GuiWidth% h%GuiHeight% NoActivate, ЧитЛист
return
=================================================================================================================================================================================================================================================================================================================================================================================

}
Else
Gui 3: Destroy
Return
vetir:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /veh rs520{Enter}
Return
dl:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /dl{Enter}
return
tp:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /tp{space}
return
inv:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /inv{Enter}
return

OpenKeySettings:
Gui, 7: Destroy ; Перестраховка от наложения окон
Gui, 7: New, +AlwaysOnTop -Caption +ToolWindow +LastFound ; Убран Caption для плоского вида
Gui, 7: Color, 11141A ; Глубокий темно-синий/черный фон

; --- ГЛАВНЫЙ ЗАГОЛОВОК ---
Gui, 7: Font, s11 Bold c7F56D9, Segoe UI
Gui, 7: Add, Text, x20 y15 w360 +Center, ⚡ ИЗМЕНИТЬ БИНДЫ КЛАВИШ
Gui, 7: Add, Progress, x20 y42 w360 h1 Background252D3A c252D3A, 100

; --- СИСТЕМНЫЕ ОКНА ---
Gui, 7: Font, s8 Bold c7F56D9, Segoe UI
Gui, 7: Add, Text, x20 y55 w360, [ ВЫЗОВ ИНТЕРФЕЙСОВ ]
Gui, 7: Add, Progress, x20 y72 w360 h1 Background252D3A c252D3A, 100

; Возвращаем шрифт для инпутов и текста
Gui, 7: Font, s9 Medium cE2E8F0, Segoe UI
Gui, 7: Add, Text, x25 y85 w85 h20 +0x200, Телепорты:
Gui, 7: Add, Hotkey, x110 y82 w80 h24 vNewKeyTele cE2E8F0 Background24282E, %KeyTele%

Gui, 7: Add, Text, x215 y85 w85 h20 +0x200, Команды:
Gui, 7: Add, Hotkey, x295 y82 w80 h24 vNewKeyCmd cE2E8F0 Background24282E, %KeyCmd%

Gui, 7: Add, Text, x25 y115 w85 h20 +0x200, Ответы:
Gui, 7: Add, Hotkey, x110 y112 w80 h24 vNewKeyAns cE2E8F0 Background24282E, %KeyAns%

Gui, 7: Add, Text, x215 y115 w85 h20 +0x200, Наказания:
Gui, 7: Add, Hotkey, x295 y112 w80 h24 vNewKeyPunish cE2E8F0 Background24282E, %KeyPunish%


; --- БЫСТРЫЕ ФРАЗЫ ---
Gui, 7: Font, s8 Bold c7F56D9, Segoe UI
Gui, 7: Add, Text, x20 y160 w360, [ БЫСТРЫЕ ОТВЕТЫ В ЧАТ ]
Gui, 7: Add, Progress, x20 y177 w360 h1 Background252D3A c252D3A, 100

Gui, 7: Font, s9 Medium cE2E8F0, Segoe UI
Gui, 7: Add, Text, x25 y190 w180 h20 +0x200, Приветствие + /tp:
Gui, 7: Add, Hotkey, x220 y187 w155 h24 vNewKeyGreet cE2E8F0 Background24282E, %KeyGreet%

Gui, 7: Add, Text, x25 y225 w180 h20 +0x200, Иду на помощь:
Gui, 7: Add, Hotkey, x220 y222 w155 h24 vNewKeyGo cE2E8F0 Background24282E, %KeyGo%

Gui, 7: Add, Text, x25 y260 w180 h20 +0x200, Ожидайте помощь:
Gui, 7: Add, Hotkey, x220 y257 w155 h24 vNewKeyWait cE2E8F0 Background24282E, %KeyWait%

Gui, 7: Add, Text, x25 y295 w180 h20 +0x200, Приятной игры:
Gui, 7: Add, Hotkey, x220 y292 w155 h24 vNewKeyPlay cE2E8F0 Background24282E, %KeyPlay%

; --- КНОПКИ НАВИГАЦИИ (ПЛОСКИЕ ТЕКСТОВЫЕ ПЛАШКИ) ---
Gui, 7: Font, s10 Bold c7F56D9, Segoe UI ; Сохранить — Фиолетовый акцент
Gui, 7: Add, Text, x20 y420 w220 h35 Center Background1F242F +0x200 gSaveSystemKeys, СОХРАНИТЬ

Gui, 7: Font, s10 Bold c64748B, Segoe UI ; Отмена/Закрыть — Серый цвет
Gui, 7: Add, Text, x255 y420 w125 h35 Center Background1F242F +0x200 gCloseBind, ЗАКРЫТЬ

; Показываем готовое центрированное окно (h475 подогнано под отступы кнопок)
Gui, 7: Show, w400 h475, Настройка биндов
return

CloseBind:
Gui, 7: Destroy
return

; --- ВАШ DISCORD ---
discord:
Gui, 4: Destroy
Gui, 4: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 4: Color, 11141A

Gui, 4: Font, s10 Bold c7F56D9, Segoe UI
Gui, 4: Add, Text, x20 y15 w210 h20 +Center, ВАШ ДИСКОРД
Gui, 4: Add, Progress, x20 y38 w210 h1 Background252D3A c252D3A, 100

Gui, 4: Font, s8 Medium c64748B, Segoe UI
Gui, 4: Add, Text, x20 y48 w210 h15, Введите ваш Discord ID:

Gui, 4: Font, s9 Medium cE2E8F0, Segoe UI
; Изменена высота h24 и положение y65 для идеального выравнивания текста
Gui, 4: Add, Edit, x20 y65 w210 h24 vqdis -E0x200, %qdis%

Gui, 4: Font, s9 Bold c7F56D9, Segoe UI
; Кнопка выровнена строго под Edit, высота h32
Gui, 4: Add, Text, x20 y105 w210 h32 Center Background1F242F +0x200 gSaveData2, СОХРАНИТЬ

; Размер окна скорректирован для симметричных отступов со всех сторон
Gui, 4: Show, w250 h155, My Discord
return


; --- ДАННЫЕ ГА ---
discordga:
Gui, 5: Destroy
Gui, 5: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 5: Color, 11141A

Gui, 5: Font, s10 Bold c7F56D9, Segoe UI
Gui, 5: Add, Text, x20 y15 w210 h20 +Center, ДАННЫЕ ГА
Gui, 5: Add, Progress, x20 y38 w210 h1 Background252D3A c252D3A, 100

Gui, 5: Font, s8 Medium c64748B, Segoe UI
Gui, 5: Add, Text, x20 y48 w210 h15, Введите ID Главного Адм.:

Gui, 5: Font, s9 Medium cE2E8F0, Segoe UI
Gui, 5: Add, Edit, x20 y65 w210 h24 vgadis -E0x200, %gadis%

Gui, 5: Font, s9 Bold c7F56D9, Segoe UI
Gui, 5: Add, Text, x20 y105 w210 h32 Center Background1F242F +0x200 gSaveData3, СОХРАНИТЬ

Gui, 5: Show, w250 h155, Admin GA
return


; --- ДАННЫЕ зГА ---
discordzga:
Gui, 6: Destroy
Gui, 6: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 6: Color, 11141A

Gui, 6: Font, s10 Bold c7F56D9, Segoe UI
Gui, 6: Add, Text, x20 y15 w210 h20 +Center, ДАННЫЕ зГА
Gui, 6: Add, Progress, x20 y38 w210 h1 Background252D3A c252D3A, 100

Gui, 6: Font, s8 Medium c64748B, Segoe UI
Gui, 6: Add, Text, x20 y48 w210 h15, Введите ID Зам. Гл. Адм.:

Gui, 6: Font, s9 Medium cE2E8F0, Segoe UI
Gui, 6: Add, Edit, x20 y65 w210 h24 vzgadis -E0x200, %zgadis%

Gui, 6: Font, s9 Bold c7F56D9, Segoe UI
Gui, 6: Add, Text, x20 y105 w210 h32 Center Background1F242F +0x200 gSaveData4, СОХРАНИТЬ

Gui, 6: Show, w250 h155, Admin zGA
return

; ==============================================================================
; УНИВЕРСАЛЬНАЯ ФУНКЦИЯ ПЕРЕХВАТА ОКРАСКИ EDIT-ПОЛЕЙ И СТАТИЧЕСКИХ ЭЛЕМЕНТОВ
; ==============================================================================
WM_CTLCOLOR_EDIT_AND_STATIC(wParam, lParam) {
    critical
    static hBrush := 0
    if (!hBrush) {
        ; Создаем сплошную темную кисть в формате BGR (0x2E2824 соответствует цвету #24282E)
        hBrush := DllCall("CreateSolidBrush", "UInt", 0x2E2824, "UPtr")
    }
    
    ; Проверяем класс элемента управления, чтобы красить ТОЛЬКО поля Edit
    WinGetClass, ControlClass, ahk_id %lParam%
    if (ControlClass = "Edit") {
        DllCall("SetTextColor", "UPtr", wParam, "UInt", 0xF0E8E2)       ; Цвет текста BGR (#E2E8F0)
        DllCall("SetBkColor", "UPtr", wParam, "UInt", 0x2E2824)         ; Цвет подложки букв BGR (#24282E)
        DllCall("SetBkMode", "UPtr", wParam, "Int", 2)                  ; OPAQUE режим отрисовки фона
        return hBrush
    }
}

PunishmentHandler:
    ; Проверяем, существует ли физически файл с наказаниями (сначала проверяем файл, чтобы сэкономить время)
    if (!FileExist(A_WorkingDir . "\Punishment.txt")) {
        MsgBox, 16, Ошибка, Файл Punishment.txt не найден в папке со скриптом!
        return
    }

    ; Универсальная проверка: запущена ли игра (ищет любое окно GTA V, RAGE MP или Alt:V)
    if (WinExist("ahk_class容Grand Theft Auto V") || WinExist("ahk_exe GTA5.exe") || WinExist("ahk_exe RAGEMP.exe"))
    {
        ; Активируем окно игры и жестко ждем, пока оно станет активным
        WinActivate
        WinWaitActive, , , 2
        if (ErrorLevel) {
            MsgBox, 16, Ошибка, Не удалось переключить фокус на окно игры!
            return
        }

        ; Сохраняем текущее содержимое вашего буфера обмена, чтобы не стереть личные скопированные данные
        OldClip := ClipboardAll

        ; Читаем текстовый файл Punishment.txt построчно
        Loop, read, %A_WorkingDir%\Punishment.txt
        {
            ; Пропускаем пустые строки
            if (A_LoopReadLine = "")
                continue

            Loop, parse, A_LoopReadLine, %A_Tab%
            {
                ; Открываем чат игры (отправляем 't'). Запуск от имени Администратора решает проблему блокировки клавиши.
                SendInput, {t}
                Sleep, 200 ; Задержка на открытие чата игры

                ; Помещаем команду наказания в буфер обмена
                Clipboard := A_LoopField
                ClipWait, 1 ; Ждем 1 секунду, пока текст точно запишется в память Windows

                ; Вставляем команду в чат через эмуляцию Ctrl + V
                SendInput, ^{v}
                Sleep, 100 ; Фиксируем вставку текста в поле

                ; Отправляем команду на сервер нажатием Enter
                SendInput, {Enter}
                
                ; Антифлуд-задержка 1.2 секунды перед следующей строкой
                Sleep, 1200 
            }
        }

        ; Восстанавливаем ваш личный буфер обмена обратно
        Clipboard := OldClip
        OldClip := ""

        MsgBox, 64, Выдача наказаний, Все наказания из файла успешно выданы.
    }
    else
    {
        MsgBox, 16, Ошибка, Игра не найдена! Убедитесь, что окно GTA V или RAGE MP запущено.
    }
return

gcar:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /getcar{Space}
return
gm:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /gm{Enter}
return
resc:
SendInput, {sc14}
Sleep 50
SendInput, /rescue{Space}
return
gh:
SendInput, {sc14}
Sleep 50
SendInput, /gh{Space}
return
chide:
SendInput, {sc14}
Sleep 50
SendInput, /chide{Enter}
zzdebug:
SendInput, {sc14}
Sleep 50
SendInput, /zzdebug{Enter}
return
gtar:
Process, Exist, GTA5.exe
return
dorab:
MsgBox, 64, Ошибка,Функция на доработке.
return
mtp:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /mtp{Enter}
return
vhod:
SendMessage, 0x50,, 0x4090409 ; Ставим англ. раскладку
; Мы используем проверку MasterSwitch, если он есть
if (MasterSwitch == 0)
    return

; Проверка ESP
if (Radio9 == 1) {
    SendInput, {T}/esp 4{Enter}
    Sleep 400
}

; Проверка HIDE
if (Radio11 == 1) {
    SendInput, {T}/hide{Enter}
    Sleep 400
}

; Проверка GM 
if (Radio8 == 1) {
    SendInput, {T}/gm{Enter}
    Sleep 400
}

; Проверка LEADER
if (Radio10 == 1) {
    SendInput, {T}/templeader 5{Enter}
    Sleep 400
}
return

;Телепорты
:?:.мвд::/tpc 560.706 5962.073 11.719
:?:.цгб::/tpc -581.273 7196.846 6.796
:?:.дпс::/tpc -1236.235 5823.474 11.839
:?:.сми::/tpc -246.499 7000.819 4.248
:?:.мфц::/tpc -399.227 4579.225 4.700
:?:.банк::/tpc -389.053 6672.802 3.837
:?:.азс::/tpc -504.776 6708.471 4.508
:?:.247::/tpc -504.776 6708.471 4.508
:?:.тату::/tpc 98.299 5222.805 4.214
:?:.барбер::/tpc -264.435 5275.946 6.082
:?:.парк::/tpc -2383.074 6346.012 5.093
:?:.апт::/tpc -500.745 4992.870 8.004
:?:.авита::/tpc -1486.624 6602.413 4.976
:?:.тсклад::/tpc 3589.537 -3949.451 34.880
:?:.завод::/tpc 6428.458 -2291.381 41.528
:?:.автобус::/tpc 285.565 4583.576 6.637
:?:.дально::/tpc -2821.181 5770.997 8.382
:?:.дально1::/tpc 5541.948 -3835.776 41.546
:?:.цгбт::/tpc 4725.533 -3228.460 39.193
:?:.автош::/tpc -532.233 6978.211 5.725
:?:.билайф::/tpc -41.734 5125.277 5.732
:?:.такси::/tpc -1285.487 6445.054 6.144
:?:.такси1::/tpc 5796.750 -3309.108 40.729
:?:.ад::/tpc -2428 -3885 279
:?:.вч::/tpc 4607.988 2761.864 20.549
:?:.казик::/tpc -802.142 5875.973 4.400
:?:.вказик::/tpc -3164.793 -4373.473 116.041

; Команды
:?:/tf::/tempfamily
:?:.еа::/tempfamily
:?:/sm::/setmaterials
:?:.ыь::/setmaterials
:?:/cn::/changename
:?:/ст::/changename
:?:.гтофшд::/unjail
:?:.цфкт::/warn
:?:/k::/kick
:?:.л::/kick
:?:/kf::/kickfrac
:?:.ла::/kickfrac
:?:.пь::/gm
:?:.гтьгеу::/unmute
:?:.иды::/ids
:?:.фвьшты::/admins
:?:.умутещт::/eventon
:?:.умутещаа::/eventoff
:?:.мур::/veh
:?:.фку::/arepair
:?:.фкуз::/repairvehrange
:?:.уьздуфвук::/templeader
:?:/tl::/templeader
:?:.ед::/templeader
:?:.фгтшмшеу::/auninvite
:?:.учсфк::/excar
:?:.агуд::/fuel
:?:.акууя::/freez
:?:.езсфк::/tpcar
:?:.вудшеуь::/delitem
:?:/gc::/getcar
:?:.пс::/getcar
:?:.фв::/admins
:?:/ad::/admins
:?:.з::/players
:?:/p::/players
:?:.здфнукы::/players
:?:.рес::/rescue
:?:.ез::/tp
:?:.ызус::/spec
:?:.ызусщаа::/unspec {Enter} {Ins}
:?:.ьып::/msg
:?:.ку::
    ; 1. Сразу стираем введенные символы ".ку" из строки чата
    SendInput, {Backspace 3}
    
    ; 2. Сохраняем текущее содержимое буфера обмена хелпера, чтобы не стереть его личные данные
    OldClipboard := ClipboardAll
    
    ; 3. Помещаем чистый текст приветствия в буфер обмена
    Clipboard := "Приветствую."
    ClipWait, 1 ; Ожидаем, пока текст точно запишется в память
    
    ; 4. Вставляем текст в чат через эмуляцию нажатия Ctrl + V и отправляем через Enter
    SendInput, ^{v}{Space}
    
    ; 5. Восстанавливаем старый буфер обмена хелпера обратно
    Clipboard := OldClipboard
    OldClipboard := ""
    
    ; 6. Прибавляем +1 к статистике репортов
    Gosub, AddRep 
return
:?:.ф::/a
:?:/sp::/spec
:?:.ыз::/spec
:?:/so::/unspec {Enter} {Ins}
:?:.ыщ::/unspec {Enter} {Ins}
:?:/kill::/hp 0{left 2}
:?:.лшдд::/hp 0{left 2}
:?:.штсфк::/incar
:?:.пр::/gh
:?:.пиздец::<@&1440772230282870955> и <@&1440772120870260837> Уважаемая администрация, просим зайти вас на сервер, в данный момент нам очень нужна ваша помощь.
:?:.штм::/playerinv
:?:.шв::/id
:?:.рз::/hp
:?:.од::/jail
:?:.офшд::/jail
:?:.фофшд::/unjail
:?:.лшсл::/kick
:?:.ылшсл::/skick
:?:.кузфшк::/repair
:?:.уыз::/esp
:?:.пуесфк::/getcar
:?:.ифт::/ban
:?:.вудмур::/delveh
:?:.мур::/veh
:?:.рфквифт::/hardban
:?:.ьгеу::/mute
:?:.пшв::/gid
:?:.ршву::/hide
:?:.куысгу::/rescue
:?:.ыуевшь::/setdim
:?:/sd::/setdim
:?:.ыв::/setdim
:?:.афк::/a afk мин{left 4}
:?:.фгтсгаа::/auncuff
:?:.фсгаа::/acuff
:?:.акууяф::/freeze
:?:.scd::/setcardim
:?:.ыуесфквшь::/setcardim
:?:.ымд::/setvehdim
; :?:.ызфцтсфк::/spawncar
; :?:/sv::/spawnveh
; :?:.ым::/spawnveh

; ЧИФЫ КРАШЕЙ
; :?:.краш::
; SendMessage, 0x50,, 0x4090409
; SendInput, Здравствуйте. Если у Вас есть доказательства краша - предоставьте его в личные сообщения дискорда. Вас выпустят. Дискорд для связи: 1ssabtw.
; Return

:?:.краш::
SendMessage, 0x50,, 0x4090409
SendInput, Здравствуйте. Если у Вас есть доказательства краша - предоставьте его мне в личные сообщения дискорда. Я вас выпущу. Мой дискорд: %qdis%.
Return
:?:.дс::
SendMessage, 0x50,, 0x4090409
SendInput, Здравствуйте, предоставьте видеодоказательство мне в личные сообщения дискорда: %qdis%. Приятной игры на Region.
Return
:?:.га::
SendMessage, 0x50,, 0x4090409
SendInput, Обратитесь в личные сообщения дискорда к главному администратору: %gadis%.
Return
:?:.зга::
SendMessage, 0x50,, 0x4090409
SendInput, Обратитесь в личные сообщения дискорда к заместителю главного администратора: %zgadis%.
Return

SetKeyDelay, 20, 10

:?*:.тп::
Gui, 2: Submit, NoHide
targetX := 0, targetY := 0, lang := 0x4090409

; --- ОПРЕДЕЛЕНИЕ КООРДИНАТ (твой блок без изменений) ---
if (ScreenRes = "2560x1440")
    targetX := 1912, targetY := 250
else if (ScreenRes = "2554x1411")
    targetX := 1901, targetY := 247
else if (ScreenRes = "1920x1080")
    targetX := 1410, targetY := 187
else if (ScreenRes = "1920x1080 (5:4)")
    targetX := 1263, targetY := 193, lang := 0x4190419 
else if (ScreenRes = "1680x1050")
    targetX := 812, targetY := 233
else if (ScreenRes = "1600x900")
    targetX := 1211, targetY := 152
else if (ScreenRes = "1440x900")
    targetX := 961, targetY := 159
else if (ScreenRes = "1366x768")
    targetX := 878, targetY := 136
else if (ScreenRes = "1366x768 (5:3)")
    targetX := 836, targetY := 136
else if (ScreenRes = "1280x1024")
    targetX := 901, targetY := 182, lang := 0x4190419
else if (ScreenRes = "1280x960")
    targetX := 888, targetY := 165

if (targetX = 0) {
    MsgBox, 16, Ошибка, Выберите разрешение в интерфейсе!
    return
}

; --- НАЧАЛО РАБОТЫ ---
BlockInput, On ; ЗАКРЫВАЕМ ДОСТУП К КЛАВИАТУРЕ
Send {Alt Up}{Ctrl Up}{Shift Up} ; Принудительно сбрасываем залипшие клавиши

SetKeyDelay, 30, 10 ; Настройка плавности печати

SendMessage, 0x50,, %lang%,, A
SendEvent, {Text}Приветствую. Уже лечу к вам.
Sleep, 200
SendEvent, {Enter}
Sleep, 400 
SendEvent, {Esc} 
Sleep, 450 

SendMessage, 0x50,, 0x4090409,, A 
SendEvent, {sc14} ; Открываем чат (T)
Sleep, 250 
SendEvent, {Text}/tp
SendEvent, {Space}

BlockInput, Off ; ОТКРЫВАЕМ ДОСТУП К КЛАВИАТУРЕ
Return

; Автоответ на репорт
fastans:
Gui, 2: Submit, NoHide
targetX := 0, targetY := 0

if (ScreenRes = "2560x1440") {
    targetX := 1912, targetY := 250
} else if (ScreenRes = "2554x1411") {
    targetX := 1901, targetY := 247
} else if (ScreenRes = "1920x1080") {
    targetX := 1410, targetY := 187
} else if (ScreenRes = "1920x1080 (5:4)") {
    targetX := 1263, targetY := 193, lang := 0x4190419 
} else if (ScreenRes = "1680x1050") {
    targetX := 812, targetY := 233
} else if (ScreenRes = "1600x900") {
    targetX := 1211, targetY := 152
} else if (ScreenRes = "1440x900") {
    targetX := 961, targetY := 159
} else if (ScreenRes = "1366x768") {
    targetX := 878, targetY := 136
} else if (ScreenRes = "1366x768 (5:3)") {
    targetX := 836, targetY := 136
} else if (ScreenRes = "1280x1024") {
    targetX := 901, targetY := 182, lang := 0x4190419
} else if (ScreenRes = "1280x960") {
    targetX := 888, targetY := 165
}

if (targetX = 0) {
    MsgBox, 16, Ошибка, К сожалению, твой монитор (%ScreenRes%) не подходит под данную функцию.
    return
}

PixelGetColor, Var1, %targetX%, %targetY%, Alt
isSpecial := (Var1 = 0x005A1CE8 || Var1 = 0x005912FB || Var1 = 0x008313FF || Var1 = 0x006619E9)

SendMessage, 0x50,, 0x4190419,, A 
SendEvent, {Text}Приветствую. Уже лечу к Вам.
Sleep, 150
SendInput, {Enter}
Sleep, 250
SendInput, {Esc}
Sleep, 450 ; Пауза перед открытием чата для /tp
SendMessage, 0x50,, 0x4090409,, A 
SendInput, {sc14}
Sleep, 200
SendEvent, {Text}/tp
SendInput, {Space}

if (isSpecial) {
    counter++
    GoSub, UpdateCounter
}
Return

:?:.дис::
SendMessage, 0x50,, 0x4090409
SendInput, Здравствуйте, обратитесь ко мне в личные сообщения дискорда: %qdis%.
Return


GreetLabel:
SendInput, {F6}Приветствую, иду на помощь.{Enter}
Gosub, AddRep
Sleep, 300 ; Ждем, пока чат закроется после отправки
SendInput, {Esc}
Sleep, 200
SendInput, {sc14}
Sleep, 200
SendInput, /tp{Space}
return

GoLabel:
SendInput, {F6}Здравствуйте, иду.{Enter}
Gosub, AddRep
return

WaitLabel:
SendInput, {F6}Сейчас помогу, ожидайте.{Enter}
Gosub, AddRep
return

PlayLabel:
SendInput, {F6}Приятной игры на Region.{Enter}
return

; Быстрый репорт (Оптимизированный под DropDownList)
fastrep:
Gui, 2: Submit, NoHide
; Инициализируем переменные координат
x1 := 0, y1 := 0, x2 := 0, y2 := 0, x3 := 0, y3 := 0

; --- ЛОГИКА ОПРЕДЕЛЕНИЯ КООРДИНАТ (От большего к меньшему) ---
if (ScreenRes = "2560x1440") {
    x1 := 1300, y1 := 570, x2 := 1235, y2 := 1034, x3 := 1235 , y3 := 1034
}
else if (ScreenRes = "2554x1411") {
    x1 := 1300, y1 := 570, x2 := 1235, y2 := 1034, x3 := 1235 , y3 := 1034
}
else if (ScreenRes = "1920x1080") {
    x1 := 1055, y1 := 388, x2 := 1103, y2 := 868, x3 := 787, y3 := 864
}
else if (ScreenRes = "1920x1080 (5:4)") {
    x1 := 1039, y1 := 392, x2 := 1096, y2 := 864, x3 := 758, y3 := 857
}
else if (ScreenRes = "1680x1050") {
    x1 := 812, y1 := 233, x2 := 812, y2 := 233, x3 := 855, y3 := 336 ; Координаты на основе 1600x900 (проверь в игре)
}
else if (ScreenRes = "1600x900") {
    x1 := 880, y1 := 290, x2 := 908, y2 := 775, x3 := 634, y3 := 764
}
else if (ScreenRes = "1440x900") {
    x1 := 823, y1 := 298, x2 := 848, y2 := 782, x3 := 559, y3 := 766
}
else if (ScreenRes = "1366x768") {
    x1 := 765, y1 :=253 , x2 := 805, y2 := 690, x3 := 575, y3 := 695
}
else if (ScreenRes = "1366x768 (5:3)") {
    x1 := 765, y1 :=253 , x2 := 805, y2 := 690, x3 := 575, y3 := 695
}
else if (ScreenRes = "1280x1024") {
    x1 := 707, y1 := 363, x2 := 748, y2 := 841, x3 := 522, y3 := 836
}
else if (ScreenRes = "1280x960") {
    x1 := 707, y1 := 363, x2 := 748, y2 := 841, x3 := 522, y3 := 836 ; Используем от 1280x1024 как базу
}

; --- ПРОВЕРКА И ВЫПОЛНЕНИЕ ---
if (x1 = 0) {
    MsgBox, 16, Ошибка, Разрешение %ScreenRes% пока не настроено для FastRep.
    return
}

SendInput, {F8}
Sleep 300 ; Ожидание открытия меню

Click, %x1%, %y1% ; Клик по репорту
Sleep 250
Click, %x2%, %y2% ; Подтверждение / Выбор
Sleep 250
Click, %x3%, %y3% ; Финальная кнопка
Sleep 100
Return

; Ответы
:?:.финка::Чтобы приобрести финку НКВД откройте планшет(стрелочка вниз), и выберите приложение "Маркетплейс", там нажмите на вкладку предмет, после чего ищите данный предмет.
:?:.че::Здравствуйте, уточните свой вопрос подробнее в репорт. Количество символов в репорт не ограничено, вы можете полностью расписать Вашу проблему/вопрос.
:?:.донат::Попробуйте перезайти/немного подождать. Если это не поможет, то рекомендую обратиться в раздел технической поддержки на форуме Region (forum.region.game)! Вам обязательно помогут.
:?:.промо::Промокод вы можете ввести через чат: /promo. На данный момент доступен промокод Region дает ежедневный кейс+20.000руб на 5 уровне персонажа, obtstart дает сразу кейс BMW, nazavod дает сразу 10.000руб.
:?:.амп::Вы можете выставить автомобиль через маркетплейс, достаньте планшет(стрелочка вниз) и зайдите во вкладку Маркетплейс.
:?:.счет::На карте “отделение С-Банка”, заходите, подходите к NPC - Е - открыть счет - выбираете тариф - нажмите на подтвердить.
:?:.симка::Для того, чтобы купить сим-карту, на карте найдите салон Билайф
:?:.кв::Для покупки свободной квартиры нужно приехать на  локацию с иконкой «Квартиры» (всего таких иконок 60). Приходите туда, заходите в подъезд и выбирайте понравившееся жильё из свободного. Ещё вы можете приобрести квартиру у других игроков, либо найти её на маркетплейсе.
:?:.номера::Номера можно получить в холле здания ГИБДД, на карте отмечена как Дорожно-Патрульная Служба. При входе в здание вас встретит NPC у которого вы сможете купить номера на свое авто.
:?:.док::Для того чтобы показать документы, нажмите клавишу "G" рядом с игроком, затем выберите опцию "Документы" и выберите нужный документ.
:?:.гпс::Достаньте телефон (Нажмите стрелочку вверх), далее выберите приложение навигатор.
:?:.сид::Укажите static ID игрока с которым у Вас происходил РП процесс.
:?:.раб::Игрокам предоставлена возможность выбрать для себя лучший способ заработка на работах, т.к. это все индивидуально. На данный момент существуют следующие работы: рабочий на заводе, дальнобойщик, курьер. Вы можете устроиться на работу через приложение "Моя работа" или вступить в одну из фракций.
:?:.увал::Здравствуйте. К сожалению, ничем не можем помочь. Дождитесь своего лидера/заместителей или свяжитесь с куратором своей фракции в личные сообщения Discord.
:?:.ганлиц::Здравствуйте, чтобы получить лицензию на оружие, вам необходимо приехать в здание МВД и обратиться к сотрудникам полиции.
:?:.фрак::Здравствуйте, время и место собеседования назначается отделом кадров внутри фракции. Следите за гос.новостями в чате или в дискорде фракции чтобы не пропустить собеседование! Либо придите и уточните напрямую у сотрудников в здании.
:?:.баг::Знаем о данной проблеме, она уже передана разработчикам.
:?:.мед:: Приветствую. Для получения медицинской карты вам необходимо приехать в здание Центральной городской больницы, обратиться к сотрудникам.
:?:.рел::Попробуйте перезайти через F1 > Direct Connect > Connect или полностью в игру (F1 - Quit Game).
:?:.рп::Извините, но это РП процесс, мы не вправе вмешиваться в него.
:?:.урп::Приветствую, данную информацию вы можете получить при взаимодействии с другими игроками/самостоятельным поиском непосредственно во время игрового процесса, либо другим доступным IC путем. Приятной игры и самого лучшего настроения на Region.
:?:.войс::Чтобы перезагрузить войс, попробуйте нажать F8. Если ничего не помогает - перезайдите в игру. Вы также можете перебиндить данную клавишу зайдя в F2 - Настройки - Управление - Общение.
:?:.тех::Здравствуйте, напишите в технический раздел официального дискорд сервера "Region" - "тех-поддержка".
:?:.функ::Данный функционал временно недоступен, приносим свои извинения.
:?:.фун::Данный функционал не присутсвует у нас на сервере.
:?:.изв::Приносим свои извинения за предоставленные неудобства.
:?:.ехп::Каждый час (у каждого игрока своё время) Вам дается EХP.
:?:.авто::Чтобы эвакуировать Ваше авто воспользуйтесь маркером "Парковка" (Буква "P" на карте). Приятной игры.
:?:.канистра::Чтобы использовать канистру, нажмите G на авто - Действие - Канистра.
:?:.подним::Приветствую. К сожалению, не видя всей ситуации мы не в праве лечить,поднимать или добивать игроков. Дождитесь сотрудников ЦГБ либо же окончания таймера смерти. Приносим свои извинения за возможные неудобства. 
:?:.жб::Администрация не может выдавать наказания и выносить какие-либо вердикты не видя всей ситуации. Пожалуйста, если у Вас есть видеофиксация данного нарушения - оформите жалобу на форуме (forum.region.game), спасибо большое за понимание.
:?:.адж::Приветствую. Обратитесь, пожалуйста, в дискорд к администратору, который выдал вам наказание или рассмотрел жалобу.
:?:.адз::Данный администратор сейчас занят другим делом или отошел от компьютера на короткое время, напишите ему в личные сообщения в дискорде.
:?:.адс::Данный администратор сейчас отсутствует на сервере, напишите ему в личные сообщения в дискорде.
:?:.погода::К сожалению, администрация не контролирует данный процесс. Погода меняется автоматически и синхронизировано с погодой реального г. Санкт-Петербурга.
:?:.неп::Опишите Вашу проблему/вопрос подробнее в f2 - поддержка для максимально точного ответа, пожалуйста.
:?:.хп::Администрация не выдает HP. Купите таблетку у сотрудников ЦГБ.
:?:.аним::Здравствуйте, забиндить анимации можно в F2 - Анимации. Использовать анимацию можно при нажатии клавиши "U".
:?:.ид::Здравствуйте, укажите, пожалуйста, ID нарушителя.
:?:.жба::Вы можете написать жалобу на форум, если не согласны с решением администратора.
:?:.п::Приятной игры на Region <3.
:?:.нов::Следите за новостями сервера в официальном дискорде проекта.
:?:.ник::На данный момент вы можете сменить NickName через администрацию сервера.
:?:.крашрп::Здравствуйте. Если у Вас есть доказательства краша - предоставьте его любому администратору в личные сообщения дискорда. Вас выпустят.
:?:.иограб::Здравствуйте, чтобы ограбить игрока, вам нужно: находится в семье, одеть маску, приобрести оружие, начать ограбление игрока можно в составе от 2 человек, наведитесь на игрока которого вы хотите ограбить нажмите G - Семья - Ограбить.
:?:.кредит::Любые финансовые договоры (займы, кредиты и т.д) не относятся к ООС сделкам. Все подобные сделки игроки совершают на свой страх и риск. Администрация не несет ответственности и не является гарантом сделки.
:?:.рем::Приветствую, чтобы починить своё авто вам необходимо приехать в Тюнинг (Обозначен на карте Диском с гаечным ключом).
:?:.сделка::Приветствую, администрация не следит за сделками игроков, запишите видео на случай обмана, чтобы оставить жалобу на игрока на форуме.
:?:.имя::Ваше Имя Фамилия не подходит по правилам нашего сервера. Вам нужно сменить ник, напишите в репорт желаемый NickName чтобы администрация могла вам его поменять. После этого вас выпустят.
:?:.актуал:: Приветствую. Приносим извинения за столь долгое ожидание. Пожалуйста, если проблема еще актуальна, напишите нам. Спасибо за понимание.
:?:.лечу::Приветствую. Уже лечу к Вам на помощь.
:?:.пом::Приветствую. Сейчас помогу Вам, ожидайте.
:?:.госдом::Приветствую. Чтобы продать дом в государству, нужно открыть планшет. Вы получите 75% от его гос. цены. Если Вы невовремя оплатите налоги или забудете это сделать, дом слетит автоматически.
:?:.реп::Приветствую. Пожалуйста, уточните свой вопрос подробнее. Администрация не летает на репорты по типу "админ тп", "админ можно поговорить", "помогите", "админ есть вопрос". Количество символов в /report неограничено, вы можете полностью расписать Вашу проблему/вопрос.
:?:.неувид::Приветствую, к сожалению администрация не может увидеть это нарушение. Пожалуйста, если у Вас есть видеофиксация данного нарушения - оформите жалобу на форуме, спасибо большое за понимание.
:?:.да::Приветствую. Да.
:?:.нет::Приветствую. Нет.
:?:.нетп::Приветствую, администрация не телепортирует игроков, Вам нужно добраться до места самостоятельно.
:?:.толкать::Транспорт можно толкать, подойдите спереди или сзади транспорта, нажмите G - Действие - Толкать. Если такой функции нет, при наведении на авто, то этот транспорт толкать нельзя.
:?:.аут::Для подключения Google authenticator вам нужно нажать F2 - Настройки - Безопасность.
:?:.опра::Если у Вас есть видеодоказательства данного нарушения - оставьте жалобу на игрока на форуме (forum.region.game).
:?:.неув::Не увидел нарушений.
:?:.хз::К сожалению, не располагаем данной информацией.
:?:.кур::Передам кураторам.
:?:.техдс::Напишите в технический раздел официального дискорд-сервера Region в канале "тех-поддержка".
:?:.закон::Это регулируется IC законами. Изучить их можно в разделе "Правительство" на форуме: forum.region.game
:?:.акт::Ваша проблема актуальна?
:?:.непр::Не предоставляем подобную информацию.
:?:.нераз::Не разглашаем данную информацию.
:?:.чх::Если у Вас есть фиксация с подозрительным моментом, то Вы можете предоставить его в Telegram: @Region_cheathunter_bot
:?:.неком::Не комментируем действия других администраторов.
:?:.оценка::Не обсуждаем и не оцениваем работу/наказания других администраторов, подобные вопросы необходимо обсудить с тем, кто выдал наказание/следил за ситуацией.
:?:.адм::Напишите администратору, который выдал Вам наказание. Если нужен его дискорд, напишите в обращение ник администратора.
:?:.слежка::Администрация не может следить полностью за всем РП процессом, в случае нарушений от игроков - напишите репорт.
:?:.лоял::Мы игровые администраторы, наша задача помогать игрокам и пресечь нарушение, а не наказать игрока. Если игрок будет повторно замечен в нарушении правил проекта, он обязательно получит своё наказание. На данный момент нарушение устранено, а это и является главной нашей целью и задачей. Спасибо за бдительность, надеюсь Ваша игра станет комфортней.
:?:.пред::Предупредил игрока.
:?:.преду::/msg  Приветствую, Вы нарушаете правила проекта. Если данные действия с Вашей стороны не прекратятся, то я буду вынужден выдать наказание. Настоятельно рекомендую ознакомиться с правилами проекта, спасибо за понимание.{left 227}
:?:.парк::Чтобы заспавнить транспорт, Вам необходимо явиться на паркинг. На карте он отмечен синим знаком парковки "Р".
:?:.рабпарк::Чтобы заспавнить рабочий транспорт, Вам необходимо явиться на рабочий паркинг. На карте он отмечен синим транспортом с ключём.
:?:.мог::Могу чем-то еще помочь?
:?:.могу::Могу ли я Вам ещё чем-либо помочь?
:?:.вас::У Вас остались вопросы?

; Наказания
:?:.хардо::/hardban 9999 Обход блокировки{left 21}
:?:.хард::/hardban 7777 Cheats{left 12}
:?:.хард9::/hardban 9999 Cheats{left 12}
:?:.секс::/jail 4.11 OП{Left 8}
:?:.нрд::/jail 10 4.2 OП{Left 10}
:?:.нрд20::/jail 20 4.2 OП{Left 10}
:?:.нрд30::/jail 30 4.2 OП{Left 10}
:?:.нрд60::/jail 60 4.2 OП{Left 10}
:?:.нрд90::/jail 90 4.2 OП{Left 10}
:?:.нрп::/jail 15 4.1 OП{Left 10}
:?:.нрп25::/jail 25 4.1 OП{Left 10}
:?:.нрп45::/jail 45 4.1 OП{Left 10}
:?:.нрп70::/jail 70 4.1 OП{Left 10}
:?:.нрп90::/jail 90 4.1 OП{Left 10}
:?:.дб::/jail 20 4.2 OП{Left 10}
:?:.дб35::/jail 4.2 OП{Left 10}
:?:.дб50::/jail 4.2 OП{Left 10}
:?:.дб75::/jail 4.2 OП{Left 10}
:?:.дб90::/jail 4.2 OП{Left 10}
:?:.дм::/jail 30 4.9 ОП{Left 10}
:?:.дмг::/gunban 60 4.9 ОП{Left 10}
:?:.пг::/jail 30 4.14 ОП{Left 11}
:?:.пг45::/jail 45 4.14 ОП{Left 11}
:?:.пг65::/jail 65 4.14 ОП{Left 11}
:?:.пг90::/jail 90 4.14 ОП{Left 11}
:?:.муз::/mute 20 1.5 ПиЗ{Left 11}
:?:.муз40::/mute 40 1.5 ПиЗ{Left 11}
:?:.смник::/jail 720 Смените Имя_Фамилия согласно п.2.6 общих правил{Left 52}
:?:.осаб::/ban 5 3.7 ОП{left 9}
:?:.осам::/mute 60 3.7 ОП{left 10}

Changelog:
Gui, Change: Destroy 
Gui, Change: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, Change: Color, 11141A ; Глубокий темно-синий/черный фон

; --- ЗАГОЛОВОК ---
Gui, Change: Font, s11 Bold c7F56D9, Segoe UI ; Фирменный неоновый фиолетовый
Gui, Change: Add, Text, x15 y15 w420, 📝 CHANGELOG (ИЗМЕНЕНИЯ)
Gui, Change: Add, Progress, x15 y42 w420 h1 Background252D3A c252D3A, 100 ; Тонкий темный разделитель

LogText = 
(
<style>
    body { 
        background-color: #11141A; 
        color: #D1D5DB; 
        font-family: 'Segoe UI', sans-serif; 
        font-size: 13px; 
        margin: 5px 10px; 
        overflow-x: hidden;
        user-select: none; /* Запрет выделения */
        -webkit-user-select: none;
    }
    .item { margin-bottom: 5px; line-height: 1.4; }
    /* Подсветка новых фич неоновым синим */
    .plus { color: #00F2FE; font-weight: bold; }
    /* Подсветка фиксов мягким фиолетовым */
    .fix { color: #7F56D9; font-weight: bold; }
</style>
<body>

    <div class="item"><span class="plus">[+]</span> Полностью обновлен интерфейс биндера</div>
    <div class="item"><span class="plus">[+]</span> Изменение стилистики окон и кнопок активации</div>
    <div class="item"><span class="plus">[+]</span> Изменена система автоматического счётчика репортов: при написании команды .ку и всех видов приветствия идет засчитывание взятия репорта</div>
    <div class="item"><span class="plus">[+]</span> Увеличено количество точек телепортации, добавлены важные места, удобное разделение на категории</div>
    <div class="item"><span class="plus">[+]</span> Изменена работа авто-выдачи наказания через документ</div>
    <div class="item"><span class="plus">[+]</span> Увеличено количество автоответов на репорты (Теперь более 75 ответов)</div>
    <div class="item"><span class="plus">[+]</span> Добавлена вкладка полезные ссылки с ссылками на правила сервера и иные правила</div>
    <div class="item"><span class="plus">[+]</span> Добавлена памятка ответов для репортов</div>
    <div class="item"><span class="plus">[+]</span> Система очистки статистики репортов теперь возможна с несколькими вариантами — Сброс дня, сброс всей статистики</div>

</body>
)

; --- СПИСОК ИЗМЕНЕНИЙ (HTML БЛОК) ---
Gui, Change: Add, ActiveX, x15 y50 w430 h180 vDisplay, HTMLFile
Display.Write(LogText)

; Нижний разделитель
Gui, Change: Add, Progress, x15 y242 w420 h1 Background252D3A c252D3A, 100

; --- ФУТЕР ---
Gui, Change: Font, s8 Medium c64748B, Segoe UI ; Приглушенный серый
Gui, Change: Add, Text, x20 y250 w410, Поддержка / Идеи: Python (1ssabtw)

; --- КНОПКА ЗАКРЫТИЯ (ПЛОСКАЯ ТЕКСТОВАЯ ПЛАШКА) ---
Gui, Change: Font, s9 Bold c64748B, Segoe UI
Gui, Change: Add, Text, x150 y275 w150 h32 Center Background1F242F +0x200 gCloseLog, ПОНЯТНО

; Финальный показ окна (Высота скорректирована для симметричных отступов)
Gui, Change: Show, w450 h320
return

CloseLog:
Gui, Change: Destroy
return

Помощь:
Gui, About: Destroy 
Gui, About: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, About: Color, 1A1A1A
Gui, About: Font, s12 Bold cGreen, Segoe UI

; --- НАСТРОЙКИ ОКНА О ПРОГРАММЕ ---
Gui, About: Destroy ; Предотвращает наложение при повторном открытии
Gui, About: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, About: Color, 11141A ; Глубокий темно-синий/черный фон

; --- ЗАГОЛОВОК ---
Gui, About: Font, s11 Bold c7F56D9, Segoe UI ; Фирменный неоновый фиолетовый
Gui, About: Add, Text, x15 y15 w420, ℹ️ ИНФОРМАЦИЯ О СОФТЕ
Gui, About: Add, Progress, x15 y42 w420 h1 Background252D3A c252D3A, 100 ; Тонкий темный разделитель

; --- ОСНОВНОЙ БЛОК ---
Gui, About: Font, s9 Medium cE2E8F0, Segoe UI ; Мягкий белый для основного текста
Gui, About: Add, Text, x20 y55 w410, Софт создан для облегчения работы администрации Region.

; Подсветка ключевой особенности неоновым цианом
Gui, About: Font, s9 Medium c00F2FE, Segoe UI
Gui, About: Add, Text, x20 y80 w410, Автоматический учет репортов за день и неделю.

; --- БЛОК НАСТРОЕК ---
Gui, About: Font, s10 Bold c7F56D9, Segoe UI
Gui, About: Add, Text, x20 y115, ⚙️ НАСТРОЙКА:

Gui, About: Font, s9 Medium cE2E8F0, Segoe UI
Gui, About: Add, Text, x20 y135 w410, Выберите разрешение, Discord, сервер и пол в меню.

Gui, About: Font, s9 Medium c00F2FE, Segoe UI
Gui, About: Add, Text, x20 y155 w410, Обязательно нажмите "Сохранить" для применения!

; --- БЛОК УПРАВЛЕНИЯ ---
Gui, About: Font, s10 Bold c7F56D9, Segoe UI
Gui, About: Add, Text, x20 y190, ⌨️ УПРАВЛЕНИЕ:

Gui, About: Font, s9 Medium cE2E8F0, Segoe UI
Gui, About: Add, Text, x20 y210, Ctrl + F9 — Перезапуск программы
Gui, About: Add, Text, x20 y230, Ctrl + F10 — Закрыть программу

; Нижний разделитель
Gui, About: Add, Progress, x15 y260 w420 h1 Background252D3A c252D3A, 100

; --- ФУТЕР ---
Gui, About: Font, s8 Medium c64748B, Segoe UI ; Приглушенный серый
Gui, About: Add, Text, x20 y270 w410, Поддержка / Идеи: Python (1ssabtw)

; --- КНОПКА ЗАКРЫТИЯ (ПЛОСКАЯ ТЕКСТОВАЯ ПЛАШКА) ---
Gui, About: Font, s9 Bold c64748B, Segoe UI
Gui, About: Add, Text, x135 y300 w180 h32 Center Background1F242F +0x200 gCloseAbout, ПОНЯТНО

; Финальный показ окна (Высота h345 подобрана под новые отступы)
Gui, About: Show, w450 h345, О программе
return

; Логика кнопки закрытия
CloseAbout:
Gui, About: Destroy
return

Телепорты:
; Полная очистка окна перед созданием
Gui, 4: Destroy 

Gui, 4: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 4: Color, 11141A ; Глубокий темно-синий/черный фон

; Заголовок меню
Gui, 4: Font, s11 Bold c7F56D9, Segoe UI
Gui, 4: Add, Text, x20 y15, 📍 БЫСТРЫЙ ТЕЛЕПОРТ

; Настройка шрифта для современных плоских кнопок-плиток
Gui, 4: Font, s9 Medium cD1D5DB, Segoe UI

; --- СТОЛБЕЦ 1: ФРАКЦИИ ---
Gui, 4: Font, s9 Bold c64748B, Segoe UI
Gui, 4: Add, Text, x20 y50 w160, ФРАКЦИИ
Gui, 4: Add, Progress, x20 y70 w160 h1 Background252D3A c252D3A, 100
Gui, 4: Font, s9 Medium cD1D5DB, Segoe UI

Gui, 4: Add, Text, x20 y80 w160 h28 Center Background1F242F +0x200 gGoMWD, 👮 .мвд [ МВД ]
Gui, 4: Add, Text, x20 y115 w160 h28 Center Background1F242F +0x200 gGoCGB, 🏥 .цгб [ ЦГБ СПБ ]
Gui, 4: Add, Text, x20 y150 w160 h28 Center Background1F242F +0x200 gGoDPS, 🚔 .дпс [ ГИБДД ]
Gui, 4: Add, Text, x20 y185 w160 h28 Center Background1F242F +0x200 gGoSMI, 🎙️ .сми [ СМИ ]
Gui, 4: Add, Text, x20 y220 w160 h28 Center Background1F242F +0x200 gGoCGBT, 🚑 .цгбт [ ЦГБ Тольятти ]
Gui, 4: Add, Text, x20 y255 w160 h28 Center Background1F242F +0x200 gGoAutoSH, 🚗 .автош [ Автошкола ]
Gui, 4: Add, Text, x20 y290 w160 h28 Center Background1F242F +0x200 gGoArmia, 🪖 .армия [ Армия ]

; --- СТОЛБЕЦ 2: ГОРОД ---
Gui, 4: Font, s9 Bold c64748B, Segoe UI
Gui, 4: Add, Text, x200 y50 w160, ГОРОД
Gui, 4: Add, Progress, x200 y70 w160 h1 Background252D3A c252D3A, 100
Gui, 4: Font, s9 Medium cD1D5DB, Segoe UI

Gui, 4: Add, Text, x200 y80 w160 h28 Center Background1F242F +0x200 gGoMFC, 📄 .мфц [ МФЦ ]
Gui, 4: Add, Text, x200 y115 w160 h28 Center Background1F242F +0x200 gGoBank, 💳 .банк [ Банк ]
Gui, 4: Add, Text, x200 y150 w160 h28 Center Background1F242F +0x200 gGoAZS, ⛽ .азс / .247
Gui, 4: Add, Text, x200 y185 w160 h28 Center Background1F242F +0x200 gGoTatu, 🎨 .тату [ Тату ]
Gui, 4: Add, Text, x200 y220 w160 h28 Center Background1F242F +0x200 gGoBarber, ✂️ .барбер [ Барбер ]
Gui, 4: Add, Text, x200 y255 w160 h28 Center Background1F242F +0x200 gGoPark, 🌳 .парк [ Парк ]
Gui, 4: Add, Text, x200 y290 w160 h28 Center Background1F242F +0x200 gGoApt, 💊 .апт [ Аптека ]
Gui, 4: Add, Text, x200 y325 w160 h28 Center Background1F242F +0x200 gGoAvita, 📦 .авита [ Авито ]
Gui, 4: Add, Text, x200 y360 w160 h28 Center Background1F242F +0x200 gGoBee, 📱 .билайф [ BeeLife ]

; --- СТОЛБЕЦ 3: РАБОТА И ДРУГОЕ ---
Gui, 4: Font, s9 Bold c64748B, Segoe UI
Gui, 4: Add, Text, x380 y50 w160, РАБОТА / ДРУГОЕ
Gui, 4: Add, Progress, x380 y70 w160 h1 Background252D3A c252D3A, 100
Gui, 4: Font, s9 Medium cD1D5DB, Segoe UI

Gui, 4: Add, Text, x380 y80 w160 h28 Center Background1F242F +0x200 gGoTSklad, 📦 .тсклад [ Склад ]
Gui, 4: Add, Text, x380 y115 w160 h28 Center Background1F242F +0x200 gGoZavod, ⚙️ .завод [ Завод ]
Gui, 4: Add, Text, x380 y150 w160 h28 Center Background1F242F +0x200 gGoAutobus, 🚌 .автобус [ Автобус ]
Gui, 4: Add, Text, x380 y185 w160 h28 Center Background1F242F +0x200 gGoDalno, 🚛 .дально [ Дально 1 ]
Gui, 4: Add, Text, x380 y220 w160 h28 Center Background1F242F +0x200 gGoDalno1, 🚚 .дально1 [ Дально 2 ]
Gui, 4: Add, Text, x380 y255 w160 h28 Center Background1F242F +0x200 gGoTaxi, 🚖 .такси [ Такси 1 ]
Gui, 4: Add, Text, x380 y290 w160 h28 Center Background1F242F +0x200 gGoTaxi1, 🚕 .такси1 [ Такси 2 ]
Gui, 4: Add, Text, x380 y325 w160 h28 Center Background1F242F +0x200 gGoAD, 🏛️ .ад [ АдминЗона ]
Gui, 4: Add, Text, x380 y360 w160 h28 Center Background1F242F +0x200 gGoKazik, 🎰 .казик [ Казино вход ]
Gui, 4: Add, Text, x380 y395 w160 h28 Center Background1F242F +0x200 gGoVkazik, 🎲 .вказик [ Казино внутри ]

; Кнопка закрытия внизу по центру
Gui, 4: Font, s9 Norm c64748B
Gui, 4: Add, Text, x20 y445 w520 h25 Center Background1F242F +0x200 gCloseTP, [ Скрыть меню ]

; Показываем готовое окно
Gui, 4: Show, w560 h485, TeleportMenu
return


; --- ЛОГИКА ТЕЛЕПОРТАЦИИ (КНОПКИ И ХОТКЕИ) ---

:?:.мвд::
GoMWD:
    Gosub, PrepareGame
    SendInput, {t}/tpc 560.706 5962.073 11.719{Enter}
return

:?:.цгб::
GoCGB:
    Gosub, PrepareGame
    SendInput, {t}/tpc -581.273 7196.846 6.796{Enter}
return

:?:.дпс::
GoDPS:
    Gosub, PrepareGame
    SendInput, {t}/tpc -1236.235 5823.474 11.839{Enter}
return

:?:.сми::
GoSMI:
    Gosub, PrepareGame
    SendInput, {t}/tpc -246.499 7000.819 4.248{Enter}
return

:?:.армия::
GoArmia:
Gosub, PrepareGame
SendInput, {t}/tpc 4607.988 2761.864 20.549{Enter}
return

:?:.мфц::
GoMFC:
    Gosub, PrepareGame
    SendInput, {t}/tpc -399.227 4579.225 4.700{Enter}
return

:?:.банк::
GoBank:
    Gosub, PrepareGame
    SendInput, {t}/tpc -389.053 6672.802 3.837{Enter}
return

:?:.азс::
:?:.247::
GoAZS:
    Gosub, PrepareGame
    SendInput, {t}/tpc -504.776 6708.471 4.508{Enter}
return

:?:.тату::
GoTatu:
    Gosub, PrepareGame
    SendInput, {t}/tpc 98.299 5222.805 4.214{Enter}
return

:?:.барбер::
GoBarber:
    Gosub, PrepareGame
    SendInput, {t}/tpc -264.435 5275.946 6.082{Enter}
return

:?:.парк::
GoPark:
    Gosub, PrepareGame
    SendInput, {t}/tpc -2383.074 6346.012 5.093{Enter}
return

:?:.апт::
GoApt:
    Gosub, PrepareGame
    SendInput, {t}/tpc -500.745 4992.870 8.004{Enter}
return

:?:.авита::
GoAvita:
    Gosub, PrepareGame
    SendInput, {t}/tpc -1486.624 6602.413 4.976{Enter}
return

:?:.тсклад::
GoTSklad:
    Gosub, PrepareGame
    SendInput, {t}/tpc 3589.537 -3949.451 34.880{Enter}
return

:?:.завод::
GoZavod:
    Gosub, PrepareGame
    SendInput, {t}/tpc 6428.458 -2291.381 41.528{Enter}
return

:?:.автобус::
GoAutobus:
    Gosub, PrepareGame
    SendInput, {t}/tpc 285.565 4583.576 6.637{Enter}
return

:?:.дально::
GoDalno:
    Gosub, PrepareGame
    SendInput, {t}/tpc -2821.181 5770.997 8.382{Enter}
return

:?:.дально1::
GoDalno1:
    Gosub, PrepareGame
    SendInput, {t}/tpc 5541.948 -3835.776 41.546{Enter}
return

:?:.цгбт::
GoCGBT:
    Gosub, PrepareGame
    SendInput, {t}/tpc 4725.533 -3228.460 39.193{Enter}
return

:?:.автош::
GoAutoSH:
    Gosub, PrepareGame
    SendInput, {t}/tpc -532.233 6978.211 5.725{Enter}
return

:?:.билайф::
GoBee:
    Gosub, PrepareGame
    SendInput, {t}/tpc -41.734 5125.277 5.732{Enter}
return

:?:.такси::
GoTaxi:
    Gosub, PrepareGame
    SendInput, {t}/tpc -1285.484 6445.054 6.144{Enter}
return

:?:.такси1::
GoTaxi1:
    Gosub, PrepareGame
    SendInput, {t}/tpc 5796.750 -3309.108 40.729{Enter}
return

:?:.ад::
GoAD:
    Gosub, PrepareGame
    SendInput, {t}/tpc -2428 -3885 279{Enter}
return

:?:.казик::
GoKazik:
    Gosub, PrepareGame
    SendInput, {t}/tpc -802.142 5875.973 4.400{Enter}
return

:?:.вказик::
GoVkazik:
    Gosub, PrepareGame
    SendInput, {t}/tpc -3164.793 -4373.473 116.041{Enter}
return


; Вспомогательные функции
PrepareGame:
    Gui, 4: Hide
    Sleep 250
return

CloseTP:
    Gui, 4: Destroy
return

Команды:
; --- НАСТРОЙКИ СТИЛЯ ОКНА ПОМОЩИ ХЕЛПЕРА ---
Gui Help: New, +AlwaysOnTop -Caption +ToolWindow +LastFound ; Убран Caption для чистого плоского вида
Gui Help: Color, 11141A ; Глубокий темно-синий/черный фон

; --- БЛОК 1: ГОРЯЧИЕ КЛАВИШИ ---
Gui Help: Font, s11 Bold c7F56D9, Segoe UI ; Неоновый фиолетовый заголовок
Gui Help: Add, Text, x20 y15, ⚡ ГОРЯЧИЕ КЛАВИШИ (Alt + ...)
Gui Help: Add, Progress, x20 y40 w510 h1 Background252D3A c252D3A, 100 ; Тонкий разделитель

Gui Help: Font, s9 Medium cD1D5DB, Segoe UI ; Основной светло-серый текст
Gui Help: Add, Text, x30 y50, Alt + Q — Приветствие + Авто-репорт + /tp
Gui Help: Add, Text, x30 y75, Alt + A — "Здравствуйте, иду."
Gui Help: Add, Text, x30 y100, Alt + D — "Сейчас помогу, ожидайте."
Gui Help: Add, Text, x30 y125, Alt + S — "Приятной игры на Region."

; --- БЛОК 2: КОМАНДЫ ---
Gui Help: Font, s11 Bold c7F56D9, Segoe UI
Gui Help: Add, Text, x20 y160, 🛠 КОМАНДЫ (в чат)
Gui Help: Add, Progress, x20 y185 w510 h1 Background252D3A c252D3A, 100

Gui Help: Font, s9 Medium cD1D5DB, Segoe UI
; Левая колонка команд
Gui Help: Add, Text, x30 y195, /sp  — Слежка за ID
Gui Help: Add, Text, x30 y220, /so  — Выйти из слежки
Gui Help: Add, Text, x30 y245, /gc  — GetCar к себе
Gui Help: Add, Text, x30 y270, /ad  — Админы в сети
Gui Help: Add, Text, x30 y295, /kf  — Уволить из фракции

; Правая колонка команд (смещена для идеального выравнивания)
Gui Help: Add, Text, x290 y195, .рес — Воскресить (/rescue)
Gui Help: Add, Text, x290 y220, .ез  — Телепорт (/tp)
Gui Help: Add, Text, x290 y245, .ку  — Приветствие в чат
Gui Help: Add, Text, x290 y270, /kill — Убить (/hp ID 0)
Gui Help: Add, Text, x290 y295, /sm  — Маты (Chief only)

; --- БЛОК 3: СВЯЗЬ И ИНФО ---
Gui Help: Font, s11 Bold c7F56D9, Segoe UI
Gui Help: Add, Text, x20 y335, 📞 СВЯЗЬ И ИНФО
Gui Help: Add, Progress, x20 y360 w510 h1 Background252D3A c252D3A, 100

Gui Help: Font, s9 Medium cD1D5DB, Segoe UI
Gui Help: Add, Text, x30 y370, .дис / .га / .зга — Сбросить Discord (Ваш / ГА / зГА)
Gui Help: Add, Text, x30 y395, .афк — Уйти в AFK | .пиздец — Сигнал о завале репортов

; --- СНОСКИ / СЕРЫЕ ЗАМЕТКИ ---
Gui Help: Font, s9 Italic c64748B, Segoe UI ; Приглушенный серый для сносок
Gui Help: Add, Text, x20 y430 w510, * Транслит (например .ез) автоматически конвертируется в /команду.
Gui Help: Add, Text, x20 y450 w510, * Быстрый репорт: 1920x1080. Для других разрешений — пиши Python (1ssabtw).

; --- КНОПКА ЗАКРЫТИЯ ---
; Плоская стильная плашка, отцентрированная по вертикали (+0x200) и горизонтали (Center)
Gui Help: Font, s9 Norm c64748B
Gui Help: Add, Text, x20 y490 w510 h25 Center Background1F242F +0x200 gCloseHelp, [ Скрыть меню ]

; Отображение окна с новыми отступами
Gui Help: Show, w550 h535, Список команд хелпера
return

CloseHelp:
Gui Help: Destroy
return

; ==============================================================================
; УНИВЕРСАЛЬНАЯ ФУНКЦИЯ ВСТАВКИ (Работает для всех страниц)
; ==============================================================================
PasteText(Text) {
    Gui, 5: Hide
    Gui, 6: Hide
    Gui, 7: Hide
    Sleep 120
    OldClip := ClipboardAll
    Clipboard := Text
    Sleep 50
    Send, ^v
    Clipboard := OldClip
    OldClip := ""
}

; ==============================================================================
; ГУИ СТРАНИЦА 1 [1-16]
; ==============================================================================
Ответы:
Gui, 5: Destroy
Gui, 5: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 5: Color, 11141A ; Глубокий темно-синий/черный фон
Gui, 5: Font, s11 Bold c7F56D9, Segoe UI ; Неоновый фиолетовый заголовок
Gui, 5: Add, Text, x15 y10, 📝 БЫСТРЫЕ ОТВЕТЫ — СТРАНИЦА 1 [1-16]
Gui, 5: Add, Progress, x15 y35 w820 h1 Background252D3A c252D3A, 100 ; Тонкий темный разделитель
Gui, 5: Font, s9 Medium cD1D5DB, Segoe UI ; Основной светло-серый текст кнопок

; Левая колонка кнопок
Gui, 5: Add, Text, x20 y50 w390 h30 Center Background1F242F +0x200 gAnsFinka, 1. .финка (НКВД / Маркетплейс)
Gui, 5: Add, Text, x20 y85 w390 h30 Center Background1F242F +0x200 gAnsCho, 2. .че (Уточните вопрос)
Gui, 5: Add, Text, x20 y120 w390 h30 Center Background1F242F +0x200 gAnsDonat, 3. .донат (Проблемы с оплатой)
Gui, 5: Add, Text, x20 y155 w390 h30 Center Background1F242F +0x200 gAnsPromo, 4. .промо (Список всех кодов)
Gui, 5: Add, Text, x20 y190 w390 h30 Center Background1F242F +0x200 gAnsAmp, 5. .амп (Продажа авто / Планшет)
Gui, 5: Add, Text, x20 y225 w390 h30 Center Background1F242F +0x200 gAnsSchet, 6. .счет (Открытие счета в банке)
Gui, 5: Add, Text, x20 y260 w390 h30 Center Background1F242F +0x200 gAnsSim, 7. .симка (Салон связи)
Gui, 5: Add, Text, x20 y295 w390 h30 Center Background1F242F +0x200 gAnsDok, 8. .док (Как показать документы)

; Правая колонка кнопок
Gui, 5: Add, Text, x430 y50 w390 h30 Center Background1F242F +0x200 gAnsKv, 9. .кв (Покупка жилья)
Gui, 5: Add, Text, x430 y85 w390 h30 Center Background1F242F +0x200 gAnsNomera, 10. .номера (ГИБДД / ДПС)
Gui, 5: Add, Text, x430 y120 w390 h30 Center Background1F242F +0x200 gAnsGps, 11. .гпс (Навигатор в телефоне)
Gui, 5: Add, Text, x430 y155 w390 h30 Center Background1F242F +0x200 gAnsSid, 12. .сид (Запрос Static ID)
Gui, 5: Add, Text, x430 y190 w390 h30 Center Background1F242F +0x200 gAnsPuzo, 13. .свободный слот (Инфо)
Gui, 5: Add, Text, x430 y225 w390 h30 Center Background1F242F +0x200 gAnsRab, 14. .раб (Список работ)
Gui, 5: Add, Text, x430 y260 w390 h30 Center Background1F242F +0x200 gAnsUval, 15. .увал (Лидер / Зам / ДС)
Gui, 5: Add, Text, x430 y295 w390 h30 Center Background1F242F +0x200 gAnsGun, 16. .ганлиц (Лицензия в МВД)

; Нижние управляющие кнопки
Gui, 5: Font, s10 Bold c7F56D9, Segoe UI ; Фиолетовый цвет для кнопки "Далее"
Gui, 5: Add, Text, x670 y350 w150 h35 Center Background1F242F +0x200 gОтветы2, Далее >>
Gui, 5: Font, s10 Bold c64748B, Segoe UI ; Серый цвет для кнопки "Закрыть"
Gui, 5: Add, Text, x335 y350 w180 h35 Center Background1F242F +0x200 gCloseAns, ЗАКРЫТЬ

Gui, 5: Show, w845 h400, БыстрыеОтветы1
return

; ==============================================================================
; ГУИ СТРАНИЦА 2 [17-36]
; ==============================================================================
Ответы2:
Gui, 6: Destroy
Gui, 6: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 6: Color, 11141A ; Глубокий темно-синий/черный фон
Gui, 6: Font, s11 Bold c7F56D9, Segoe UI ; Неоновый фиолетовый заголовок
Gui, 6: Add, Text, x15 y10, 📝 БЫСТРЫЕ ОТВЕТЫ — СТРАНИЦА 2 [17-36]
Gui, 6: Add, Progress, x15 y35 w820 h1 Background252D3A c252D3A, 100 ; Тонкий темный разделитель
Gui, 6: Font, s9 Medium cD1D5DB, Segoe UI ; Основной светло-серый текст кнопок

; Левая колонка кнопок
Gui, 6: Add, Text, x20 y50 w390 h28 Center Background1F242F +0x200 gAnsBag, 17. .баг (Уже передано)
Gui, 6: Add, Text, x20 y80 w390 h28 Center Background1F242F +0x200 gAnsMed, 18. .мед (Медкарта в ЦГБ)
Gui, 6: Add, Text, x20 y110 w390 h28 Center Background1F242F +0x200 gAnsRel, 19. .рел (Проблемы с коннектом)
Gui, 6: Add, Text, x20 y140 w390 h28 Center Background1F242F +0x200 gAnsRp, 20. .рп (Это РП процесс)
Gui, 6: Add, Text, x20 y170 w390 h28 Center Background1F242F +0x200 gAnsUrp, 21. .урп (Узнайте IC путем)
Gui, 6: Add, Text, x20 y200 w390 h28 Center Background1F242F +0x200 gAnsVoice, 22. .войс (Микрофон / F8)
Gui, 6: Add, Text, x20 y230 w390 h28 Center Background1F242F +0x200 gAnsTech, 23. .тех (Тех-раздел ДС)
Gui, 6: Add, Text, x20 y260 w390 h28 Center Background1F242F +0x200 gAnsFunk, 24. .функ (Недоступно)
Gui, 6: Add, Text, x20 y290 w390 h28 Center Background1F242F +0x200 gAnsIzv, 25. .изв (Извинения)
Gui, 6: Add, Text, x20 y320 w390 h28 Center Background1F242F +0x200 gAnsExp, 26. .ехп (Получение опыта)

; Правая колонка кнопок
Gui, 6: Add, Text, x430 y50 w390 h28 Center Background1F242F +0x200 gAnsAuto, 27. .авто (Эвакуация / P)
Gui, 6: Add, Text, x430 y80 w390 h28 Center Background1F242F +0x200 gAnsKanis, 28. .канистра (Заправка / G)
Gui, 6: Add, Text, x430 y110 w390 h28 Center Background1F242F +0x200 gAnsPodnim, 29. .подним (Не лечим/поднимаем)
Gui, 6: Add, Text, x430 y140 w390 h28 Center Background1F242F +0x200 gAnsJb, 30. .жб (Жалоба на форум)
Gui, 6: Add, Text, x430 y170 w390 h28 Center Background1F242F +0x200 gAnsAdj, 31. .адж (К админу в ЛС ДС)
Gui, 6: Add, Text, x430 y200 w390 h28 Center Background1F242F +0x200 gAnsAdz, 32. .адз (Админ занят)
Gui, 6: Add, Text, x430 y230 w390 h28 Center Background1F242F +0x200 gAnsAds, 33. .адс (Админ оффлайн)
Gui, 6: Add, Text, x430 y260 w390 h28 Center Background1F242F +0x200 gAnsWeather, 34. .погода (Автоматическая)
Gui, 6: Add, Text, x430 y290 w390 h28 Center Background1F242F +0x200 gAnsNep, 35. .неп (Опишите подробнее)
Gui, 6: Add, Text, x430 y320 w390 h28 Center Background1F242F +0x200 gAnsHp, 36. .хп (HP не выдаем)

; Нижние управляющие кнопки
Gui, 6: Font, s10 Bold c7F56D9, Segoe UI ; Навигационные кнопки под фиолетовый акцент
Gui, 6: Add, Text, x20 y390 w150 h35 Center Background1F242F +0x200 gОтветы, << Назад
Gui, 6: Add, Text, x670 y390 w150 h35 Center Background1F242F +0x200 gОтветы3, Далее >>
Gui, 6: Font, s10 Bold c64748B, Segoe UI ; Серый цвет для кнопки "Закрыть"
Gui, 6: Add, Text, x335 y390 w180 h35 Center Background1F242F +0x200 gCloseAns, ЗАКРЫТЬ

Gui, 6: Show, w845 h440, БыстрыеОтветы2
return
; ==============================================================================
; ГУИ СТРАНИЦА 3 [37-56]
; ==============================================================================
Ответы3:
Gui, 7: Destroy
Gui, 7: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 7: Color, 11141A ; Глубокий темно-синий/черный фон
Gui, 7: Font, s11 Bold c7F56D9, Segoe UI ; Неоновый фиолетовый заголовок
Gui, 7: Add, Text, x15 y10, 📝 БЫСТРЫЕ ОТВЕТЫ — СТРАНИЦА 3 [37-56]
Gui, 7: Add, Progress, x15 y35 w820 h1 Background252D3A c252D3A, 100 ; Тонкий темный разделитель
Gui, 7: Font, s9 Medium cD1D5DB, Segoe UI ; Основной светло-серый текст кнопок

; Левая колонка кнопок
Gui, 7: Add, Text, x20 y50 w390 h28 Center Background1F242F +0x200 gAnsNov, 37. .нов (Новости сервера)
Gui, 7: Add, Text, x20 y80 w390 h28 Center Background1F242F +0x200 gAnsNik, 38. .ник (Смена через адм)
Gui, 7: Add, Text, x20 y110 w390 h28 Center Background1F242F +0x200 gAnsCrash, 39. .крашрп (Если вылетел)
Gui, 7: Add, Text, x20 y140 w390 h28 Center Background1F242F +0x200 gAnsIgrab, 40. .иограб (Правила ограбления)
Gui, 7: Add, Text, x20 y170 w390 h28 Center Background1F242F +0x200 gAnsCredit, 41. .кредит (Договоры на риск)
Gui, 7: Add, Text, x20 y200 w390 h28 Center Background1F242F +0x200 gAnsRem, 42. .рем (Починка в Тюнинге)
Gui, 7: Add, Text, x20 y230 w390 h28 Center Background1F242F +0x200 gAnsSdelka, 43. .сделка (Не следим)
Gui, 7: Add, Text, x20 y260 w390 h28 Center Background1F242F +0x200 gAnsImya, 44. .имя (Смена Non-RP ника)
Gui, 7: Add, Text, x20 y290 w390 h28 Center Background1F242F +0x200 gAnsAktual, 45. .актуал (Если актуально)
Gui, 7: Add, Text, x20 y320 w390 h28 Center Background1F242F +0x200 gAnsLechu, 46. .лечу (Уже лечу)

; Правая колонка кнопок
Gui, 7: Add, Text, x430 y50 w390 h28 Center Background1F242F +0x200 gAnsPom, 47. .пом (Сейчас помогу)
Gui, 7: Add, Text, x430 y80 w390 h28 Center Background1F242F +0x200 gAnsGosdom, 48. .госдом (Продажа дома)
Gui, 7: Add, Text, x430 y110 w390 h28 Center Background1F242F +0x200 gAnsRep, 49. .реп (Уточните вопрос)
Gui, 7: Add, Text, x430 y140 w390 h28 Center Background1F242F +0x200 gAnsNeuvid, 50. .неувид (Не видел)
Gui, 7: Add, Text, x430 y170 w390 h28 Center Background1F242F +0x200 gAnsDa, 51. .да (Да)
Gui, 7: Add, Text, x430 y200 w390 h28 Center Background1F242F +0x200 gAnsNet, 52. .нет (Нет)
Gui, 7: Add, Text, x430 y230 w390 h28 Center Background1F242F +0x200 gAnsNetp, 53. .нетп (Не телепортируем)
Gui, 7: Add, Text, x430 y260 w390 h28 Center Background1F242F +0x200 gAnsTolk, 54. .толкать (Как толкать авто)
Gui, 7: Add, Text, x430 y290 w390 h28 Center Background1F242F +0x200 gAnsAut, 55. .аут (Google Authenticator)
Gui, 7: Add, Text, x430 y320 w390 h28 Center Background1F242F +0x200 gAnsP, 56. .п (Приятной игры)

; Нижние управляющие кнопки (Gui, 7 — Страница 3)
Gui, 7: Font, s10 Bold c7F56D9, Segoe UI ; Фиолетовый акцент для навигации
Gui, 7: Add, Text, x20 y390 w150 h35 Center Background1F242F +0x200 gОтветы2, << Назад
Gui, 7: Add, Text, x670 y390 w150 h35 Center Background1F242F +0x200 gОтветы4, Далее >>

Gui, 7: Font, s10 Bold c64748B, Segoe UI ; Серый цвет для кнопки "Закрыть"
Gui, 7: Add, Text, x335 y390 w180 h35 Center Background1F242F +0x200 gCloseAns, ЗАКРЫТЬ

Gui, 7: Show, w845 h440, БыстрыеОтветы3
return

; ==============================================================================
; GUI СТРАНИЦА 4 [57-80]
; ==============================================================================
Ответы4:
Gui, 7: Destroy
Gui, 12: Destroy
Gui, 12: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 12: Color, 11141A
Gui, 12: Font, s11 Bold c7F56D9, Segoe UI
Gui, 12: Add, Text, x15 y10, 📝 БЫСТРЫЕ ОТВЕТЫ — СТРАНИЦА 4 [57-78]
Gui, 12: Add, Progress, x15 y35 w820 h1 Background252D3A c252D3A, 100
Gui, 12: Font, s9 Medium cD1D5DB, Segoe UI

; Левая колонка кнопок (57 - 67)
Gui, 12: Add, Text, x20 y50 w390 h28 Center Background1F242F +0x200 gAnsOpra, 57. .опра (Жалобу на forum)
Gui, 12: Add, Text, x20 y80 w390 h28 Center Background1F242F +0x200 gAnsNeuv, 58. .неув (Не увидел нарушений)
Gui, 12: Add, Text, x20 y110 w390 h28 Center Background1F242F +0x200 gAnsHz, 59. .хз (Нет информации)
Gui, 12: Add, Text, x20 y140 w390 h28 Center Background1F242F +0x200 gAnsKur, 60. .кур (Передам кураторам)
Gui, 12: Add, Text, x20 y170 w390 h28 Center Background1F242F +0x200 gAnsTexds, 61. .техдс (Канал тех-поддержка)
Gui, 12: Add, Text, x20 y200 w390 h28 Center Background1F242F +0x200 gAnsZakon, 62. .закон (Регулируется IC законами)
Gui, 12: Add, Text, x20 y230 w390 h28 Center Background1F242F +0x200 gAnsAkt, 63. .акт (Проблема актуальна?)
Gui, 12: Add, Text, x20 y260 w390 h28 Center Background1F242F +0x200 gAnsNepr, 64. .непр (Не предоставляем инфо)
Gui, 12: Add, Text, x20 y290 w390 h28 Center Background1F242F +0x200 gAnsNeraz, 65. .нераз (Не разглашаем инфо)
Gui, 12: Add, Text, x20 y320 w390 h28 Center Background1F242F +0x200 gAnsChh, 66. .чх (Бот CheatHunter)
Gui, 12: Add, Text, x20 y350 w390 h28 Center Background1F242F +0x200 gAnsNekom, 67. .неком (Не комментируем адм)

; Правая колонка кнопок (68 - 78) — ПРИВЯЗКИ ИСПРАВЛЕНЫ
Gui, 12: Add, Text, x430 y50 w390 h28 Center Background1F242F +0x200 gAnsOcenka, 68. .оценка (Не обсуждаем работу)
Gui, 12: Add, Text, x430 y80 w390 h28 Center Background1F242F +0x200 gAnsAdm, 69. .адм (Напишите администратору)
Gui, 12: Add, Text, x430 y110 w390 h28 Center Background1F242F +0x200 gAnsSlezhka, 70. .слежка (Процесс слежки / Репорт)
Gui, 12: Add, Text, x430 y140 w390 h28 Center Background1F242F +0x200 gAnsLoyal, 71. .лоял (Задача — помочь игроку)
Gui, 12: Add, Text, x430 y170 w390 h28 Center Background1F242F +0x200 gAnsPred, 72. .пред (Предупредил игрока)
Gui, 12: Add, Text, x430 y200 w390 h28 Center Background1F242F +0x200 gAnsPredu, 73. .преду (Предупреждение в /msg)
Gui, 12: Add, Text, x430 y230 w390 h28 Center Background1F242F +0x200 gAnsParkRule, 74. .парк (Явиться на паркинг)
Gui, 12: Add, Text, x430 y260 w390 h28 Center Background1F242F +0x200 gAnsRabpark, 75. .рабпарк (Рабочий паркинг)
Gui, 12: Add, Text, x430 y290 w390 h28 Center Background1F242F +0x200 gAnsMog, 76. .мог (Чем-то еще помочь?)
Gui, 12: Add, Text, x430 y320 w390 h28 Center Background1F242F +0x200 gAnsMoguHelp, 77. .могу (Чем-либо помочь?)
Gui, 12: Add, Text, x430 y350 w390 h28 Center Background1F242F +0x200 gAnsVas, 78. .вас (У вас остались вопросы?)

; Нижние управляющие кнопки
Gui, 12: Font, s10 Bold c7F56D9, Segoe UI
Gui, 12: Add, Text, x20 y410 w150 h35 Center Background1F242F +0x200 gОтветы3, << Назад

Gui, 12: Font, s10 Bold c64748B, Segoe UI
Gui, 12: Add, Text, x335 y390 w180 h35 Center Background1F242F +0x200 gCloseAns, ЗАКРЫТЬ

Gui, 12: Show, w845 h465, БыстрыеОтветы4
return
; ==============================================================================
; МЕТКИ ОТВЕТОВ СТРАНИЦА 1
; ==============================================================================
AnsFinka:
    PasteText("Чтобы приобрести финку НКВД откройте планшет(стрелочка вниз), и выберите приложение Маркетплейс, там нажмите на вкладку предмет, после чего ищите данный предмет.")
return

AnsCho:
    PasteText("Здравствуйте, уточните свой вопрос подробнее в репорт. Количество символов в репорт не ограничено, вы можете полностью расписать Вашу проблему/вопрос.")
return

AnsDonat:
    PasteText("Попробуйте перезайти/немного подождать. Если это не поможет, то рекомендую обратиться в раздел технической поддержки на форуме Region (forum.region.game)! Вам обязательно помогут.")
return

AnsPromo:
    PasteText("Промокод вы можете ввести через чат: /promo. На данный момент доступен промокод Region дает ежедневный кейс+20.000руб на 5 уровне персонажа, obtstart дает сразу кейс BMW, nazavod дает сразу 10.000руб.")
return

AnsAmp:
    PasteText("Вы можете выставить автомобиль через маркетплейс, достаньте планшет(стрелочка вниз) и зайдите во вкладку Маркетплейс.")
return

AnsSchet:
    PasteText("На карте “отделение С-Банка”, заходите, подходите к NPC - Е - открыть счет - выбираете тариф - нажмите на подтвердить.")
return

AnsSim:
    PasteText("Для того, чтобы купить сим-карту, на карте найдите салон Билайф")
return

AnsDok:
    PasteText("Для того чтобы показать документы, нажмите клавишу “G” рядом с игроком, затем выберите опцию Документы и выберите нужный документ.")
return

AnsKv:
    PasteText("Для покупки свободной квартиры нужно приехать на  локацию с иконкой «Квартиры» (всего таких иконок 60). Приходите туда, заходите в подъезд и выбирайте понравившееся жильё из свободного. Ещё вы можете приобрести квартиру у других игроков, либо найти её на маркетплейсе.")
return

AnsNomera:
    PasteText("Номера можно получить в холле здания ГИБДД, на карте отмечена как Дорожно-Патрульная Служба. При входе в здание вас встретит NPC у которого вы сможете купить номера на свое авто.")
return

AnsGps:
    PasteText("Достаньте телефон (Нажмите стрелочку вверх), далее выберите приложение навигатор.")
return

AnsSid:
    PasteText("Укажите static ID игрока, с которым у Вас происходил РП процесс.")
return

AnsPuzo:
    PasteText("текст")
return

AnsRab:
    PasteText("Игрокам предоставлена возможность выбрать для себя лучший способ заработка на работах, т.к. это все индивидуально. На данный момент существуют следующие работы: рабочий на заводе, дальнобойщик, курьер. Вы можете устроиться на работу через приложение “Моя работа” или вступить в одну из фракций.")
return

AnsUval:
    PasteText("Здравствуйте. К сожалению, ничем не можем помочь. Дождитесь своего лидера/заместителей или свяжитесь с куратором своей фракции в личные сообщения Discord.")
return

AnsGun:
    PasteText("Здравствуйте, чтобы получить лицензию на оружие, вам необходимо приехать в здание МВД и обратиться к сотрудникам полиции.")
return

AnsBag:
    PasteText("Знаем о данной проблеме, она уже передана разработчикам.")
return

AnsMed:
    PasteText("Приветствую. Для получения медицинской карты вам необходимо приехать в здание Центральной городской больницы, обратиться к сотрудникам.")
return

AnsRel:
    PasteText("Перезайдите через F1 > Direct Connect > Connect или полностью (F1 - Quit Game).")
return

AnsRp:
    PasteText("Извините, но это РП процесс, мы не вправе вмешиваться.")
return

AnsUrp:
    PasteText("Приветствую, данную информацию вы можете получить при взаимодействии с другими игроками/самостоятельным поиском непосредственно во время игрового процесса, либо другим доступным IC путем.")
return

AnsVoice:
    PasteText("Чтобы перезагрузить войс, попробуйте нажать F8. Если ничего не помогает - перезайдите в игру. Вы также можете перебиндить данную клавишу зайдя в F2 - Настройки - Управление - Общение.")
return

AnsTech:
    PasteText("Здравствуйте, напишите в технический раздел официального дискорд сервера “Region” - “тех-поддержка”.")
return

AnsFunk:
    PasteText("Данный функционал временно недоступен, извините за неудобства.")
return

AnsIzv:
    PasteText("Приносим свои извинения за предоставленные неудобства.")
return

AnsExp:
    PasteText("Каждый час (у каждого игрока своё время) Вам дается EХP.")
return

AnsAuto:
    PasteText("Чтобы эвакуировать Ваше авто воспользуйтесь маркером “Парковка” (Буква “P” на карте).")
return

AnsKanis:
    PasteText("Чтобы использовать канистру, нажмите G на авто - Действие - Канистра.")
return

AnsPodnim:
    PasteText("Приветствую. К сожалению, не видя всей ситуации мы не в праве лечить,поднимать или добивать игроков. Дождитесь сотрудников ЦГБ либо же окончания таймера смерти. Приносим свои извинения за возможные неудобства. ")
return

AnsJb:
    PasteText("Администрация не может выдавать наказания и выносить какие-либо вердикты не видя всей ситуации. Пожалуйста, если у Вас есть видеофиксация данного нарушения - оформите жалобу на форуме, спасибо большое за понимание.")
return

AnsAdj:
    PasteText("Приветствую. Обратитесь, пожалуйста, в дискорд к администратору, который выдал вам наказание или рассмотрел жалобу.")
return

AnsAdz:
    PasteText("Администратор сейчас занят или отошел, напишите ему в ЛС дискорда.")
return

AnsAds:
    PasteText("Администратор сейчас оффлайн, напишите ему в ЛС дискорда.")
return

AnsWeather:
    PasteText("К сожалению, администрация не контролирует данный процесс. Погода меняется автоматически и синхронизировано с погодой реального г. Санкт-Петербурга.")
return

AnsNep:
    PasteText("Опишите Вашу проблему/вопрос подробнее в f2 - поддержка для максимально точного ответа, пожалуйста.")
return

AnsHp:
    PasteText("Администрация не выдает HP. Купите таблетку в ЦГБ.")
return

AnsNov:
    PasteText("Следите за новостями сервера в официальном дискорде проекта.")
return

AnsNik:
    PasteText("На данный момент вы можете сменить NickName через администрацию сервера.")
return

AnsCrash:
    PasteText("Здравствуйте. Если у Вас есть доказательства краша - предоставьте его любому администратору в личные сообщения дискорда. Вас выпустят.")
return

AnsIgrab:
    PasteText("Здравствуйте, чтобы ограбить игрока, вам нужно: находится в семье, надеть маску, приобрести оружие, начать ограбление игрока можно в составе от 2 человек, наведитесь на игрока которого вы хотите ограбить (Должен быть в анимации руки вверх, либо поднять руки) нажмите G - Семья - Ограбить.")
return

AnsCredit:
    PasteText("Любые финансовые договоры (займы, кредиты и т.д) не относятся к ООС сделкам. Все подобные сделки игроки совершают на свой страх и риск. Администрация не несет ответственности и не является гарантом сделки.")
return

AnsRem:
    PasteText("Приветствую, чтобы починить своё авто вам необходимо приехать в Тюнинг (Обозначен на карте Диском с гаечным ключом).")
return

AnsSdelka:
    PasteText("Приветствую, администрация не следит за сделками игроков, запишите видео на случай обмана, чтобы оставить жалобу на игрока на форуме.")
return

AnsImya:
    PasteText("Ваше Имя Фамилия не подходит по правилам нашего сервера. Вам нужно сменить ник, напишите в репорт желаемый NickName чтобы администрация могла вам его поменять. После этого вас выпустят.")
return

AnsAktual:
    PasteText("Приветствую. Приносим извинения за столь долгое ожидание. Пожалуйста, если проблема еще актуальна, напишите нам. Спасибо за понимание.")
return

AnsLechu:
    PasteText("Приветствую. Уже лечу к Вам на помощь.")
return

AnsPom:
    PasteText("Приветствую. Сейчас помогу Вам, ожидайте.")
return

AnsGosdom:
    PasteText("Приветствую. Чтобы продать дом в государству, нужно открыть планшет. Вы получите 75% от его гос. цены. Если Вы невовремя оплатите налоги или забудете это сделать, дом слетит автоматически.")
return

AnsRep:
    PasteText("Приветствую. Пожалуйста, уточните свой вопрос подробнее. Администрация не летает на репорты по типу админ тп, админ можно поговорить, помогите, админ есть вопрос. Количество символов в /report неограничено, вы можете полностью расписать Вашу проблему/вопрос.")
return

AnsNeuvid:
    PasteText("Приветствую, к сожалению администрация не может увидеть это нарушение. Пожалуйста, если у Вас есть видеофиксация данного нарушения - оформите жалобу на форуме, спасибо большое за понимание.")
return

AnsDa:
    PasteText("Приветствую. Да.")
return

AnsNet:
    PasteText("Приветствую. Нет.")
return

AnsNetp:
    PasteText("Приветствую, администрация не телепортирует игроков, Вам нужно добраться до места самостоятельно.")
return

AnsTolk:
    PasteText("Транспорт можно толкнуть следующий образом, подойдите спереди или сзади транспорта, нажмите G - Действие - Толкать. Если такой функции нет, при наведении на авто, то этот транспорт толкать нельзя.")
return

AnsAut:
    PasteText("Для подключения Google authenticator вам нужно нажать F2 - Настройки - Безопасность.")
return

AnsP:
    PasteText("Приятной игры на Region <3")
return

AnsOpra:
    Gui, 12: Hide
    Sleep 50
    PasteText("Если у Вас есть видеодоказательства данного нарушения - оставьте жалобу на игрока на форуме (forum.region.game).")
return

AnsNeuv:
    Gui, 12: Hide
    Sleep 50
    PasteText("Не увидел нарушений.")
return

AnsHz:
    Gui, 12: Hide
    Sleep 50
    PasteText("К сожалению, не располагаем данной информацией.")
return

AnsKur:
    Gui, 12: Hide
    Sleep 50
    PasteText("Передам кураторам.")
return

AnsTexds:
    Gui, 12: Hide
    Sleep 50
    PasteText("Напишите в технический раздел официального дискорд-сервера Region в канале ""тех-поддержка"".")
return

AnsZakon:
    Gui, 12: Hide
    Sleep 50
    PasteText("Это регулируется IC законами. Изучить их можно в разделе ""Правительство"" на форуме: forum.region.game")
return

AnsAkt:
    Gui, 12: Hide
    Sleep 50
    PasteText("Ваша проблема актуальна?")
return

AnsNepr:
    Gui, 12: Hide
    Sleep 50
    PasteText("Не предоставляем подобную информацию.")
return

AnsNeraz:
    Gui, 12: Hide
    Sleep 50
    PasteText("Не разглашаем данную информацию.")
return

AnsChh:
    Gui, 12: Hide
    Sleep 50
    PasteText("Если у Вас есть фиксация с подозрительным моментом, то Вы можете предоставить его в Telegram: @Region_cheathunter_bot")
return

AnsNekom:
    Gui, 12: Hide
    Sleep 50
    PasteText("Не комментируем действия других администраторов.")
return

AnsOcenka:
    Gui, 12: Hide
    Sleep 50
    PasteText("Не обсуждаем и не оцениваем работу/наказания других администраторов, подобные вопросы необходимо обсудить с тем, кто выдал наказание/следил за ситуацией.")
return

AnsAdm:
    Gui, 12: Hide
    Sleep 50
    PasteText("Напишите администратору, который выдал Вам наказание. Если нужен его дискорд, напишите в обращение ник администратора.")
return

AnsSlezhka:
    Gui, 12: Hide
    Sleep 50
    PasteText("Администрация не может следить полностью за всем РП процессом, в случае нарушений от игроков - напишите репорт.")
return

AnsLoyal:
    Gui, 12: Hide
    Sleep 50
    PasteText("Мы игровые администраторы, наша задача помогать игрокам и пресечь нарушение, а не наказать игрока. Если игрок будет повторно замечен в нарушении правил проекта, он обязательно получит своё наказание. На данный момент нарушение устранено, а это и является главной нашей целью и задачей. Спасибо за бдительность, надеюь Ваша игра станет комфортней.")
return

AnsPred:
    Gui, 12: Hide
    Sleep 50
    PasteText("Предупредил игрока.")
return

AnsPredu:
    Gui, 12: Hide
    Sleep 50
    Gosub, PrepareGame
    SendInput, {t}/msg  Приветствую, Вы нарушаете правила проекта. Если данные действия с Вашей стороны не прекратятся, то я буду вынужден выдать наказание. Настоятельно рекомендую ознакомиться с правилами проекта, спасибо за понимание.{left 227}
return

AnsParkRule:
    Gui, 12: Hide
    Sleep 50
    PasteText("Чтобы заспавнить транспорт, Вам необходимо явиться на паркинг. На карте он отмечен синим знаком парковки ""Р"".")
return

AnsRabpark:
    Gui, 12: Hide
    Sleep 50
    PasteText("Чтобы заспавнить рабочий транспорт, Вам необходимо явиться на рабочий паркинг. На карте он отмечен синим транспортом с ключём.")
return

AnsMog:
    Gui, 12: Hide
    Sleep 50
    PasteText("Могу чем-то еще помочь?")
return

AnsMoguHelp:
    Gui, 12: Hide
    Sleep 50
    PasteText("Могу ли я Вам ещё чем-либо помочь?")
return

AnsVas:
    Gui, 12: Hide
    Sleep 50
    PasteText("У Вас остались вопросы?")
return

CloseAns:
    Gui, 5: Destroy
    Gui, 6: Destroy
    Gui, 7: Destroy
    Gui, 12: Destroy
    Sleep 50
    Gosub, PrepareGame ; Принудительно отдает фокус окну GTA, блокируя разворачивание Gui 2
return

Наказания:
Gui, 8: Destroy
Gui, 8: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 8: Color, 11141A ; Глубокий темно-синий/черный фон

; Главный заголовок панели
Gui, 8: Font, s11 Bold c7F56D9, Segoe UI 
Gui, 8: Add, Text, x20 y15 w810, ⚖️ ПАНЕЛЬ НАКАЗАНИЙ (Курсор встанет после команды для ввода ID)

; Главный горизонтальный разделитель под заголовком
Gui, 8: Add, Progress, x20 y42 w810 h1 Background252D3A c252D3A, 100

; Базовая настройка шрифта текста для всех кнопок-плиток
Gui, 8: Font, s9 Medium cD1D5DB, Segoe UI

; ================= СТОЛБЕЦ 1: БАНЫ (Ширина 250px) =================
Gui, 8: Font, s9 Bold cEF4444, Segoe UI ; Красный подзаголовок
Gui, 8: Add, Text, x20 y60 w250, [ БАНЫ ]
Gui, 8: Add, Progress, x20 y80 w250 h1 Background252D3A c252D3A, 100
Gui, 8: Font, s9 Medium cD1D5DB, Segoe UI

Gui, 8: Add, Text, x20 y95 w250 h28 Center Background1F242F +0x200 gAnsHardO, .хардо (Обход 9999)
Gui, 8: Add, Text, x20 y130 w250 h28 Center Background1F242F +0x200 gAnsHard7, .хард (Читы 7777)
Gui, 8: Add, Text, x20 y165 w250 h28 Center Background1F242F +0x200 gAnsHard9, .хард9 (Читы 9999)
Gui, 8: Add, Text, x20 y200 w250 h28 Center Background1F242F +0x200 gAnsOsab, .осаб (Оск. адм 5д)


; ================= СТОЛБЕЦ 2: JAIL / ТЮРЬМА (Ширина 290px) =================
Gui, 8: Font, s9 Bold cEAB308, Segoe UI ; Желтый подзаголовок
Gui, 8: Add, Text, x295 y60 w290, [ JAIL / ТЮРЬМА ]
Gui, 8: Add, Progress, x295 y80 w290 h1 Background252D3A c252D3A, 100
Gui, 8: Font, s9 Medium cD1D5DB, Segoe UI

; Парные мини-кнопки (Ширина по 140px, отступ между ними 10px)
Gui, 8: Add, Text, x295 y95 w140 h28 Center Background1F242F +0x200 gAnsNrd10, .нрд 10
Gui, 8: Add, Text, x445 y95 w140 h28 Center Background1F242F +0x200 gAnsNrd30, .нрд 30

Gui, 8: Add, Text, x295 y130 w140 h28 Center Background1F242F +0x200 gAnsNrp15, .нрп 15
Gui, 8: Add, Text, x445 y130 w140 h28 Center Background1F242F +0x200 gAnsNrp45, .нрп 45

Gui, 8: Add, Text, x295 y165 w140 h28 Center Background1F242F +0x200 gAnsDb20, .дб 20
Gui, 8: Add, Text, x445 y165 w140 h28 Center Background1F242F +0x200 gAnsDb50, .дб 50

Gui, 8: Add, Text, x295 y200 w140 h28 Center Background1F242F +0x200 gAnsDm30, .дм 30
Gui, 8: Add, Text, x445 y200 w140 h28 Center Background1F242F +0x200 gAnsDmg60, .дмг 60

Gui, 8: Add, Text, x295 y235 w140 h28 Center Background1F242F +0x200 gAnsPg30, .пг 30
Gui, 8: Add, Text, x445 y235 w140 h28 Center Background1F242F +0x200 gAnsPg90, .пг 90

; Широкие одиночные кнопки внутри блока тюрьмы (Ширина 290px)
Gui, 8: Add, Text, x295 y275 w290 h28 Center Background1F242F +0x200 gAnsSex, .секс (4.11 ОП)
Gui, 8: Add, Text, x295 y310 w290 h28 Center Background1F242F +0x200 gAnsNick, .смник (Смена ника)


; ================= СТОЛБЕЦ 3: МУТЫ (Ширина 250px) =================
Gui, 8: Font, s9 Bold c06B6D4, Segoe UI ; Бирюзовый подзаголовок
Gui, 8: Add, Text, x605 y60 w250, [ МУТЫ ]
Gui, 8: Add, Progress, x605 y80 w250 h1 Background252D3A c252D3A, 100
Gui, 8: Font, s9 Medium cD1D5DB, Segoe UI

Gui, 8: Add, Text, x605 y95 w250 h28 Center Background1F242F +0x200 gAnsMuz20, .муз 20 (ПиЗ)
Gui, 8: Add, Text, x605 y130 w250 h28 Center Background1F242F +0x200 gAnsMuz40, .муз 40 (ПиЗ)
Gui, 8: Add, Text, x605 y165 w250 h28 Center Background1F242F +0x200 gAnsOsam, .осам (Оск. адм 60м) ; Опечатка исправлена (было Gui 5)


; ================= НИЖНЯЯ ПАНЕЛЬ С КНОПКОЙ ЗАКРЫТИЯ =================
Gui, 8: Font, s10 Bold c64748B, Segoe UI ; Нейтральный серый шрифт
Gui, 8: Add, Text, x20 y370 w810 h35 Center Background1F242F +0x200 gClosePun, ЗАКРЫТЬ

; Вывод скорректированного окна панели (Ширина 850, Высота 425)
Gui, 8: Show, w850 h425, ПанельНаказаний
return

; ==============================================================================
; МАКСИМАЛЬНО УСКОРЕННАЯ ЛОГИКА
; ==============================================================================

PastePun(Command, Reason) {
    Gui, 8: Hide
    
    ; Формируем строку: Команда + два пробела + причина
    ; Мы поставим курсор между этими двумя пробелами
    FullText := Command . "  " . Reason 
    
    Old := ClipboardAll
    Clipboard := FullText
    
    Send, {t}
    Sleep, 20 ; Пауза, чтобы чат успел открыться
    Send, ^v
    
    ; Ускоряем нажатие клавиш до максимума
    SetKeyDelay, -1
    
    ; Считаем, сколько раз нажать "Влево" от конца строки:
    ; Длина причины + 1 пробел
    MoveLeft := StrLen(Reason) + 1
    Send, {Left %MoveLeft%}
    
    Clipboard := Old
}

; --- МЕТКИ НАКАЗАНИЙ ---

AnsHardO:
    PastePun("/hardban", "9999 Обход блокировки")
return
AnsHard7:
    PastePun("/hardban", "7777 Cheats")
return
AnsHard9:
    PastePun("/hardban", "9999 Cheats")
return
AnsOsab:
    PastePun("/ban", "5 3.7 ОП")
return
AnsSex:
    PastePun("/jail", "4.11 OП")
return
AnsNrd10:
    PastePun("/jail", "10 4.2 OП")
return
AnsNrd30:
    PastePun("/jail", "30 4.2 OП")
return
AnsNrp15:
    PastePun("/jail", "15 4.1 OП")
return
AnsNrp45:
    PastePun("/jail", "45 4.1 OП")
return
AnsDb20:
    PastePun("/jail", "20 4.2 OП")
return
AnsDb50:
    PastePun("/jail", "50 4.2 OП")
return
AnsDm30:
    PastePun("/jail", "30 4.9 ОП")
return
AnsDmg60:
    PastePun("/gunban", "60 4.9 ОП")
return
AnsPg30:
    PastePun("/jail", "30 4.14 ОП")
return
AnsPg90:
    PastePun("/jail", "90 4.14 ОП")
return
AnsMuz20:
    PastePun("/mute", "20 1.5 ПиЗ")
return
AnsMuz40:
    PastePun("/mute", "40 1.5 ПиЗ")
return
AnsOsam:
    PastePun("/mute", "60 3.7 ОП")
return
AnsNick:
    PastePun("/jail", "720 Смените Имя_Фамилия согласно п.2.6 общих правил")
return

SaveCheck:
Gui, 2: Submit, NoHide ; Считываем текущие состояния галочек в переменные
IniWrite, %Radio8%, Settings.ini, Settings, /gm
IniWrite, %Radio9%, Settings.ini, Settings, /esp4
IniWrite, %Radio10%, Settings.ini, Settings, /templeader 5
IniWrite, %Radio11%, Settings.ini, Settings, /hide
return

; --- ОБРАБОТЧИК ДЛЯ ОКНА КЛАВИШ ---
SaveSystemKeys:
Gui, 7: Submit

; Отключаем ВСЕ старые бинды
KeysToDisable := [KeyTele, KeyCmd, KeyAns, KeyPunish, KeyGreet, KeyGo, KeyWait, KeyPlay]
for each, k in KeysToDisable
    Hotkey, %k%, Off, UseErrorLevel

; Присваиваем новые
KeyTele := NewKeyTele, KeyCmd := NewKeyCmd, KeyAns := NewKeyAns, KeyPunish := NewKeyPunish
KeyGreet := NewKeyGreet, KeyGo := NewKeyGo, KeyWait := NewKeyWait, KeyPlay := NewKeyPlay

; Сохраняем в INI
IniWrite, %KeyTele%, Settings.ini, KeySetup, KeyTele
IniWrite, %KeyCmd%, Settings.ini, KeySetup, KeyCmd
IniWrite, %KeyAns%, Settings.ini, KeySetup, KeyAns
IniWrite, %KeyPunish%, Settings.ini, KeySetup, KeyPunish
IniWrite, %KeyGreet%, Settings.ini, KeySetup, KeyGreet
IniWrite, %KeyGo%, Settings.ini, KeySetup, KeyGo
IniWrite, %KeyWait%, Settings.ini, KeySetup, KeyWait
IniWrite, %KeyPlay%, Settings.ini, KeySetup, KeyPlay

; Включаем новые
Hotkey, %KeyTele%, Телепорты, On, UseErrorLevel
Hotkey, %KeyCmd%, Команды, On, UseErrorLevel
Hotkey, %KeyAns%, Ответы, On, UseErrorLevel
Hotkey, %KeyPunish%, Наказания, On, UseErrorLevel
Hotkey, %KeyGreet%, GreetLabel, On, UseErrorLevel
Hotkey, %KeyGo%, GoLabel, On, UseErrorLevel
Hotkey, %KeyWait%, WaitLabel, On, UseErrorLevel
Hotkey, %KeyPlay%, PlayLabel, On, UseErrorLevel

TrayTip, Success, Все бинды обновлены!, 2
return

; ==============================================================================
; GUI: ПАМЯТКА ПОЛНЫХ ОТВЕТОВ
; ==============================================================================
Pamytka:
Gui, 14: Destroy 
Gui, 14: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 14: Color, 11141A 

; --- ГЛАВНЫЙ ЗАГОЛОВОК ОКНА ---
Gui, 14: Font, s11 Bold c7F56D9, Segoe UI
Gui, 14: Add, Text, x10 y15 w580 +Center, 📖 ПАМЯТКА ПОЛНЫХ ОТВЕТОВ
Gui, 14: Add, Progress, x20 y42 w560 h1 Background252D3A c252D3A, 100

; --- ТЕКСТОВЫЕ НАЗВАНИЯ КОЛОНОК (Сдвинуты для новой плотной сетки) ---
Gui, 14: Font, s8 Bold c64748B, Segoe UI 
Gui, 14: Add, Text, x30 y50 w80, КОМАНДА
Gui, 14: Add, Text, x110 y50 w450, ПОЛНЫЙ ТЕКСТ ОТВЕТА

; --- СБОРКА HTML ТЕКСТА ПО ЧАСТЯМ (Ширина cmd уменьшена для всех строк) ---Вы
HTML_Data := "
(
    <style>
        body { 
            background-color: #11141A; 
            color: #D1D5DB; 
            font-family: 'Segoe UI', sans-serif; 
            font-size: 13px; 
            margin: 5px 10px; 
            overflow-x: hidden; 
            user-select: text !important; 
            -webkit-user-select: text !important; 
            -ms-user-select: text !important;
        }
        .row { margin-bottom: 10px; padding-bottom: 6px; border-bottom: 1px solid #1F242F; line-height: 1.4; }
        /* Минимальная ширина 42px плотно прижимает короткие команды, а длинные расширяет сама */
        .cmd { color: #00F2FE; font-family: 'Consolas', monospace; font-weight: bold; font-size: 13px; display: inline-block; min-width: 42px; margin-right: 2px; }
        .text { color: #E2E8F0; }
    </style>
    <div class='row'><span class='cmd'>.финка</span> — <span class='text'>Чтобы приобрести финку НКВД откройте планшет(стрелочка вниз), и выберите приложение ""Маркетплейс"", там нажмите на вкладку предмет, после чего ищите данный предмет.</span></div>
    <div class='row'><span class='cmd'>.че</span> — <span class='text'>Здравствуйте, уточните свой вопрос подробнее в репорт. Количество символов в репорт не ограничено, вы можете полностью расписать Вашу проблему/вопрос.</span></div>
    <div class='row'><span class='cmd'>.донат</span> — <span class='text'>Попробуйте перезайти/немного подождать. Если это не поможет, то рекомендую обратиться в раздел технической поддержки на форуме Region (forum.region.game)! Вам обязательно помогут.</span></div>
    <div class='row'><span class='cmd'>.промо</span> — <span class='text'>Промокод вы можете ввести через чат: /promo. На данный момент доступен промокод Region дает ежедневный кейс+20.000руб на 5 уровне персонажа, obtstart дает сразу кейс BMW, nazavod дает сразу 10.000руб.</span></div>
    <div class='row'><span class='cmd'>.амп</span> — <span class='text'>Вы можете выставить автомобиль через маркетплейс, достаньте планшет(стрелочка вниз) и зайдите во вкладку Маркетплейс.</span></div>
    <div class='row'><span class='cmd'>.счет</span> — <span class='text'>На карте “отделение С-Банка”, заходите, подходите к NPC - Е - открыть счет - выбираете тариф - нажмите на подтвердить.</span></div>
    <div class='row'><span class='cmd'>.симка</span> — <span class='text'>Для того, чтобы купить сим-карту, на карте найдите салон Билайф</span></div>
    <div class='row'><span class='cmd'>.кв</span> — <span class='text'>Для покупки свободной квартиры нужно приехать на локацию с иконкой «Квартиры» (всего таких иконок 60). Приходите туда, заходите в подъезд и выбирайте понравившееся жильё из свободного. Ещё вы можете приобрести квартиру у других игроков, либо найти её на маркетплейсе.</span></div>
    <div class='row'><span class='cmd'>.номера</span> — <span class='text'>Номера можно получить в холле здания ГИБДД, на карте отмечена как Дорожно-Патрульная Служба. При входе в здание вас встретит NPC у которого вы сможете купить номера на свое авто.</span></div>
    <div class='row'><span class='cmd'>.док</span> — <span class='text'>Для того чтобы показать документы, нажмите клавишу ""G"" рядом с игроком, затем выберите опцию ""Документы"" и выберите нужный документ.</span></div>
    <div class='row'><span class='cmd'>.гпс</span> — <span class='text'>Достаньте телефон (Нажмите стрелочку вверх), далее выберите приложение навигатор.</span></div>
    <div class='row'><span class='cmd'>.сид</span> — <span class='text'>Укажите static ID игрока с которым у Вас происходил РП процесс.</span></div>
)"

HTML_Data .= "
(
    <div class='row'><span class='cmd'>.раб</span> — <span class='text'>Игрокам предоставлена возможность выбрать для себя лучший способ заработка на работах, т.к. это все индивидуально. На данный момент существуют следующие работы: рабочий на заводе, дальнобойщик, курьер. Вы можете устроиться на работу через приложение ""Моя работа"" или вступить в одну из фракций.</span></div>
    <div class='row'><span class='cmd'>.увал</span> — <span class='text'>Здравствуйте. К сожалению, ничем не можем помочь. Дождитесь своего лидера/заместителей или свяжитесь с куратором своей фракции в личные сообщения Discord.</span></div>
    <div class='row'><span class='cmd'>.ганлиц</span> — <span class='text'>Здравствуйте, чтобы получить лицензию на оружие, вам необходимо приехать в здание МВД и обратиться к сотрудникам полиции.</span></div>
    <div class='row'><span class='cmd'>.фрак</span> — <span class='text'>Здравствуйте, время и место собеседования назначается отделом кадров внутри фракции. Следите за гос.новостями в чате или в дискорде фракции чтобы не пропустить собеседование! Либо придите и уточните напрямую у сотрудников в здании.</span></div>
    <div class='row'><span class='cmd'>.баг</span> — <span class='text'>Знаем о данной проблему, она уже передана разработчикам.</span></div>
    <div class='row'><span class='cmd'>.мед</span> — <span class='text'>Приветствую. Для получения медицинской карты вам необходимо приехать в здание Центральной городской больницы, обратиться к сотрудникам.</span></div>
    <div class='row'><span class='cmd'>.рел</span> — <span class='text'>Попробуйте перезайти через F1 &gt; Direct Connect &gt; Connect или полностью в игру (F1 - Quit Game).</span></div>
    <div class='row'><span class='cmd'>.рп</span> — <span class='text'>Извините, но это РП процесс, мы не вправе вмешиваться в него.</span></div>
    <div class='row'><span class='cmd'>.урп</span> — <span class='text'>Приветствую, данную информацию вы можете получить при взаимодействии с другими игроками/самостоятельным поиском непосредственно во время игрового процесса, либо другим доступным IC путем. Приятной игры и самого лучшего настроения на Region.</span></div>
    <div class='row'><span class='cmd'>.войс</span> — <span class='text'>Чтобы перезагрузить войс, попробуйте нажать F8. Если ничего не помогает - перезайдите в игру. Вы также можете перебиндить данную клавишу зайдя в F2 - Настройки - Управление - Общение.</span></div>
    <div class='row'><span class='cmd'>.тех</span> — <span class='text'>Здравствуйте, напишите в технический раздел официального дискорд сервера ""Region"" - ""тех-поддержка"".</span></div>
    <div class='row'><span class='cmd'>.функ</span> — <span class='text'>Данный функционал временно недоступен, приносим свои извинения.</span></div>
    <div class='row'><span class='cmd'>.фун</span> — <span class='text'>Данный функционал не присутствует у нас на сервере.</span></div>
)"

HTML_Data .= "
(
    <div class='row'><span class='cmd'>.изв</span> — <span class='text'>Приносим свои извинения за предоставленные неудобства.</span></div>
    <div class='row'><span class='cmd'>.ехп</span> — <span class='text'>Каждый час (у каждого игрока своё время) Вам дается EХP.</span></div>
    <div class='row'><span class='cmd'>.авто</span> — <span class='text'>Чтобы эвакуировать Ваше авто воспользуйтесь маркером ""Парковка"" (Буква ""P"" на карте). Приятной игры.</span></div>
    <div class='row'><span class='cmd'>.канистра</span> — <span class='text'>Чтобы использовать канистру, нажмите G на авто - Действие - Канистра.</span></div>
    <div class='row'><span class='cmd'>.подним</span> — <span class='text'>Приветствую. К сожалению, не видя всей ситуации мы не в праве лечить,поднимать или добивать игроков. Дождитесь сотрудников ЦГБ либо же окончания таймера смерти. Приносим свои извинения за возможные неудобства.</span></div>
    <div class='row'><span class='cmd'>.жб</span> — <span class='text'>Администрация не может выдавать наказания и выносить какие-либо вердикты не видя всей ситуации. Пожалуйста, если у Вас есть видеофиксация данного нарушения - оформите жалобу на форуме (forum.region.game), спасибо большое за понимание.</span></div>
    <div class='row'><span class='cmd'>.адж</span> — <span class='text'>Приветствую. Обратитесь, пожалуйста, в дискорд к администратору, который выдал вам наказание или рассмотрел жалобу.</span></div>
    <div class='row'><span class='cmd'>.адз</span> — <span class='text'>Данный администратор сейчас занят другим делом или отошел от компьютера на короткое время, напишите ему в личные сообщения в дискорде.</span></div>
    <div class='row'><span class='cmd'>.адс</span> — <span class='text'>Данный администратор сейчас отсутствует на сервере, напишите ему в личные сообщения в дискорде.</span></div>
    <div class='row'><span class='cmd'>.погода</span> — <span class='text'>К сожалению, администрация не контролирует данный процесс. Погода меняется автоматически и синхронизировано с погодой реального г. Санкт-Петербурга.</span></div>
    <div class='row'><span class='cmd'>.неп</span> — <span class='text'>Опишите Вашу проблему/вопрос подробнее в f2 - поддержка для максимально точного ответа, пожалуйста.</span></div>
    <div class='row'><span class='cmd'>.хп</span> — <span class='text'>Администрация не выдает HP. Купите таблетку у сотрудников ЦГБ.</span></div>
    <div class='row'><span class='cmd'>.аним</span> — <span class='text'>Здравствуйте, забиндить анимации можно в F2 - Анимации. Использовать анимацию можно при нажатии клавиши ""U"".</span></div>
    <div class='row'><span class='cmd'>.ид</span> — <span class='text'>Здравствуйте, укажите, пожалуйста, ID нарушителя.</span></div>
    <div class='row'><span class='cmd'>.жба</span> — <span class='text'>Вы можете написать жалобу на форум, если не согласны с решением администратора.</span></div>
)"

HTML_Data .= "
(
    <div class='row'><span class='cmd'>.п</span> — <span class='text'>Приятной игры на Region &lt;3.</span></div>
    <div class='row'><span class='cmd'>.нов</span> — <span class='text'>Следите за новостями сервера в официальном дискорде проекта.</span></div>
    <div class='row'><span class='cmd'>.ник</span> — <span class='text'>На данный момент вы можете сменить NickName через администрацию сервера.</span></div>
    <div class='row'><span class='cmd'>.крашрп</span> — <span class='text'>Здравствуйте. Если у Вас есть доказательства краша - предоставьте его любому администратору в личные сообщения дискорда. Вас выпустят.</span></div>
    <div class='row'><span class='cmd'>.иограб</span> — <span class='text'>Здравствуйте, чтобы ограбить игрока, вам нужно: находится в семье, одеть маску, приобрести оружие, начать ограбление игрока можно в составе от 2 человек, наведитесь на игрока которого вы хотите ограбить нажмите G - Семья - Ограбить.</span></div>
    <div class='row'><span class='cmd'>.кредит</span> — <span class='text'>Любые финансовые договоры (займы, кредиты и т.д) не относятся к ООС сделкам. Все подобные сделки игроки совершают на свой страх и риск. Администрация не несет ответственности и не является гарантом сделки.</span></div>
    <div class='row'><span class='cmd'>.рем</span> — <span class='text'>Приветствую, чтобы починить своё авто вам необходимо приехать в Тюнинг (Обозначен на карте Диском с гаечным ключом).</span></div>
    <div class='row'><span class='cmd'>.сделка</span> — <span class='text'>Приветствую, администрация не следит за сделками игроков, запишите видео на случай обмана, чтобы оставить жалобу на игрока на форуме.</span></div>
    <div class='row'><span class='cmd'>.имя</span> — <span class='text'>Ваше Имя Фамилия не подходит по правилам нашего сервера. Вам нужно сменить ник, напишите в репорт желаемый NickName чтобы администрация могла вам его поменять. После этого вас выпустят.</span></div>
    <div class='row'><span class='cmd'>.актуал</span> — <span class='text'>Приветствую. Приносим извинения за столь долгое ожидание. Пожалуйста, если проблема еще актуальна, напишите нам. Спасибо за понимание.</span></div>
    <div class='row'><span class='cmd'>.лечу</span> — <span class='text'>Приветствую. Уже лечу к Вам на помощь.</span></div>
    <div class='row'><span class='cmd'>.пом</span> — <span class='text'>Приветствую. Сейчас помогу Вам, ожидайте.</span></div>
    <div class='row'><span class='cmd'>.госдом</span> — <span class='text'>Приветствую. Чтобы продать дом в государству, нужно открыть планшет. Вы получите 75% от его гос. цены. Если Вы невовремя оплатите налоги или забудете это сделать, дом слетит автоматически.</span></div>
    <div class='row'><span class='cmd'>.реп</span> — <span class='text'>Приветствую. Пожалуйста, уточните свой вопрос подробнее. Администрация не летает на репорты по типу ""админ тп"", ""админ можно поговорить"", ""помогите"", ""админ есть вопрос"". Количество символов в /report неограничено, вы можете полностью расписать Вашу проблему/вопрос.</span></div>
    <div class='row'><span class='cmd'>.неувид</span> — <span class='text'>Приветствую, к сожалению администрация не может увидеть это нарушение. Пожалуйста, если у Вас есть видеофиксация данного нарушения - оформите жалобу на форуме, спасибо большое за понимание.</span></div>
    <div class='row'><span class='cmd'>.да</span> — <span class='text'>Приветствую. Да.</span></div>
    <div class='row'><span class='cmd'>.нет</span> — <span class='text'>Приветствую. Нет.</span></div>
    <div class='row'><span class='cmd'>.нетп</span> — <span class='text'>Приветствую, администрация не телепортирует игроков, Вам нужно добраться до места самостоятельно.</span></div>
    <div class='row'><span class='cmd'>.толкать</span> — <span class='text'>Транспорт можно толкать, подойдите спереди или сзади транспорта, нажмите G - Действие - Толкать. Если такой функции нет, при наведении на авто, то этот транспорт толкать нельзя.</span></div>
    <div class='row'><span class='cmd'>.аут</span> — <span class='text'>Для подключения Google authenticator вам нужно нажать F2 - Настройки - Безопасность.</span></div>
    <div class='row'><span class='cmd'>.опра</span> — <span class='text'>Если у Вас есть видеодоказательства данного нарушения - оставьте жалобу на игрока на форуме (forum.region.game).</span></div>
    <div class='row'><span class='cmd'>.неув</span> — <span class='text'>Не увидел нарушений.</span></div>
    <div class='row'><span class='cmd'>.хз</span> — <span class='text'>К сожалению, не располагаем данной информацией.</span></div>
    <div class='row'><span class='cmd'>.кур</span> — <span class='text'>Передам кураторам.</span></div>
    <div class='row'><span class='cmd'>.техдс</span> — <span class='text'>Напишите в технический раздел официального дискорд-сервера Region в канале ""тех-поддержка"".</span></div>
    <div class='row'><span class='cmd'>.закон</span> — <span class='text'>Это регулируется IC законами. Изучить их можно в разделе ""Правительство"" на форуме: forum.region.game</span></div>
    <div class='row'><span class='cmd'>.акт</span> — <span class='text'>Ваша проблема актуальна?</span></div>
    <div class='row'><span class='cmd'>.непр</span> — <span class='text'>Не предоставляем подобную информацию.</span></div>
    <div class='row'><span class='cmd'>.нераз</span> — <span class='text'>Не разглашаем данную информацию.</span></div>
    <div class='row'><span class='cmd'>.чх</span> — <span class='text'>Если у Вас есть фиксация с подозрительным моментом, то Вы можете предоставить его в Telegram: @Region_cheathunter_bot</span></div>
    <div class='row'><span class='cmd'>.неком</span> — <span class='text'>Не комментируем действия других администраторов.</span></div>
    <div class='row'><span class='cmd'>.оценка</span> — <span class='text'>Не обсуждаем и не оцениваем работу/наказания других администраторов, подобные вопросы необходимо обсудить с тем, кто выдал наказание/следил за ситуацией.</span></div>
    <div class='row'><span class='cmd'>.адм Mau</span> — <span class='text'>Напишите администратору, который выдал Вам наказание. Если нужен его дискорд, напишите в обращение ник администратора.</span></div>
    <div class='row'><span class='cmd'>.слежка</span> — <span class='text'>Администрация не может следить полностью за всем РП процессом, в случае нарушений от игроков - напишите репорт.</span></div>
    <div class='row'><span class='cmd'>.лоял</span> — <span class='text'>Мы игровые администраторы, наша задача помогать игрокам и пресечь нарушение, а не наказать игрока. Если игрок будет повторно замечен в нарушении правил проекта, он обязательно получит своё наказание. На данный момент нарушение устранено, а это и является главной нашей целью и задачей. Спасибо за бдительность, надеюсь Ваша игра станет комфортней.</span></div>
    <div class='row'><span class='cmd'>.пред</span> — <span class='text'>Предупредил игрока.</span></div>
    <div class='row'><span class='cmd'>.преду</span> — <span class='text'>/msg  Приветствую, Вы нарушаете правила проекта. Если данные действия с Вашей стороны не прекратятся, то я буду вынужден выдать наказание. Настоятельно рекомендую ознакомиться с правилами проекта, спасибо за понимание.</span></div>
    <div class='row'><span class='cmd'>.парк</span> — <span class='text'>Чтобы заспавнить транспорт, Вам необходимо явиться на паркинг. На карте он отмечен синим знаком парковки ""Р"".</span></div>
    <div class='row'><span class='cmd'>.рабпарк</span> — <span class='text'>Чтобы заспавнить рабочий транспорт, Вам необходимо явиться на рабочий паркинг. На карте он отмечен синим транспортом с ключём.</span></div>
    <div class='row'><span class='cmd'>.мог</span> — <span class='text'>Могу чем-то еще помочь?</span></div>
    <div class='row'><span class='cmd'>.могу</span> — <span class='text'>Могу ли я Вам ещё чем-либо помочь?</span></div>
    <div class='row'><span class='cmd'>.вас</span> — <span class='text'>У Вас остались вопросы?</span></div>
)"

; --- ВЫВОД ПАНЕЛИ И ПЕРЕДАЧА СКЛЕЕННОЙ ПЕРЕМЕННОЙ ---
Gui, 14: Add, ActiveX, x15 y70 w570 h360 vDocPam, HTMLFile
DocPam.Write(HTML_Data)

; --- НИЖНЯЯ ЛИНИЯ И КНОПКА ЗАКРЫТИЯ ---
Gui, 14: Add, Progress, x20 y422 w560 h1 Background252D3A c252D3A, 100
Gui, 14: Font, s9 Bold c64748B, Segoe UI
Gui, 14: Add, Text, x210 y435 w180 h35 Center Background1F242F +0x200 gClosePamytka, ПОНЯТНО

Gui, 14: Show, w600 h485, Памятка ответов
return

ClosePamytka:
    Gui, 14: Destroy
    Sleep 50
    Gosub, PrepareGame
return

; Метка для открытия меню по кнопке
OpenMainMenuLabel:
Gui, 2: Show
return

ClosePun:
    Gui, 8: Destroy
return

; ==============================================================================
; GUI 15: БЫСТРЫЙ ПЕРЕХОД ПО ССЫЛКАМ (ДЛЯ АДМИНИСТРАЦИИ REGION)
; ==============================================================================
LinksMenu:
Gui, 15: Destroy ; Защита от наложения окон при повторном клике
Gui, 15: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 15: Color, 11141A ; Наш фирменный глубокий темный фон

; --- ГЛАВНЫЙ ЗАГОЛОВОК ОКНА ---
Gui, 15: Font, s11 Bold c7F56D9, Segoe UI
Gui, 15: Add, Text, x10 y15 w580 +Center, 🔗 ПОЛЕЗНЫЕ ССЫЛКИ И РЕСУРСЫ
Gui, 15: Add, Progress, x20 y42 w560 h1 Background252D3A c252D3A, 100

; --- HTML-СПИСОК С КЛИКАБЕЛЬНЫМИ КАРТОЧКАМИ ---
Gui, 15: Add, ActiveX, x15 y50 w570 h360 vDocLinks, HTMLFile
DocLinks.write("
(
    <style>
        body { 
            background-color: #11141A; 
            color: #D1D5DB; 
            font-family: 'Segoe UI', sans-serif; 
            font-size: 13px; 
            margin: 5px 10px; 
            overflow-x: hidden; 
            user-select: none;
            -webkit-user-select: none;
        }
        .link-card { 
            display: block;
            background-color: #1F242F;
            padding: 8px 15px;
            margin-bottom: 8px;
            border-radius: 4px;
            text-decoration: none;
            border-left: 3px solid #7F56D9; /* Фиолетовый маркер слева */
        }
        .title { 
            color: #00F2FE; /* Неоновый циан */
            font-weight: bold; 
            font-size: 13px;
            display: block;
            margin-bottom: 1px;
        }
        .desc { 
            color: #94A3B8; 
            font-size: 11px;
        }
    </style>
    
    <a href='https://forum.region.game/' target='_blank' class='link-card'>
        <span class='title'>🌐 Форум Region</span>
        <span class='desc'>Главная страница официального форума проекта.</span>
    </a>

    <a href='https://forum.region.game/threads/obshchiye-pravila.78/' target='_blank' class='link-card'>
        <span class='title'>📜 Общие правила</span>
        <span class='desc'>Регламент основных правил и мер наказаний сервера (ОП).</span>
    </a>

    <a href='https://forum.region.game/threads/pravila-ograblenii-i-pokhishchenii.92/' target='_blank' class='link-card'>
        <span class='title'>🥷 Правила ограблений и похищений</span>
        <span class='desc'>Свод правил для криминальных структур и проведения ограблений (ПОиП).</span>
    </a>

    <a href='https://forum.region.game/threads/pravila-semeinykh-organizatsii.109/' target='_blank' class='link-card'>
        <span class='title'>🏠 Правила семейных организаций</span>
        <span class='desc'>Правила, касающиеся неофициальных фракций и семейных союзов (ПСО).</span>
    </a>

    <a href='https://forum.region.game/threads/pravila-igrovykh-zon.260/' target='_blank' class='link-card'>
        <span class='title'>🎯 Правила игровых зон</span>
        <span class='desc'>Специфика и правила Зеленых Зон (ЗЗ), а также зон проведения мероприятий.</span>
    </a>

    <a href='https://forum.region.game/threads/pravila-ob-igrovom-imushchestve.79/' target='_blank' class='link-card'>
        <span class='title'>💵 Правила об игровом имуществе</span>
        <span class='desc'>Регламент владения, передачи, купли и продажи имущества на сервере.</span>
    </a>

    <a href='https://forum.region.game/threads/pravila-proverki-na-storonneye-po.85/' target='_blank' class='link-card'>
        <span class='title'>💻 Правила проверки на стороннее ПО</span>
        <span class='desc'>Официальная инструкция и регламент вызова игроков на проверку софта/читов.</span>
    </a>

    <a href='https://forum.region.game/threads/pravila-dlya-liderov-organizatsii.80/' target='_blank' class='link-card'>
        <span class='title'>🎖 Правила для лидеров организаций</span>
        <span class='desc'>Обязанности, ограничения и правила для руководства государственных и крайм фракций.</span>
    </a>

    <a href='https://forum.region.game/threads/pravila-gosudarstvennykh-organizatsii.81/' target='_blank' class='link-card'>
        <span class='title'>⚖️ Правила государственных организаций</span>
        <span class='desc'>Свод правил для сотрудников силовых структур, мэрии и больниц (ПГО).</span>
    </a>
)")

; --- НИЖНЯЯ ЛИНИЯ И КНОПКА ЗАКРЫТИЯ ---
Gui, 15: Add, Progress, x20 y422 w560 h1 Background252D3A c252D3A, 100
Gui, 15: Font, s9 Bold c64748B, Segoe UI
Gui, 15: Add, Text, x210 y435 w180 h35 Center Background1F242F +0x200 gCloseLinksMenu, ПОНЯТНО

; Окно адаптировано под размеры памятки для визуальной гармонии
Gui, 15: Show, w600 h485, Полезные ссылки
return

CloseLinksMenu:
    Gui, 15: Destroy
    Sleep 50
    Gosub, PrepareGame ; Возвращает фокус в GTA, блокируя самопроизвольный вылет главного меню
return

; --- БЛОК АВТООБНОВЛЕНИЯ ---
CheckForUpdates:
    ; Если обновление уже идет или пользователь нажал "Нет" в этой сессии - выходим
    if (UpdateInProgress || UserDeclinedUpdate) 
        return
        
    UpdateInProgress := true

    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    try {
        whr.Open("GET", UpdateURL . "?nocache=" . A_TickCount, true)
        whr.Send()
        whr.WaitForResponse()
        if (whr.Status != 200) {
            UpdateInProgress := false
            return
        }
        NewVersion := Trim(StrSplit(whr.ResponseText, "`n", "`r").1)
    } catch {
        UpdateInProgress := false
        return
    }

    if (NewVersion > CurrentVersion) {
        ; Добавлена информация про Changelog в тело MsgBox
        MsgBox, 4, Обновление, 
        ( LTrim
        Доступна версия: %NewVersion%
        Ваша версия: %CurrentVersion%

        Ознакомиться со списком изменений можно во вкладке Changelog.

        Обновиться сейчас?
        )
        
        IfMsgBox Yes
        {
            UrlDownloadToFile, %DownloadURL%, %A_ScriptFullPath%.new
            if (!ErrorLevel) {
                BatchFile =
                (LTrim
                @echo off
                timeout /t 2 /nobreak > nul
                del /f /q "%A_ScriptFullPath%"
                ren "%A_ScriptFullPath%.new" "%A_ScriptName%"
                start "" "%A_ScriptFullPath%"
                del "`%~f0"
                )
                FileDelete, update.bat
                FileAppend, %BatchFile%, update.bat
                Run, update.bat,, Hide
                ExitApp
            } else {
                MsgBox, 16, Ошибка, Не удалось скачать файл.
            }
        }
        else ; Если пользователь нажал "Нет"
        {
            UserDeclinedUpdate := true 
        }
    }
    
    UpdateInProgress := false
return

OpenPunishmentFile:
PunishPath := A_WorkingDir "\Punishment.txt"
Run, edit "%PunishPath%"
return

UpdateCounter:
    Gosub, AddRep
return

return
^F9::reload
^F10::Exitapp