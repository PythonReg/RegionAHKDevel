; --- НАСТРОЙКИ ОКНА ---
Gui, 2: Destroy
Gui, 2: +LastFound -MaximizeBox +Caption
Gui, 2: Color, 1e2124, 2f3136 ; Темный фон Discord стиля
Gui, 2: Font, s9 cFFFFFF, Segoe UI

; --- ШАПКА ---
Gui, 2: Font, s12 Bold cFFFFFF
Gui, 2: Add, Text, x0 y0 w900 h45 +Center +0x200 Background23272a, REGION HELPER
Gui, 2: Font, s9 Norm cWhite 
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
Gui, 2: Add, Button, x15 y260 w130 h30 gСокращения, Сокращения
Gui, 2: Add, Button, x15 y295 w130 h30 gChangelog, Changelog 

; --- РАЗДЕЛ ФАЙЛЫ ---
Gui, 2: Font, s9 Bold c7289da
Gui, 2: Add, Text, x20 y335 w120 h20, ФАЙЛЫ 
Gui, 2: Font, s9 Norm cFFFFFF
Gui, 2: Add, Button, x15 y355 w130 h45 gOpenPunishmentFile, Редактировать`nнаказания

Gui, 2: Add, Button, x15 y510 w130 h40 gSaveData, СОХРАНИТЬ
Gui, 2: Add, Button, x15 y560 w130 h40 gOpenKeySettings, УПР. БИНДАМИ

; --- ЦЕНТРАЛЬНЫЙ БЛОК (ГОРЯЧИЕ КЛАВИШИ) ---
Gui, 2: Font, s10 Bold c7289da
Gui, 2: Add, Text, x170 y60 w410 h25, ГОРЯЧИЕ КЛАВИШИ
Gui, 2: Add, Progress, x170 y82 w410 h1 Background333333 c333333, 100
Gui, 2: Font, s9 Norm cFFFFFF

y_p := 95
list1 := [["Удалить транспорт", 2], ["GM", 3], ["ТП к игроку", 4], ["Быстрый репорт", 5], ["Быстрый ответ", 6], ["ТП на метку", 8], ["ТП авто к себе", 9], ["Добавить +1 репорт", 10]]
for i, item in list1 {
    vIdx := item[2], vName := "Hot" . vIdx
    Gui, 2: Add, Hotkey, x170 y%y_p% w50 h24 v%vName%, % KEY%vIdx%
    Gui, 2: Add, Text, x225 y%y_p% w140 h24 +0x200, % item[1]
    y_p += 31
}

y_p := 95
list2 := [["Убить игрока", 19], ["Воскресить игрока", 12], ["ТП к себе", 15], ["Памятка", 14], ["Вкл/Выкл ESP", 18], ["/veh rs520", 20]]
for i, item in list2 {
    vIdx := item[2], vName := "Hot" . vIdx
    Gui, 2: Add, Hotkey, x380 y%y_p% w50 h24 v%vName%, % KEY%vIdx%
    Gui, 2: Add, Text, x435 y%y_p% w140 h24 +0x200, % item[1]
    y_p += 31
}

; --- ПРАВАЯ ПАНЕЛЬ ---
Gui, 2: Font, s10 Bold c7289da
Gui, 2: Add, Text, x610 y60 w275 h25, ПЕРСОНАЛИЗАЦИЯ
Gui, 2: Add, Progress, x610 y82 w275 h1 Background333333 c333333, 100
Gui, 2: Font, s9 Norm cFFFFFF
Gui, 2: Add, Button, x610 y95 w275 h30 gdiscord, Установить Discord
Gui, 2: Add, Button, x610 y130 w135 h30 gdiscordga, ДС ГА
Gui, 2: Add, Button, x750 y130 w135 h30 gdiscordzga, ДС зГА

Gui, 2: Font, s9 Bold c7289da
Gui, 2: Add, Text, x610 y175 w275 h20, РАЗРЕШЕНИЕ ЭКРАНА
Gui, 2: Font, s9 Norm cFFFFFF
Gui, 2: Add, DropDownList, x610 y195 w275 vScreenRes gUpdateRes, 2560x1440|2554x1411|1920x1080|1920x1080 (5:4)|1680x1050|1600x900|1440x900|1366x768|1366x768 (5:3)|1280x1024|1280x960
IniRead, SavedRes, Settings.ini, Settings, SelectedRes, 1920x1080
ScreenRes := SavedRes
GuiControl, 2: ChooseString, ScreenRes, %ScreenRes%

Gui, 2: Font, s10 Bold c7289da
Gui, 2: Add, Text, x610 y245 w275 h20, ВАШ ПОЛ
Gui, 2: Font, s9 Norm cFFFFFF
Gui, 2: Add, Radio, x615 y270 w110 h20 Group vRadio3 Checked%Radio3%, Мужской
Gui, 2: Add, Radio, x735 y270 w110 h20 vRadio4 Checked%Radio4%, Женский

; --- НИЖНИЙ БЛОК: СТАТИСТИКА РЕПОРТОВ ---
Gui, 2: Font, s11 Bold c7289da
Gui, 2: Add, Text, x170 y375 w410 h25 +Center, 📊 СТАТИСТИКА РЕПОРТОВ
Gui, 2: Add, Progress, x170 y398 w410 h1 Background333333 c333333, 100 

; --- 1 РЯД: ЦИФРЫ (Ограничили высоту h35) ---
Gui, 2: Font, s28 Bold c00FFFF
Gui, 2: Add, Text, x170 y405 w205 h40 +Center vDayText, %DayANS%
Gui, 2: Font, s28 Bold cFFFFFF
Gui, 2: Add, Text, x376 y405 w204 h40 +Center vWeekText, %WeekANS%

; Разделитель
Gui, 2: Add, Progress, x375 y412 w1 h45 Background333333 c333333, 100

; --- 2 РЯД: ПОДПИСИ (Спустили ниже на y455) ---
Gui, 2: Font, s9 Bold c7289da
Gui, 2: Add, Text, x170 y455 w205 +Center, ДЕНЬ
Gui, 2: Add, Text, x376 y455 w204 +Center, НЕДЕЛЯ

; --- 3 РЯД: КНОПКИ (Спустили ниже на y485) ---
Gui, 2: Font, s14 Bold
Gui, 2: Add, Button, x215 y485 w50 h40 gAddRep, +
Gui, 2: Add, Button, x280 y485 w50 h40 gSubRep, -
Gui, 2: Font, s9 Bold c1a1a1a
Gui, 2: Add, Button, x400 y485 w160 h40 gResetStats, СБРОС ДНЯ

; --- 4 РЯД: СИСТЕМНЫЕ ---
Gui, 2: Font, s9 Norm cFFFFFF
Gui, 2: Add, CheckBox, x240 y540 w90 h26 vShowOverlay gToggleOverlay Checked%ShowOverlay%, Оверлей
Gui, 2: Add, Button, x395 y538 w175 h28 gOpenOvSettings, Настроить позицию

; --- НИЖНИЙ БЛОК: АВТО-ВХОД (Синхронизирован по высоте) ---
Gui, 2: Font, s10 Bold c7289da
Gui, 2: Add, Text, x610 y375 w275 h25, ⚙️ АВТО-ВХОД
Gui, 2: Add, Progress, x610 y400 w275 h1 Background333333 c333333, 100
Gui, 2: Font, s9 Norm cFFFFFF
Gui, 2: Add, Text, x610 y412 w60 h20, Клавиша:
Gui, 2: Add, Hotkey, x675 y410 w210 h24 vHot11, %KEY11%
Gui, 2: Add, CheckBox, x610 y445 w85 h20 vRadio8 gSaveCheck Checked%Radio8%, /gm
Gui, 2: Add, CheckBox, x700 y445 w85 h20 vRadio9 gSaveCheck Checked%Radio9%, /esp 4
Gui, 2: Add, CheckBox, x610 y470 w85 h20 vRadio10 gSaveCheck Checked%Radio10%, /leader 5
Gui, 2: Add, CheckBox, x700 y470 w85 h20 vRadio11 gSaveCheck Checked%Radio11%, /hide
Gui, 2: Show, w900 h620, Region Helper
Gosub, CreateOverlay
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

SaveGender:
    Gui, 2: Submit, NoHide
    IniWrite, %Radio3%, Settings.ini, Settings, Male
    IniWrite, %Radio4%, Settings.ini, Settings, Female
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
OpenOvSettings:
Gui, 11: Destroy
Gui, 11: +AlwaysOnTop -MaximizeBox +Owner2
Gui, 11: Color, 1e2124, 2f3136
Gui, 11: Font, s10 Bold c7289da, Segoe UI
Gui, 11: Add, Text, x10 y10 w180 h25 +Center, ПОЗИЦИЯ ОВЕРЛЕЯ
Gui, 11: Font, s9 Norm cFFFFFF
Gui, 11: Add, Text, x20 y45, Координата X:
Gui, 11: Add, Edit, x110 y42 w70 h24 vovX gUpdatePos, %ovX%
Gui, 11: Add, Text, x20 y75, Координата Y:
Gui, 11: Add, Edit, x110 y72 w70 h24 vovY gUpdatePos, %ovY%
Gui, 11: Add, Button, x10 y110 w180 h30 g11GuiClose, ЗАКРЫТЬ
Gui, 11: Show, w200 h150, Настройка X/Y
return

11GuiClose:
Gui, 11: Destroy
return

; === 4. ЛОГИКА ОВЕРЛЕЯ (GUI 10) ===
CreateOverlay:
Gui, 10: Destroy
if (ShowOverlay = 0)
    return

; --- НАСТРОЙКИ (Исправленная ширина и закругление) ---
Gui, 10: +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, 10: Color, 1A1A1A 

; Прозрачность
WinSet, Transparent, 220 
WinSet, Region, 0-0 w170 h28 R10-10 

; Блок ДЕНЬ
Gui, 10: Font, s8 c999999, Segoe UI
Gui, 10: Add, Text, x15 y6, День:
Gui, 10: Font, s9 Bold cFFFFFF
; Сдвинули цифру чуть правее (x50)
Gui, 10: Add, Text, x50 y5 vOvDay, %DayANS%

; Блок НЕДЕЛЯ
Gui, 10: Font, s8 c999999, Segoe UI
; Сдвинули начало блока недели на x95, чтобы не было наслоения
Gui, 10: Add, Text, x95 y6, Неделя:
Gui, 10: Font, s9 Bold cFFFFFF
; Цифра недели теперь на x145
Gui, 10: Add, Text, x145 y5 vOvWeek, %WeekANS%

; Показываем оверлей
Gui, 10: Show, x%ovX% y%ovY% w170 h28 NoActivate
WinSet, ExStyle, +0x20 ; Сквозной клик
return

; === 5. ОБРАБОТЧИКИ СОБЫТИЙ ===

UpdatePos:
Gui, 11: Submit, NoHide
if (ovX = "" || ovX < 0)
    currentX := 0
else
    currentX := ovX
if (ovY = "" || ovY < 0)
    currentY := 0
else
    currentY := ovY
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
    DayANS += 1
    WeekANS += 1
    Gosub, UpdateStatsUI
return

SubRep:
    if (DayANS > 0)
    {
        DayANS -= 1
        WeekANS -= 1
        Gosub, UpdateStatsUI
    }
return

UpdateStatsUI:
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

ResetStats:
MsgBox, 36, Сброс, Сбросить дневную статистику?
IfMsgBox Yes
{
    DayANS := 0
Gosub, UpdateStatsUI
}
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
Reload
return

2GuiClose:
ExitApp
