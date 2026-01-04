-- Ghostty ドロップダウンターミナル
-- Option + Space でトグル表示

-- 設定
local bundleID = "com.mitchellh.ghostty"
local terminalHeight = 0.7  -- 画面の70%

-- アニメーションを無効化（確実なウィンドウ配置のため）
hs.window.animationDuration = 0

-- ウィンドウをドロップダウン位置に配置
local function positionDropdown(win)
    if win == nil then return end

    local screen = hs.screen.mainScreen()
    local screenFrame = screen:frame()

    local newFrame = {
        x = screenFrame.x,
        y = screenFrame.y,
        w = screenFrame.w,
        h = screenFrame.h * terminalHeight
    }

    win:setFrame(newFrame)
end

-- ホットキー: Option + Space
hs.hotkey.bind({"alt"}, "space", function()
    local app = hs.application.get(bundleID)

    if app == nil then
        -- Ghosttyが起動していない場合は起動
        hs.application.launchOrFocusByBundleID(bundleID)
        -- 起動後にウィンドウを配置
        hs.timer.doAfter(0.3, function()
            local newApp = hs.application.get(bundleID)
            if newApp then
                local win = newApp:mainWindow()
                if win then
                    positionDropdown(win)
                end
            end
        end)
    else
        local win = app:mainWindow()

        if win == nil then
            -- ウィンドウがない場合はアプリをアクティブ化
            app:activate()
            hs.timer.doAfter(0.1, function()
                local w = app:mainWindow()
                if w then positionDropdown(w) end
            end)
            return
        end

        if app:isFrontmost() then
            -- 最前面の場合は非表示にする
            app:hide()
        else
            -- 最前面でない場合は表示してフォーカス
            app:activate()
            positionDropdown(win)
        end
    end
end)
