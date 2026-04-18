DllCall("Winhttp.dll\WinHttpSetOption", "Ptr", 0, "UInt", 31, "UInt*", 0x00000800, "UInt", 4)

#SingleInstance Force
; --- ОПТИМИЗИРОВАННЫЙ БЛОК ИНИЦИАЛИЗАЦИИ ---
#NoEnv
ListLines Off
Process, Priority, , A

Global CurrentVersion := "1.0.0"
Global UpdateURL      := "https://raw.githubusercontent.com/PythonReg/RegionHelperUpdate/main/version.txt"
Global DownloadURL    := "https://github.com/PythonReg/RegionHelperUpdate/raw/main/Region%20help.exe"

FormatTime, CurrentDate,, ddMM
IniRead, SavedDate, Settings.ini, ANS, CurrentDateT, 0
IniRead, SavedWeek, Settings.ini, ANS, Week, 0

; Проверка дня
if (SavedDate == CurrentDate) {
    IniRead, DayANS, Settings.ini, ANS, DayANS, 0
} else {
    DayANS := 0
    IniWrite, %CurrentDate%, Settings.ini, ANS, CurrentDateT
    IniWrite, 0, Settings.ini, ANS, DayANS
}

; Проверка недели
if (SavedWeek == A_YWeek) {
    IniRead, WeekANS, Settings.ini, ANS, WeekANS, 0
} else {
    WeekANS := 0
    IniWrite, %A_YWeek%, Settings.ini, ANS, Week
    IniWrite, 0, Settings.ini, ANS, WeekANS
}

IniRead, SavedRes, Settings.ini, Settings, SelectedRes, 1920x1080
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
IniRead, KeyGreet, Settings.ini, KeySetup, KeyGreet, !q
IniRead, KeyGo, Settings.ini, KeySetup, KeyGo, !a
IniRead, KeyWait, Settings.ini, KeySetup, KeyWait, !d
IniRead, KeyPlay, Settings.ini, KeySetup, KeyPlay, !s

IniRead, qdis, Settings.ini, Discord, qdis, % ""
IniRead, gadis, Settings.ini, Discord, gadis, % ""
IniRead, zgadis, Settings.ini, Discord, zgadis, % ""
Version := "v.1.0.0" ; Версия твоего скрипта
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
Gui, 2: +LastFound -MaximizeBox +Caption
Gui, 2: Color, 1e2124, 2f3136 ; Темный фон: 1e2124 (окно), 2f3136 (поля)
Gui, 2: Font, s10 cFFFFFF, Segoe UI

; --- ШАПКА (Header) ---
Gui, 2: Font, s12 Bold cFFFFFF
Gui, 2: Add, Text, x0 y0 w900 h45 +Center +0x200 Background23272a, REGION HELPER ;
Gui, 2: Font, s8 Norm c4f545c
Gui, 2: Add, Text, x840 y12 w50 h20 +BackgroundTrans +Right, %Version%

; --- БОКОВОЕ МЕНЮ (Sidebar) ---
Gui, 2: Font, s9 Bold c7289da
Gui, 2: Add, Text, x20 y60 w120 h20, НАВИГАЦИЯ
Gui, 2: Font, s9 Norm cFFFFFF
Gui, 2: Add, Button, x15 y85 w130 h30 gПомощь, Помощь
Gui, 2: Add, Button, x15 y120 w130 h30 gТелепорты, Телепорты
Gui, 2: Add, Button, x15 y155 w130 h30 gКоманды, Команды
Gui, 2: Add, Button, x15 y190 w130 h30 gОтветы, Ответы
Gui, 2: Add, Button, x15 y225 w130 h30 gНаказания, Наказания
Gui, 2: Add, Button, x15 y260 w130 h30 gShortCommands, Сокращения

Gui, 2: Add, Button, x15 y510 w130 h40 gSaveData, СОХРАНИТЬ
Gui, 2: Add, Button, x15 y560 w130 h40 gOpenKeySettings, УПРАВЛЕНИЕ БИНДАМИ

; --- ЦЕНТРАЛЬНЫЙ БЛОК (ГОРЯЧИЕ КЛАВИШИ) ---
Gui, 2: Font, s10 Bold c7289da
Gui, 2: Add, Text, x170 y60 w410 h25, ГОРЯЧИЕ КЛАВИШИ
Gui, 2: Add, Progress, x170 y82 w410 h1 Background333333 c333333, 100
Gui, 2: Font, s9 Norm cFFFFFF

; Первый столбец (Hot1 - Hot10)
y_p := 95
names1 := ["Не work", "Удалить транспорт", "GM", "ТП к игроку", "Быстрый репорт", "Быстрый ответ", "Не Work", "ТП на метку", "ТП авто к себе", "Добавить +1 репорт"]
Loop, 10 {
    vName := "Hot" . A_Index
    Gui, 2: Add, Hotkey, x170 y%y_p% w50 h24 v%vName%, % KEY%A_Index%
    Gui, 2: Add, Text, x225 y%y_p% w140 h24 +0x200, % names1[A_Index]
    y_p += 31
}

; Второй столбец (Выборочные индексы из твоего списка)
y_p := 95
; Массив соответствия: Название | Номер переменной (vHotXX) | Номер клавиши (KEYXX)
names2 := [ ["Убить игрока", 19], ["Воскресить игрока", 12], ["ТП к себе", 15], ["Памятка", 14], ["Наказания", 13], ["Не Work", 16], ["Не Work", 17], ["Вкл/Выкл ESP", 18], ["/veh rs520", 20] ]

for index, item in names2 {
    vIdx := item[2] ; Получаем номер (например, 19)
    Gui, 2: Add, Hotkey, x380 y%y_p% w50 h24 vHot%vIdx%, % KEY%vIdx%
    Gui, 2: Add, Text, x435 y%y_p% w140 h24 +0x200, % item[1]
    y_p += 31
}

; --- ПРАВАЯ ПАНЕЛЬ (Персонализация) ---
Gui, 2: Font, s10 Bold c7289da
Gui, 2: Add, Text, x610 y60 w275 h25, ПЕРСОНАЛИЗАЦИЯ
Gui, 2: Add, Progress, x610 y82 w275 h1 Background333333 c333333, 100

Gui, 2: Font, s9 Norm cFFFFFF
Gui, 2: Add, Button, x610 y95 w275 h30 gdiscord, Установить Discord
Gui, 2: Add, Button, x610 y130 w135 h30 gdiscordga, Discord ГА
Gui, 2: Add, Button, x750 y130 w135 h30 gdiscordzga, Discord зГА

; --- РАЗРЕШЕНИЕ ЭКРАНА ---
Gui, 2: Font, s9 Bold c7289da
Gui, 2: Add, Text, x610 y180 w275 h20, РАЗРЕШЕНИЕ ЭКРАНА
Gui, 2: Font, s9 Norm cFFFFFF
Gui, 2: Add, DropDownList, x610 y205 w275 vScreenRes gUpdateRes, 2560x1440|2554x1411|1920x1080|1920x1080 (5:4)|1680x1050|1600x900|1440x900|1366x768|1366x768 (5:3)|1280x1024|1280x960

; --- ПОЛ ---
Gui, 2: Font, s10 Bold c7289da
Gui, 2: Add, Text, x610 y280 w275 h20, ВАШ ПОЛ:
Gui, 2: Font, s9 Norm cFFFFFF
Gui, 2: Add, Radio, x610 y300 w100 h20 Group vRadio3 Checked%Radio3%, Мужской
Gui, 2: Add, Radio, x720 y300 w100 h20 vRadio4 Checked%Radio4%, Женский

; --- СТАТИСТИКА ---
Gui, 2: Font, s10 Bold c7289da
Gui, 2: Add, Text, x170 y435 w200 h25, МОЯ СТАТИСТИКА
Gui, 2: Font, s8 Bold cFF4444
Gui, 2: Add, Button, x480 y432 w100 h22 gResetStats, ОБНУЛИТЬ
Gui, 2: Font, s11 Bold cFFFFFF
Gui, 2: Add, Text, x170 y465 w200 h30 vMyText, День: %DayANS%
Gui, 2: Add, Text, x320 y465 w200 h30 vMyTotalR, Неделя: %WeekANS%

; --- АВТО-КОМАНДЫ (ВХОД) ---
Gui, 2: Font, s9 Bold c7289da
Gui, 2: Add, Text, x610 y435 w275 h20, АВТО-КОМАНДЫ ПРИ ВХОДЕ
Gui, 2: Font, s9 Norm cFFFFFF
Gui, 2: Add, Text, x610 y465 w100 h20, Клавиша:
Gui, 2: Add, Hotkey, x710 y462 w175 h24 vHot11, %KEY11%
Gui, 2: Add, CheckBox, x610 y495 w80 h20 vRadio8 gSaveCheck Checked%Radio8%, /gm
Gui, 2: Add, CheckBox, x700 y495 w80 h20 vRadio9 gSaveCheck Checked%Radio9%, /esp 4
Gui, 2: Add, CheckBox, x610 y520 w90 h20 vRadio10 gSaveCheck Checked%Radio10%, /leader 5
Gui, 2: Add, CheckBox, x710 y520 w90 h20 vRadio11 gSaveCheck Checked%Radio11%, /hide

GuiControl, 2: ChooseString, ScreenRes, %SavedRes%
Gui, 2: Show, w900 h620, Region Helper
Return
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
Gui, +LastFound +ToolWindow
ID := WinExist()
Gui, Show, NoActivate, Hide x0 y0 w0 h0, Overlay
WinSet_Click_Through(ID, "On")
GuiControl,, Un-Clickable
CustomColor := "#00FF00"
Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui, Color, cRed
Gui, Font,, Intro
Gui, Font, s10
Gui, Font, q1
Gui, Font, w400
Gui, Add, Text, vMyText cWhite, XXX, YYYY
Gui, Add, Text, vMyTotalR cWhite, XXXXXX, YYYYYY
Gui, Color, 1c2126
WinSet, TransColor, AAAAAA 155
GoSub, UpdateCounter1
Gui, Show, x%qX% y%qY% w100 h63, Overlay
return

UpdateRes:
Gui, 2: Submit, NoHide ; Считывает выбранное разрешение в переменную ScreenRes
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
Reload
return

; --- СОХРАНЕНИЕ КООРДИНАТ (Gui 3) ---
SaveData1:
Gui, 3: Submit, NoHide
IniWrite, %qX%, Settings.ini, Coords, qX
IniWrite, %qY%, Settings.ini, Coords, qY
Reload
return

; --- СОХРАНЕНИЕ ДАННЫХ DISCORD (Gui 4) ---
SaveData2:
Gui, 4: Submit, NoHide
IniWrite, %qdis%, Settings.ini, Discord, qdis
IniWrite, %qtag%, Settings.ini, Discord, qtag
Reload
return

; --- СОХРАНЕНИЕ ДИСКОРДА АДМИНИСТРАЦИИ (Gui 5) ---
SaveData3:
Gui, 5: Submit, NoHide
IniWrite, %gadis%, Settings.ini, Discord, gadis
IniWrite, %gatag%, Settings.ini, Discord, gatag
Reload
return

; --- СОХРАНЕНИЕ ДОПОЛНИТЕЛЬНЫХ ДАННЫХ (Gui 6) ---
SaveData4:
Gui, 6: Submit, NoHide
IniWrite, %zgadis%, Settings.ini, Discord, zgadis
IniWrite, %zgatag%, Settings.ini, Discord, zgatag
Reload
return

ShortCommands:
Gui, 8: New, +AlwaysOnTop +ToolWindow, Справочник сокращений
Gui, 8: Color, 1A1A1A
Gui, 8: Font, s12 Bold c00FF00, Segoe UI
Gui, 8: Add, Text, x10 y10 w430 +Center, ⚡ ПОЛНЫЙ СПИСОК КОМАНД

Gui, 8: Add, ActiveX, x10 y45 w430 h420 vDoc, HTMLFile
Doc.write("
(
    <style>
        body { background-color: #1A1A1A; color: white; font-family: 'Segoe UI', sans-serif; font-size: 13px; margin: 10px; overflow-x: hidden; }
        .header { color: #00FF00; font-weight: bold; border-bottom: 1px solid #333; margin-top: 15px; margin-bottom: 5px; padding-bottom: 3px; text-transform: uppercase; font-size: 14px; }
        .cmd-row { margin-bottom: 2px; display: block; line-height: 1.4; }
        .cmd { color: #00FF00; font-family: 'Consolas', monospace; font-weight: bold; }
        .desc { color: #FFFFFF; }
    </style>
    
    <div class='header'>📍 Телепорты</div>
    <div class='cmd-row'><span class='cmd'>.мвд</span> — <span class='desc'>МВД</span></div>
    <div class='cmd-row'><span class='cmd'>.цгб</span> — <span class='desc'>ЦГБ</span></div>
    <div class='cmd-row'><span class='cmd'>.дпс</span> — <span class='desc'>ДПС</span></div>
    <div class='cmd-row'><span class='cmd'>.сми</span> — <span class='desc'>СМИ</span></div>

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
    <div class='cmd-row'><span class='cmd'>.ылшсл</span> — <span class='desc'>/skick</span></div>
    <div class='cmd-row'><span class='cmd'>.ифт / .рфквифт</span> — <span class='desc'>/ban / /hardban</span></div>
    <div class='cmd-row'><span class='cmd'>.ьгеу / .гтьгеу</span> — <span class='desc'>/mute / /unmute</span></div>
    <div class='cmd-row'><span class='cmd'>.од / .гтофшд , .фофшд</span> — <span class='desc'>/jail / /unjail</span></div>

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

Gui, 8: Font, s8 Norm cGray
Gui, 8: Add, Text, x10 y480 w100 h20 +BackgroundTrans, Сборка: %Version%
Gui, 8: Font, s10 Bold cWhite
Gui, 8: Add, Button, x140 y480 w170 h40 gCloseShort, ПОНЯТНО
Gui, 8: Show, w450 h540
return

CloseShort:
Gui, 8: Hide
return
; --- ОБНОВЛЕННАЯ ЛОГИКА СЧЕТЧИКОВ ---

UpdateCounter:
DayANS += 1
WeekANS += 1
Gosub, SaveAndRefresh
return

UpdateCounter1:
; Считываем данные и дату последней активности
IniRead, DayANS, Settings.ini, ANS, DayANS, 0
IniRead, WeekANS, Settings.ini, ANS, WeekANS, 0
IniRead, LastDate, Settings.ini, ANS, LastDate, 0
IniRead, LastWeek, Settings.ini, ANS, LastWeek, 0

; Проверка на новый день (сброс DayANS)
if (LastDate != A_DDMM) {
    DayANS := 0
    IniWrite, %A_DDMM%, Settings.ini, ANS, LastDate
}

; Проверка на новую неделю (сброс WeekANS)
if (LastWeek != A_YWeek) {
    WeekANS := 0
    IniWrite, %A_YWeek%, Settings.ini, ANS, LastWeek
}

Gosub, RefreshUI ; Просто обновляем текст в меню
return

SaveAndRefresh:
; Сохраняем текущие значения
IniWrite, %DayANS%, Settings.ini, ANS, DayANS
IniWrite, %WeekANS%, Settings.ini, ANS, WeekANS
IniWrite, %A_DDMM%, Settings.ini, ANS, LastDate
IniWrite, %A_YWeek%, Settings.ini, ANS, LastWeek

RefreshUI:
; Обновляем визуальную часть (окно №2)
; Добавил небольшое украшение текста
GuiControl, 2:, MyText, День: %DayANS%
GuiControl, 2:, MyTotalR, Неделя: %WeekANS%
return

Reports:
SendInput, {F8}
return

;GuiClose: ; Не работает :\ 
;Exitapp 
;Return 

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
; Настройки окна
Gui 3: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui 3: Color, 1A1A1A ; Темно-серый фон
Gui 3: Font, s10, Segoe UI

; Установка прозрачности (0-255). 190 позволит видеть игру сквозь фон.
WinSet, Transparent, 190

; --- ТАБЛИЦА (GroupBox создают визуальные границы) ---
Gui 3: Add, GroupBox, x10 y5 w500 h260 cWhite, [ ЧАСТЫЕ НАРУШЕНИЯ ]
Gui 3: Add, GroupBox, x520 y5 w500 h260 cWhite, [ ОТЫГРОВКИ / АДМ / ЧАТЫ ]
Gui 3: Add, GroupBox, x1040 y5 w500 h260 cWhite, [ КРИМИНАЛЬНЫЕ НАРУШЕНИЯ ]

; --- ЛЕВАЯ КОЛОНКА ---
Gui 3: Add, Text, x20 y30 w480 cYellow, DM п.4.9 ОП: Gunban 60-360ч / Dmg 30-120м / WARN / Ban 1-30д
Gui 3: Add, Text, x20 y53 w480 cWhite, DB п.4.3 ОП: Demorgan 10-120 м. / WARN / Ban 1-10 д.
Gui 3: Add, Text, x20 y76 w480 cYellow, NRP п.4.1 ОП: Demorgan 10-90 м. / WARN / Ban 3-15д
Gui 3: Add, Text, x20 y99 w480 cWhite, PG п. 4.7 ОП: Demorgan 30-90 м. / WARN / Ban 3-10 д.
Gui 3: Add, Text, x20 y122 w480 cYellow, SK 4.6 ОП: GunBan 60-360м / Dmg 30-120м / WARN / Ban 1-30д
Gui 3: Add, Text, x20 y145 w480 cWhite, NRD 4.2 ОП: Demorgan 10 - 120 м.
Gui 3: Add, Text, x20 y168 w480 cYellow, Уход от RP 4.14 ОП: Dmg 30-90 / WARN / Ban 3-10 д.
Gui 3: Add, Text, x20 y191 w480 cWhite, Громкие звуки 3.8 ОП: Mute 10 - 50 м.
Gui 3: Add, Text, x20 y214 w480 cYellow, Музыка в ЗЗ 1.5 ПИЗ: Mute 20 - 60 м.

; --- ЦЕНТРАЛЬНАЯ КОЛОНКА ---
Gui 3: Add, Text, x530 y30 w480 cYellow, Оск.отыгровки 5.2 ОП: Demorgan 10 - 30 м.
Gui 3: Add, Text, x530 y53 w480 cWhite, Обман в /do 5.1 ОП: Demorgan 10-30 м.
Gui 3: Add, Text, x530 y76 w480 cYellow, Отыгровки в свою пользу 5.1.2 ОП: Demorgan 20-60 м.
Gui 3: Add, Text, x530 y99 w480 cWhite, Помеха адм. 4.18 ОП: Kick / Dmg 10-90 м. / Ban 1-10 д.
Gui 3: Add, Text, x530 y122 w480 cYellow, Обман администрации (В разработке)
Gui 3: Add, Text, x530 y145 w480 cWhite, Оск. адм. 3.7 ОП: Mute / Ban / Hard 5-30 д.
Gui 3: Add, Text, x530 y168 w480 cYellow, Трап 2.3 / нрп ник 2.6 ОП: Dmg 720 м. (до смены)
Gui 3: Add, Text, x530 y191 w480 cWhite, Спам/флуд в чат 3.5 ОП: Mute 10 - 40 м.
Gui 3: Add, Text, x530 y214 w480 cYellow, OOC in IC 3.12 ОП: Mute / Dmg / Warn / Ban 1-5

; --- ПРАВАЯ КОЛОНКА ---
Gui 3: Add, Text, x1050 y30 w480 cYellow, 3.4 ПОиП - Остановка ТС < 2 чел/2 ТС: Dmg 10-30м
Gui 3: Add, Text, x1050 y53 w480 cWhite, 3.2 ПОиП - Меньше 2-х грабителей: Dmg 10-30 м.
Gui 3: Add, Text, x1050 y76 w480 cYellow, 2.1 ПОиП - Меньше 6-и похитителей: Dmg 20-60/WARN
Gui 3: Add, Text, x1050 y99 w480 cWhite, 3.7. ПОиП - Унижение жертвы: Mute / Dmg 10-30
Gui 3: Add, Text, x1050 y122 w480 cYellow, 3.1 ПОиП - Ограб не через функц: Dmg 30-90/Warn
Gui 3: Add, Text, x1050 y145 w480 cWhite, 1.2 ПСО - Одежда не цвет фамы: Dmg 30-50 м.
Gui 3: Add, Text, x1050 y168 w480 cYellow, 1.3.1 ПОиП - машины не в цвет: Dmg 10-30 м.
Gui 3: Add, Text, x1050 y191 w480 cWhite, 1.4 ПиЗ - Уход в ЗЗ: Demorgan 20-90 м.
Gui 3: Add, Text, x1050 y214 w480 cYellow, [ Свободная строка ]

; --- НИЖНИЙ БЛОК (ГОС / ТУЛЕВО) ---
Gui 3: Add, GroupBox, x10 y275 w1530 h130 cWhite, [ СПЕЦИАЛЬНЫЕ / ГОС / ТУЛЕВО ]
Gui 3: Add, Text, x20 y300 w500 cYellow, 3.3 ОП (Соц/Гендер): Mute 30-240 / Dmg 30-120 / Ban 3-15
Gui 3: Add, Text, x20 y325 w500 cWhite, 3.4 ОП (Оск родни): Dmg 30-120 / Ban 3-15 д.
Gui 3: Add, Text, x20 y350 w500 cYellow, 1.3 ПГО (Злоуп функц): Dmg 30-90 / Warn / Ban

Gui 3: Add, Text, x530 y300 w500 cYellow, Стрельба по пешим 4.17 ОП: GunBan / Dmg / Ban
Gui 3: Add, Text, x530 y325 w500 cWhite, Стрельба в зз: GunBan / Dmg 35-120 / WARN / Ban
Gui 3: Add, Text, x530 y350 w500 cYellow, Читы: HardBan 9999 д. / Софт голос 3.9: Mute 30-120

Gui 3: Add, Text, x1050 y300 w500 cYellow, 1.4 ПГО (Жетон): Dmg 15-30 / 1.8 Патруль личка: Dmg 15
Gui 3: Add, Text, x1050 y325 w500 cWhite, 1.16 ПГО (Оск игроков): Mute / Dmg / Warn
Gui 3: Add, Text, x1050 y350 w500 cYellow, 1.16.1 Bad cop: Dmg 30-90 / 1.7 Взятка: Dmg 40-80

; --- ПОЗИЦИОНИРОВАНИЕ В ЛЕВЫЙ НИЖНИЙ УГОЛ ---
SysGet, Mon, MonitorWorkArea
GuiWidth := 1550
GuiHeight := 415
YPos := MonBottom - GuiHeight

; x0 - прижать к левому краю, NoActivate - не сворачивать игру
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
Gui, 7: New, +AlwaysOnTop -MaximizeBox, Настройка биндов
Gui, 7: Color, 1A1A1A, 24282E
Gui, 7: Font, s11 Bold c7289da, Segoe UI
Gui, 7: Add, Text, x10 y15 w380 h25 +Center, ⚡ ИЗМЕНИТЬ БИНДЫ КЛАВИШ

; --- СИСТЕМНЫЕ ОКНА ---
Gui, 7: Font, s8 Bold c7289da
Gui, 7: Add, Text, x20 y55, [ ВЫЗОВ ИНТЕРФЕЙСОВ ]
Gui, 7: Font, s9 Norm cWhite
; Сделали колонки шире
Gui, 7: Add, Text, x20 y85 w85 h20, Телепорты:
Gui, 7: Add, Hotkey, x105 y82 w80 h24 vNewKeyTele, %KeyTele%
Gui, 7: Add, Text, x210 y85 w85 h20, Команды:
Gui, 7: Add, Hotkey, x295 y82 w80 h24 vNewKeyCmd, %KeyCmd%

Gui, 7: Add, Text, x20 y115 w85 h20, Ответы:
Gui, 7: Add, Hotkey, x105 y112 w80 h24 vNewKeyAns, %KeyAns%
Gui, 7: Add, Text, x210 y115 w85 h20, Наказания:
Gui, 7: Add, Hotkey, x295 y112 w80 h24 vNewKeyPunish, %KeyPunish%

; --- БЫСТРЫЕ ФРАЗЫ ---
Gui, 7: Font, s8 Bold c7289da
Gui, 7: Add, Text, x20 y160, [ БЫСТРЫЕ ОТВЕТЫ В ЧАТ ]

; Фраза 1
Gui, 7: Font, s9 Norm cWhite
Gui, 7: Add, Text, x20 y190 w180 h20, Приветствие + /tp:
Gui, 7: Add, Hotkey, x220 y187 w155 h24 vNewKeyGreet, %KeyGreet%
Gui, 7: Font, s8 cBDC3C7 ; Светло-серебристый (более читаемый)
Gui, 7: Add, Text, x30 y212 w350 h15, » Приветствую, иду на помощь. /tp

; Фраза 2
Gui, 7: Font, s9 Norm cWhite
Gui, 7: Add, Text, x20 y240 w180 h20, Иду на помощь:
Gui, 7: Add, Hotkey, x220 y237 w155 h24 vNewKeyGo, %KeyGo%
Gui, 7: Font, s8 cBDC3C7
Gui, 7: Add, Text, x30 y262 w350 h15, » Здравствуйте, иду.

; Фраза 3
Gui, 7: Font, s9 Norm cWhite
Gui, 7: Add, Text, x20 y290 w180 h20, Ожидайте помощь:
Gui, 7: Add, Hotkey, x220 y287 w155 h24 vNewKeyWait, %KeyWait%
Gui, 7: Font, s8 cBDC3C7
Gui, 7: Add, Text, x30 y312 w350 h15, » Сейчас помогу, ожидайте.

; Фраза 4
Gui, 7: Font, s9 Norm cWhite
Gui, 7: Add, Text, x20 y340 w180 h20, Приятной игры:
Gui, 7: Add, Hotkey, x220 y337 w155 h24 vNewKeyPlay, %KeyPlay%
Gui, 7: Font, s8 cBDC3C7
Gui, 7: Add, Text, x30 y362 w350 h15, » Приятной игры на Region.

; Кнопка
Gui, 7: Font, s10 Bold c1A1A1A
Gui, 7: Add, Button, x20 y400 w360 h40 gSaveSystemKeys, СОХРАНИТЬ И ПРИМЕНИТЬ
Gui, 7: Show, w400 h460, Настройка биндов
return

; --- ВАШ DISCORD ---
discord:
Gui, 4: +LastFound -MaximizeBox
Gui, 4: Color, 1e2124, 2f3136
Gui, 4: Font, s10 Bold c00FFFF, Segoe UI
Gui, 4: Add, Text, x10 y10 w230 h25 +Center, ВАШ ДИСКОРД
Gui, 4: Font, s8 c8E9297
Gui, 4: Add, Text, x15 y45 w210 h15, Введите ваш Discord ID:
Gui, 4: Font, s9 Norm cFFFFFF
Gui, 4: Add, Edit, x15 y65 w210 h25 vqdis, %qdis%
Gui, 4: Add, Button, x15 y105 w210 h35 gSaveData2, СОХРАНИТЬ
Gui, 4: Show, w240 h155, My Discord
return

; --- ДАННЫЕ ГА ---
discordga:
Gui, 5: +LastFound -MaximizeBox
Gui, 5: Color, 1e2124, 2f3136
Gui, 5: Font, s10 Bold c7289da, Segoe UI
Gui, 5: Add, Text, x10 y10 w230 h25 +Center, ДАННЫЕ ГА
Gui, 5: Font, s8 c8E9297
Gui, 5: Add, Text, x15 y45 w210 h15, Введите ID Главного Адм.:
Gui, 5: Font, s9 Norm cFFFFFF
Gui, 5: Add, Edit, x15 y65 w210 h25 vgadis, %gadis%
Gui, 5: Add, Button, x15 y105 w210 h35 gSaveData3, СОХРАНИТЬ
Gui, 5: Show, w240 h155, Admin GA
return

; --- ДАННЫЕ зГА ---
discordzga:
Gui, 6: +LastFound -MaximizeBox
Gui, 6: Color, 1e2124, 2f3136
Gui, 6: Font, s10 Bold c7289da, Segoe UI
Gui, 6: Add, Text, x10 y10 w230 h25 +Center, ДАННЫЕ зГА
Gui, 6: Font, s8 c8E9297
Gui, 6: Add, Text, x15 y45 w210 h15, Введите ID Зам. Гл. Адм.:
Gui, 6: Font, s9 Norm cFFFFFF
Gui, 6: Add, Edit, x15 y65 w210 h25 vzgadis, %zgadis%
Gui, 6: Add, Button, x15 y105 w210 h35 gSaveData4, СОХРАНИТЬ
Gui, 6: Show, w240 h155, Admin zGA
return
esp:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /esp{Enter}
return
; !1:: ; 4 katana
; BlockInput, SendAndMouse
; SendInput, {sc14}
; Sleep 50
; SendInput, /esp 4{Enter}
; return
delv:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /delveh{Space}
return
killplayer:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /sethealth 0{Space}
return
PunishmentHandler:
Process, Exist, PlayGTAV.exe
if(Errorlevel)
{
WinActivate ahk_exe PlayGTAV.exe
Loop, read, %A_WorkingDir%\Punishment.txt
{
Loop, parse, A_LoopReadLine, %A_Tab%
{
ru := DllCall("LoadKeyboardLayout", "Str", "00000419", "Int", 1)
en := DllCall("LoadKeyboardLayout", "Str", "00000409", "Int", 1)
w := DllCall("GetForegroundWindow")
pid := DllCall("GetWindowThreadProcessId", "UInt", w, "Ptr", 0)
l := DllCall("GetKeyboardLayout", "UInt", pid)
if (l != ru)
{
PostMessage 0x50, 0, %ru%,, A
}
Sleep, 850
Send, {T}
Send, %A_LoopField%
Send, {Enter}
}
}
MsgBox, 64, Выдача наказаний, Наказания выданы.
}
else
{
MsgBox, 16, Выдача наказаний, Запустите игру!
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

rep:
counter++
GoSub, UpdateCounter ; Твоя логика статистики
return
; СЧЕТЧИК РЕПОРТОВ
Enter::
labelgo:
SendInput, {Enter}
Sleep 250
if (Radio1==1) {
MouseGetPos, 1410, 187
PixelGetColor, color, 1410, 187, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio2==1) {
MouseGetPos, 1901, 247
PixelGetColor, color, 1901, 247, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio7==1) {
MouseGetPos, 1211, 152
PixelGetColor, color, 1211, 152, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio5==1) {
MouseGetPos, 961, 159
PixelGetColor, color, 961, 159, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio6==1) {
MouseGetPos, 812, 233
PixelGetColor, color, 812, 233, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio13==1) {
MouseGetPos, 878, 136
PixelGetColor, color, 878, 136, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio14==1) {
MouseGetPos, 888, 165
PixelGetColor, color, 888, 165, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio19==1) {
MouseGetPos, 1263, 193
PixelGetColor, color, 1263, 193, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio20==1) {
MouseGetPos, 901, 182
PixelGetColor, color, 901, 182, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio16==1) {
MouseGetPos, 1912, 250
PixelGetColor, color, 1912, 250, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio22==1) { ; 1366x768 | 5:3
MouseGetPos, 836, 136
PixelGetColor, color, 836, 136, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
return

NumpadEnter::
labelgo2:
SendInput, {NumpadEnter}
Sleep 250
if (Radio1==1) {
MouseGetPos, 1410, 187
PixelGetColor, color, 1410, 187, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio2==1) {
MouseGetPos, 1901, 247
PixelGetColor, color, 1901, 247, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio7==1) {
MouseGetPos, 1211, 152
PixelGetColor, color, 1211, 152, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio5==1) {
MouseGetPos, 961, 159
PixelGetColor, color, 961, 159, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio6==1) {
MouseGetPos, 812, 233
PixelGetColor, color, 812, 233, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio13==1) {
MouseGetPos, 878, 136
PixelGetColor, color, 878, 136, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio14==1) {
MouseGetPos, 888, 165
PixelGetColor, color, 888, 165, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio19==1) {
MouseGetPos, 1263, 193
PixelGetColor, color, 1263, 193, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio20==1) {
MouseGetPos, 901, 182
PixelGetColor, color, 901, 182, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio16==1) {
MouseGetPos, 1912, 250
PixelGetColor, color, 1912, 250, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio22==1) { ; 1366x768 | 5:3
MouseGetPos, 836, 136
PixelGetColor, color, 836, 136, alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
return

;Телепорты
:?:.мвд::/tpc 560.706 5962.073 11.719
:?:.цгб::/tpc -581.273 7196.846 6.796
:?:.дпс::/tpc -1236.235 5823.474 11.839
:?:.сми::/tpc -246.499 7000.819 4.248

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
:?:.ку::Приветствую.
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

:?*:.тп::
Gui, 2: Submit, NoHide
targetX := 0, targetY := 0, lang := 0x4090409

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
    MsgBox, 16, Ошибка, Выберите разрешение в интерфейсе!
    return
}

; Работаем в окне репорта
SendMessage, 0x50,, %lang%,, A
SendInput, {Text}Приветствую. Уже лечу к вам.
SendInput, {Enter}
Sleep 150
SendInput, {Esc} ; Закрываем окно репорта

; Переходим к /tp в обычном чате
Sleep 400 
SendMessage, 0x50,, 0x4090409,, A 
SendInput, {sc14} ; Открываем чат (T)
Sleep 150 
SendInput, {Text}/tp
SendInput, {Space}
Return

; Автоответ на репорт
fastans:
Gui, 2: Submit, NoHide
targetX := 0, targetY := 0

; ВАЖНО: Текст в кавычках должен быть В ТОЧНОСТИ как в твоем DropDownList
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

; Если после всех проверок координаты остались 0 — значит текст в списке не совпал с кодом
if (targetX = 0) {
    MsgBox, 16, Ошибка, К сожалению, твой монитор (%ScreenRes%) не подходит под данную функцию.
    return
}

; --- ДАЛЬШЕ ТВОЯ ЛОГИКА ---
PixelGetColor, Var1, %targetX%, %targetY%, Alt
isSpecial := (Var1 = 0x005A1CE8 || Var1 = 0x005912FB || Var1 = 0x008313FF || Var1 = 0x006619E9)

SendMessage, 0x50,, 0x4190419,, A 
SendInput, {Text}Приветствую. Уже лечу к Вам.{Enter}
Sleep 100
SendInput, {Esc}
Sleep 350
SendMessage, 0x50,, 0x4090409,, A 
SendInput, {sc14}
Sleep 100
SendInput, {Text}/tp
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
Sleep, 300 ; Ждем, пока чат закроется после отправки
SendInput, {Esc}
Sleep, 200
SendInput, {sc14}
Sleep, 200
SendInput, /tp{Space}
return

GoLabel:
SendInput, {F6}Здравствуйте, иду.{Enter}
return

WaitLabel:
SendInput, {F6}Сейчас помогу, ожидайте.{Enter}
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
    x1 := 960, y1 := 213, x2 := 1387, y2 := 1041, x3 := 1082, y3 := 1032
}
else if (ScreenRes = "2554x1411") {
    x1 := 960, y1 := 213, x2 := 1387, y2 := 1041, x3 := 1082, y3 := 1032
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
:?:.чё::Здравствуйте, уточните свой вопрос подробнее в репорт. Количество символов в репорт не ограничено, вы можете полностью расписать Вашу проблему/вопрос.
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
:?:.жб::Администрация не может выдавать наказания и выносить какие-либо вердикты не видя всей ситуации. Пожалуйста, если у Вас есть видеофиксация данного нарушения - оформите жалобу на форуме, спасибо большое за понимание.
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

Помощь:
; Полная очистка окна перед каждым открытием
Gui, About: Destroy 

; Настройки стиля окна
Gui, About: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, About: Color, 1A1A1A
Gui, About: Font, s12 Bold cGreen, Segoe UI

; --- ЗАГОЛОВОК ---
Gui, About: Add, Text, x15 y10, ℹ️ ИНФОРМАЦИЯ О СОФТЕ

; Разделитель (Зеленая линия) — добавлена запятая для стабильности
Gui, About: Add, Progress, x15 y35 w420 h1 BackgroundGreen cGreen, 100

; --- ОСНОВНОЙ БЛОК ---
Gui, About: Font, s10 Norm cWhite
Gui, About: Add, Text, x20 y50 w410, Софт создан для облегчения работы администрации Region.
Gui, About: Add, Text, x20 y75 w410 cYellow, Автоматический учет репортов за день и неделю.

; --- БЛОК НАСТРОЕК ---
Gui, About: Font, s10 Bold cGreen
Gui, About: Add, Text, x20 y105, ⚙️ НАСТРОЙКА:
Gui, About: Font, s10 Norm cWhite
Gui, About: Add, Text, x20 y125 w410, Выберите разрешение, Discord, сервер и пол в меню.
Gui, About: Add, Text, x20 y145 cYellow, Обязательно нажмите "Сохранить" для применения!

; --- БЛОК УПРАВЛЕНИЯ ---
Gui, About: Font, s10 Bold cGreen
Gui, About: Add, Text, x20 y175, ⌨️ УПРАВЛЕНИЕ:
Gui, About: Font, s10 Norm cWhite
Gui, About: Add, Text, x20 y195, Ctrl + F9 — Перезапуск программы
Gui, About: Add, Text, x20 y215, Ctrl + F10 — Закрыть программу

; Нижний разделитель
Gui, About: Add, Progress, x15 y245 w420 h1 BackgroundGray cGray, 100

; --- ФУТЕР ---
Gui, About: Font, s9 Italic cGray
Gui, About: Add, Text, x20 y255, Поддержка / Идеи: Python (1ssabtw)

; --- КНОПКА ЗАКРЫТИЯ ---
Gui, About: Font, s10 Bold cWhite
Gui, About: Add, Button, x135 y290 w180 h35 gCloseAbout, Понятно

; Финальный показ окна
Gui, About: Show, w450 h340, О программе
return

; Логика кнопки закрытия
CloseAbout:
Gui, About: Destroy
return
Телепорты:
; Полная очистка окна перед созданием
Gui, 4: Destroy 

; Настройки стиля окна телепортов
Gui, 4: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 4: Color, 1A1A1A ; Темный фон
Gui, 4: Font, s11 Bold cGreen, Segoe UI
Gui, 4: Add, Text, x15 y10, 📍 БЫСТРЫЙ ТЕЛЕПОРТ

; Тонкая зеленая линия-разделитель
Gui, 4: Add, Progress, x15 y35 w220 h1 BackgroundGreen cGreen, 100

Gui, 4: Font, s10 Bold cWhite
; Кнопки телепортации
Gui, 4: Add, Button, x20 y50 w210 h35 gGoMWD, .мвд [ МВД ]
Gui, 4: Add, Button, x20 y90 w210 h35 gGoCGB, .цгб [ ЦГБ ]
Gui, 4: Add, Button, x20 y130 w210 h35 gGoDPS, .дпс [ ГИБДД ]
Gui, 4: Add, Button, x20 y170 w210 h35 gGoSMI, .сми [ СМИ ]

; Кнопка закрытия
Gui, 4: Font, s9 Norm cGray
Gui, 4: Add, Button, x20 y215 w210 h30 gCloseTP, Понятно

; Показываем окно по центру
Gui, 4: Show, w250 h260, TeleportMenu
return

; --- ЛОГИКА КНОПОК ---

GoMWD:
    Gosub, PrepareGame
    SendInput, {t}/tpc 560.706 5962.073 11.719{Enter}
return

GoCGB:
    Gosub, PrepareGame
    SendInput, {t}/tpc -581.273 7196.846 6.796{Enter}
return

GoDPS:
    Gosub, PrepareGame
    SendInput, {t}/tpc -1236.235 5823.474 11.839{Enter}
return

GoSMI:
    Gosub, PrepareGame
    SendInput, {t}/tpc -246.499 7000.819 4.248{Enter}
return

; Скрываем меню и возвращаем фокус игре
PrepareGame:
    Gui, 4: Hide
    Sleep 150 ; Задержка, чтобы игра успела принять фокус
return

CloseTP:
    Gui, 4: Destroy
return
Команды:
Gui Help: New, +AlwaysOnTop +ToolWindow, Список команд хелпера
Gui Help: Color, 1A1A1A
Gui Help: Font, s12 Bold cGreen, Segoe UI
Gui Help: Add, Text, x10 y10, ⚡ ГОРЯЧИЕ КЛАВИШИ (Alt + ...)
Gui Help: Font, s10 Norm cWhite

Gui Help: Add, Text, x20 y40, Alt + Q — Приветствие + Авто-репорт + /tp
Gui Help: Add, Text, x20 y65, Alt + A — "Здравствуйте, иду."
Gui Help: Add, Text, x20 y90, Alt + D — "Сейчас помогу, ожидайте."
Gui Help: Add, Text, x20 y115, Alt + S — "Приятной игры на Region."

Gui Help: Font, s12 Bold cGreen
Gui Help: Add, Text, x10 y150, 🛠 КОМАНДЫ (в чат)
Gui Help: Font, s10 Norm cWhite

; Левая колонка команд
Gui Help: Add, Text, x20 y180, /sp  — Слежка за ID
Gui Help: Add, Text, x20 y205, /so  — Выйти из слежки
Gui Help: Add, Text, x20 y230, /gc  — GetCar к себе
Gui Help: Add, Text, x20 y255, /ad  — Админы в сети
Gui Help: Add, Text, x20 y280, /kf  — Уволить из фракции

; Правая колонка команд
Gui Help: Add, Text, x280 y180, .рес — Воскресить (/rescue)
Gui Help: Add, Text, x280 y205, .ез  — Телепорт (/tp)
Gui Help: Add, Text, x280 y230, .ку  — Приветствие в чат
Gui Help: Add, Text, x280 y255, /kill — Убить (/hp ID 0)
Gui Help: Add, Text, x280 y280, /sm  — Маты (Chief only)

Gui Help: Font, s12 Bold cGreen
Gui Help: Add, Text, x10 y320, 📞 СВЯЗЬ И ИНФО
Gui Help: Font, s10 Norm cWhite
Gui Help: Add, Text, x20 y350, .дис / .га / .зга — Сбросить Discord (Ваш / ГА / зГА)
Gui Help: Add, Text, x20 y375, .афк — Уйти в AFK | .пиздец — Сигнал о завале репортов

Gui Help: Font, s9 Italic cGray
Gui Help: Add, Text, x10 y410, * Транслит (например .ез) автоматически конвертируется в /команду.
Gui Help: Add, Text, x10 y430, * Быстрый репорт: 1920x1080. Для других разрешений — пиши Python (1ssabtw).

Gui Help: Add, Button, x200 y460 w150 h30 gCloseHelp, Понятно
Gui Help: Show, w550 h500
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
Gui, 5: Color, 1A1A1A
Gui, 5: Font, s11 Bold cGreen, Segoe UI
Gui, 5: Add, Text, x15 y10, 📝 БЫСТРЫЕ ОТВЕТЫ — СТРАНИЦА 1 [1-16]
Gui, 5: Add, Progress, x15 y35 w820 h1 BackgroundGreen cGreen, 100
Gui, 5: Font, s9 Bold cWhite
Gui, 5: Add, Button, x20 y50 w390 h30 gAnsFinka, 1. .финка (НКВД / Маркетплейс)
Gui, 5: Add, Button, x20 y85 w390 h30 gAnsCho, 2. .чё (Уточните вопрос)
Gui, 5: Add, Button, x20 y120 w390 h30 gAnsDonat, 3. .донат (Проблемы с оплатой)
Gui, 5: Add, Button, x20 y155 w390 h30 gAnsPromo, 4. .промо (Список всех кодов)
Gui, 5: Add, Button, x20 y190 w390 h30 gAnsAmp, 5. .амп (Продажа авто / Планшет)
Gui, 5: Add, Button, x20 y225 w390 h30 gAnsSchet, 6. .счет (Открытие счета в банке)
Gui, 5: Add, Button, x20 y260 w390 h30 gAnsSim, 7. .симка (Салон связи)
Gui, 5: Add, Button, x20 y295 w390 h30 gAnsDok, 8. .док (Как показать документы)
Gui, 5: Add, Button, x430 y50 w390 h30 gAnsKv, 9. .кв (Покупка жилья)
Gui, 5: Add, Button, x430 y85 w390 h30 gAnsNomera, 10. .номера (ГИБДД / ДПС)
Gui, 5: Add, Button, x430 y120 w390 h30 gAnsGps, 11. .гпс (Навигатор в телефоне)
Gui, 5: Add, Button, x430 y155 w390 h30 gAnsSid, 12. .сид (Запрос Static ID)
Gui, 5: Add, Button, x430 y190 w390 h30 gAnsPuzo, 13. .свободный слот (Инфо)
Gui, 5: Add, Button, x430 y225 w390 h30 gAnsRab, 14. .раб (Список работ)
Gui, 5: Add, Button, x430 y260 w390 h30 gAnsUval, 15. .увал (Лидер / Зам / ДС)
Gui, 5: Add, Button, x430 y295 w390 h30 gAnsGun, 16. .ганлиц (Лицензия в МВД)
Gui, 5: Font, s10 Bold cYellow
Gui, 5: Add, Button, x670 y350 w150 h35 gОтветы2, Далее >>
Gui, 5: Font, s10 Bold cGray
Gui, 5: Add, Button, x335 y350 w180 h35 gCloseAns, ЗАКРЫТЬ
Gui, 5: Show, w845 h400, БыстрыеОтветы1
return

; ==============================================================================
; ГУИ СТРАНИЦА 2 [17-36]
; ==============================================================================
Ответы2:
Gui, 6: Destroy
Gui, 6: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 6: Color, 1A1A1A
Gui, 6: Font, s11 Bold cGreen, Segoe UI
Gui, 6: Add, Text, x15 y10, 📝 БЫСТРЫЕ ОТВЕТЫ — СТРАНИЦА 2 [17-36]
Gui, 6: Add, Progress, x15 y35 w820 h1 BackgroundGreen cGreen, 100
Gui, 6: Font, s9 Bold cWhite
Gui, 6: Add, Button, x20 y50 w390 h28 gAnsBag, 17. .баг (Уже передано)
Gui, 6: Add, Button, x20 y80 w390 h28 gAnsMed, 18. .мед (Медкарта в ЦГБ)
Gui, 6: Add, Button, x20 y110 w390 h28 gAnsRel, 19. .рел (Проблемы с коннектом)
Gui, 6: Add, Button, x20 y140 w390 h28 gAnsRp, 20. .рп (Это РП процесс)
Gui, 6: Add, Button, x20 y170 w390 h28 gAnsUrp, 21. .урп (Узнайте IC путем)
Gui, 6: Add, Button, x20 y200 w390 h28 gAnsVoice, 22. .войс (Микрофон / F8)
Gui, 6: Add, Button, x20 y230 w390 h28 gAnsTech, 23. .тех (Тех-раздел ДС)
Gui, 6: Add, Button, x20 y260 w390 h28 gAnsFunk, 24. .функ (Недоступно)
Gui, 6: Add, Button, x20 y290 w390 h28 gAnsIzv, 25. .изв (Извинения)
Gui, 6: Add, Button, x20 y320 w390 h28 gAnsExp, 26. .ехп (Получение опыта)
Gui, 6: Add, Button, x430 y50 w390 h28 gAnsAuto, 27. .авто (Эвакуация / P)
Gui, 6: Add, Button, x430 y80 w390 h28 gAnsKanis, 28. .канистра (Заправка / G)
Gui, 6: Add, Button, x430 y110 w390 h28 gAnsPodnim, 29. .подним (Не лечим/поднимаем)
Gui, 6: Add, Button, x430 y140 w390 h28 gAnsJb, 30. .жб (Жалоба на форум)
Gui, 6: Add, Button, x430 y170 w390 h28 gAnsAdj, 31. .адж (К админу в ЛС ДС)
Gui, 6: Add, Button, x430 y200 w390 h28 gAnsAdz, 32. .адз (Админ занят)
Gui, 6: Add, Button, x430 y230 w390 h28 gAnsAds, 33. .адс (Админ оффлайн)
Gui, 6: Add, Button, x430 y260 w390 h28 gAnsWeather, 34. .погода (Автоматическая)
Gui, 6: Add, Button, x430 y290 w390 h28 gAnsNep, 35. .неп (Опишите подробнее)
Gui, 6: Add, Button, x430 y320 w390 h28 gAnsHp, 36. .хп (HP не выдаем)
Gui, 6: Font, s10 Bold cYellow
Gui, 6: Add, Button, x20 y390 w150 h35 gОтветы, << Назад
Gui, 6: Add, Button, x670 y390 w150 h35 gОтветы3, Далее >>
Gui, 6: Font, s10 Bold cGray
Gui, 6: Add, Button, x335 y390 w180 h35 gCloseAns, ЗАКРЫТЬ
Gui, 6: Show, w845 h440, БыстрыеОтветы2
return

; ==============================================================================
; ГУИ СТРАНИЦА 3 [37-56]
; ==============================================================================
Ответы3:
Gui, 7: Destroy
Gui, 7: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 7: Color, 1A1A1A
Gui, 7: Font, s11 Bold cGreen, Segoe UI
Gui, 7: Add, Text, x15 y10, 📝 БЫСТРЫЕ ОТВЕТЫ — СТРАНИЦА 3 [37-56]
Gui, 7: Add, Progress, x15 y35 w820 h1 BackgroundGreen cGreen, 100
Gui, 7: Font, s9 Bold cWhite
Gui, 7: Add, Button, x20 y50 w390 h28 gAnsNov, 37. .нов (Новости сервера)
Gui, 7: Add, Button, x20 y80 w390 h28 gAnsNik, 38. .ник (Смена через адм)
Gui, 7: Add, Button, x20 y110 w390 h28 gAnsCrash, 39. .крашрп (Если вылетел)
Gui, 7: Add, Button, x20 y140 w390 h28 gAnsIgrab, 40. .иограб (Правила ограбления)
Gui, 7: Add, Button, x20 y170 w390 h28 gAnsCredit, 41. .кредит (Договоры на риск)
Gui, 7: Add, Button, x20 y200 w390 h28 gAnsRem, 42. .рем (Починка в Тюнинге)
Gui, 7: Add, Button, x20 y230 w390 h28 gAnsSdelka, 43. .сделка (Не следим)
Gui, 7: Add, Button, x20 y260 w390 h28 gAnsImya, 44. .имя (Смена Non-RP ника)
Gui, 7: Add, Button, x20 y290 w390 h28 gAnsAktual, 45. .актуал (Если актуально)
Gui, 7: Add, Button, x20 y320 w390 h28 gAnsLechu, 46. .лечу (Уже лечу)
Gui, 7: Add, Button, x430 y50 w390 h28 gAnsPom, 47. .пом (Сейчас помогу)
Gui, 7: Add, Button, x430 y80 w390 h28 gAnsGosdom, 48. .госдом (Продажа дома)
Gui, 7: Add, Button, x430 y110 w390 h28 gAnsRep, 49. .реп (Уточните вопрос)
Gui, 7: Add, Button, x430 y140 w390 h28 gAnsNeuvid, 50. .неувид (Не видел)
Gui, 7: Add, Button, x430 y170 w390 h28 gAnsDa, 51. .да (Да)
Gui, 7: Add, Button, x430 y200 w390 h28 gAnsNet, 52. .нет (Нет)
Gui, 7: Add, Button, x430 y230 w390 h28 gAnsNetp, 53. .нетп (Не телепортируем)
Gui, 7: Add, Button, x430 y260 w390 h28 gAnsTolk, 54. .толкать (Как толкать авто)
Gui, 7: Add, Button, x430 y290 w390 h28 gAnsAut, 55. .аут (Google Authenticator)
Gui, 7: Add, Button, x430 y320 w390 h28 gAnsP, 56. .п (Приятной игры)
Gui, 7: Font, s10 Bold cYellow
Gui, 7: Add, Button, x20 y390 w150 h35 gОтветы2, << Назад
Gui, 7: Font, s10 Bold cGray
Gui, 7: Add, Button, x335 y390 w180 h35 gCloseAns, ЗАКРЫТЬ
Gui, 7: Show, w845 h440, БыстрыеОтветы3
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
; --- ЗАКРЫТИЕ ВСЕХ ОКОН ---
CloseAns:
    Gui, 5: Destroy
    Gui, 6: Destroy
    Gui, 7: Destroy
return

Наказания:
Gui, 8: Destroy
Gui, 8: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 8: Color, 1A1A1A
Gui, 8: Font, s11 Bold cGreen, Segoe UI
Gui, 8: Add, Text, x15 y10, ⚖️ ПАНЕЛЬ НАКАЗАНИЙ (Курсор встанет после команды для ввода ID)

; Разделитель
Gui, 8: Add, Progress, x15 y35 w820 h1 BackgroundGreen cGreen, 100

Gui, 8: Font, s9 Bold cWhite
; --- БЛОК 1: БАНЫ И ХАРДБАНЫ ---
Gui, 8: Add, GroupBox, x15 y50 w260 h160 cRed, [ БАНЫ ]
Gui, 8: Add, Button, x25 y75 w240 h25 gAnsHardO, .хардо (Обход 9999)
Gui, 8: Add, Button, x25 y105 w240 h25 gAnsHard7, .хард (Читы 7777)
Gui, 8: Add, Button, x25 y135 w240 h25 gAnsHard9, .хард9 (Читы 9999)
Gui, 8: Add, Button, x25 y170 w240 h25 gAnsOsab, .осаб (Оск. адм 5д)

; --- БЛОК 2: ТЮРЬМА (JAIL) ---
Gui, 8: Add, GroupBox, x285 y50 w280 h310 cYellow, [ JAIL / ТЮРЬМА ]
Gui, 8: Add, Button, x295 y75 w130 h25 gAnsNrd10, .нрд 10
Gui, 8: Add, Button, x425 y75 w130 h25 gAnsNrd30, .нрд 30
Gui, 8: Add, Button, x295 y105 w130 h25 gAnsNrp15, .нрп 15
Gui, 8: Add, Button, x425 y105 w130 h25 gAnsNrp45, .нрп 45
Gui, 8: Add, Button, x295 y135 w130 h25 gAnsDb20, .дб 20
Gui, 8: Add, Button, x425 y135 w130 h25 gAnsDb50, .дб 50
Gui, 8: Add, Button, x295 y165 w130 h25 gAnsDm30, .дм 30
Gui, 8: Add, Button, x425 y165 w130 h25 gAnsDmg60, .дмг 60
Gui, 8: Add, Button, x295 y195 w130 h25 gAnsPg30, .пг 30
Gui, 8: Add, Button, x425 y195 w130 h25 gAnsPg90, .пг 90
Gui, 8: Add, Button, x295 y230 w260 h25 gAnsSex, .секс (4.11 ОП)
Gui, 8: Add, Button, x295 y265 w260 h25 gAnsNick, .смник (Смена ника)

; --- БЛОК 3: МУТЫ И ПРОЧЕЕ ---
Gui, 8: Add, GroupBox, x575 y50 w260 h160 cAqua, [ МУТЫ ]
Gui, 8: Add, Button, x585 y75 w240 h25 gAnsMuz20, .муз 20 (ПиЗ)
Gui, 8: Add, Button, x585 y105 w240 h25 gAnsMuz40, .муз 40 (ПиЗ)
Gui, 8: Add, Button, x585 y135 w240 h25 gAnsOsam, .осам (Оск. адм 60м)

; Кнопка закрытия
Gui, 8: Font, s10 Bold cGray
Gui, 8: Add, Button, x335 y375 w180 h35 gClosePun, ЗАКРЫТЬ

Gui, 8: Show, w850 h430, ПанельНаказаний
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
ResetStats:
MsgBox, 36, Подтверждение, Вы действительно хотите обнулить всю статистику (День и Неделя)?
IfMsgBox Yes
{
    DayANS := 0
    WeekANS := 0
    
    ; Сохраняем нули в файл
    IniWrite, 0, Settings.ini, ANS, DayANS
    IniWrite, 0, Settings.ini, ANS, WeekANS
    
    ; Обновляем текст в окне мгновенно
    GuiControl, 2:, MyText, День: 0
    GuiControl, 2:, MyTotalR, Неделя: 0
    
    TrayTip, Статистика, Данные успешно обнулены, 2
}
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

; Метка для открытия меню по кнопке
OpenMainMenuLabel:
Gui, 2: Show
return

ClosePun:
    Gui, 8: Destroy
return

; --- БЛОК АВТООБНОВЛЕНИЯ ---
CheckForUpdates:
    whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    try {
        whr.Open("GET", UpdateURL . "?nocache=" . A_TickCount, true)
        whr.Send()
        whr.WaitForResponse()
        if (whr.Status != 200)
            return
        NewVersion := Trim(StrSplit(whr.ResponseText, "`n", "`r").1)
    } catch {
        return
    }

    if (NewVersion > CurrentVersion) {
        MsgBox, 4, Обновление, Доступна версия: %NewVersion%`nВаша версия: %CurrentVersion%`n`nОбновиться?
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
    }
return

^F9::reload
^F10::Exitapp