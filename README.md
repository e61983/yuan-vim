# yuan-vim

個人 dotfiles，包含 Neovim 配置、Git 設定，以及幾個 zsh helper 函式。

---

## 目錄

- [安裝](#安裝)
- [Repo 結構](#repo-結構)
- [Neovim 配置](#neovim-配置)
  - [架構與載入流程](#架構與載入流程)
  - [編輯器選項](#編輯器選項)
  - [外掛清單](#外掛清單)
  - [Go 開發環境](#go-開發環境)
- [Keymap 對照表](#keymap-對照表)
- [Git 設定](#git-設定)
- [zsh Helper](#zsh-helper)
- [相依工具](#相依工具)

---

## 安裝

```sh
git clone <repo> ~/yuan-vim
cd ~/yuan-vim
./install.sh
```

`install.sh` 會做三件事（皆為「不存在才建立」，不會覆蓋既有檔案）：

1. symlink `gitconfig` → `~/.gitconfig`
2. symlink `nvim/` → `~/.config/nvim`
3. 對每個 `helper/*.helper`，在 `~/.zprofile` 追加一行 `source <helper>`

> 第一次啟動 Neovim 時，`lazy.nvim` 會自動 bootstrap 並安裝所有外掛。

---

## Repo 結構

```
yuan-vim/
├── install.sh          # symlink + zprofile 設定
├── gitconfig           # 主 git 設定（include my_config）
├── my_config           # git alias 與 git-flow wrapper
├── helper/             # zsh 函式（被 source 進 ~/.zprofile）
│   ├── gen-docker-compose.helper
│   └── gen-makefile.helper
└── nvim/               # Neovim 配置（→ ~/.config/nvim）
    ├── init.lua
    ├── lazy-lock.json  # 外掛版本鎖定
    └── lua/yuan/
        ├── core/       # options + keymaps
        ├── lazy.lua    # lazy.nvim bootstrap
        └── plugins/    # 一檔一外掛 spec
            └── lsp/    # LSP / 補全相關
```

---

## Neovim 配置

### 架構與載入流程

進入點 `init.lua` 只做兩件事：

```lua
require("yuan.core")   -- 載入 options 與 keymaps
require("yuan.lazy")   -- bootstrap lazy.nvim 並 import 外掛目錄
```

- `core/init.lua` → 引入 `core.options`（`vim.opt` 設定）與 `core.keymaps`（leader 與視窗/分頁綁定）。
- `lazy.lua` → 把 `lazy.nvim` clone 進 `stdpath("data")/lazy/`，再 `lazy.setup` import 兩個目錄群組：
  - `lua/yuan/plugins/` — 一般外掛，每檔 `return` 一個 lazy spec。
  - `lua/yuan/plugins/lsp/` — LSP 與補全，獨立 import。

`lazy.setup` 啟用 `checker`（背景檢查更新、不通知）與 `change_detection`（存檔自動重新解析、不通知）。

> **新增外掛**：在 `plugins/`（或 `plugins/lsp/`）丟一個 `return { ... }` 的 spec 檔即可，目錄會自動 import，無需註冊。

### 編輯器選項

定義於 `core/options.lua`，重點：

| 類別 | 設定 |
|------|------|
| 行號 | `relativenumber` + `number`（混合相對/絕對行號）、`ruler` |
| 視覺輔助 | `colorcolumn=80`、`cursorline`、`signcolumn=yes` |
| 縮排 | tab 寬度 4、`expandtab`（tab 轉空格）、`autoindent`、`smarttab` |
| 換行 | `wrap=false`（不自動換行） |
| 搜尋 | `ignorecase` + `smartcase`、`hls`（高亮結果） |
| 顏色 | `termguicolors`、`background=dark`（需 true color 終端機） |
| 不可見字元 | `list` 開啟，自訂 `listchars`（tab/trail/eol 等） |
| 剪貼簿 | `clipboard=unnamedplus`（直接用系統剪貼簿） |
| 分割 | `splitright` + `splitbelow`（新視窗往右/往下開） |
| 其他 | `swapfile=false`（關閉 swap 檔） |

### 外掛清單

| 外掛 | 用途 | 載入時機 |
|------|------|----------|
| `folke/snacks.nvim` | 檔案瀏覽（explorer）、模糊搜尋（picker）、通知（notifier）、輸入框（input）整合 UI | 啟動即載入 |
| `nvim-treesitter/nvim-treesitter`（main 分支） | 語法高亮與 treesitter 折疊 | 啟動即載入 |
| `ellisonleao/gruvbox.nvim` | 配色主題（gruvbox dark） | 啟動即載入 |
| `nvim-lualine/lualine.nvim` | 狀態列（自訂主題、顯示 lazy 待更新數） | — |
| `folke/noice.nvim` | cmdline / messages UI（通知交給 snacks） | `VeryLazy` |
| `lewis6991/gitsigns.nvim` | git 變更標記 + 行內 blame | — |
| `numToStr/Comment.nvim` | 註解切換 | — |
| `preservim/tagbar` | 符號大綱側欄（Go 專用 ctags 設定） | — |
| `nvim-lua/plenary.nvim` | 多外掛共用的 lua 函式庫 | — |
| **LSP / 補全** | | |
| `neovim/nvim-lspconfig` | LSP 設定（僅 `gopls`） | `ft=go` |
| `saghen/blink.cmp` | 自動補全（含 LuaSnip + friendly-snippets） | `InsertEnter` |
| `nvimdev/lspsaga.nvim` | LSP UI（hover、finder、rename、診斷跳轉等） | `LspAttach` |
| **除錯（Go）** | | |
| `mfussenegger/nvim-dap` | DAP 除錯（+ dap-go / dap-ui / virtual-text / nio） | `ft=go` |

> 外掛版本鎖定於 `nvim/lazy-lock.json`，刻意更新時記得一併 commit lockfile。

### Go 開發環境

- **LSP**：`nvim-lspconfig` 只設定 `gopls`（`ft=go` 時載入），啟用 `staticcheck`、`gofumpt`、`completeUnimported`、`usePlaceholders`、`unusedparams` 分析。
- **補全**：`blink.cmp` 使用 release tag 取得預編譯 fuzzy matcher binary（免裝 Rust），來源含 LSP / path / snippets / buffer。
- **格式化**：`nvim-lspconfig` 註冊 `BufWritePre *.go` autocmd，存檔時由 gopls 執行 organize-imports + format（gofumpt）。
- **除錯**：`nvim-dap` + `nvim-dap-go`，adapter 使用 `dlv dap`；keymap 直接走 dap 原生操作。
- **大綱**：`tagbar` 配 `gotags` 顯示 Go 符號結構。

---

## Keymap 對照表

Leader 鍵為 **`,`**（逗號）。

### 一般 / 視窗 / 分頁（`core/keymaps.lua`）

| 按鍵 | 動作 |
|------|------|
| `<leader>+` | 數字 +1 |
| `<leader>-` | 數字 −1 |
| `<leader>sv` | 垂直分割視窗 |
| `<leader>sh` | 水平分割視窗 |
| `<leader>se` | 分割視窗等寬等高 |
| `<leader>sx` | 關閉目前分割 |
| `<leader>to` | 開新分頁 |
| `<leader>tx` | 關閉目前分頁 |
| `<leader>tn` | 下一個分頁 |
| `<leader>tp` | 上一個分頁 |
| `<leader>tf` | 在新分頁開啟目前 buffer |
| `<F1>` | 停用（避免誤觸 help） |

### 檔案瀏覽 / 搜尋（snacks）

| 按鍵 | 動作 |
|------|------|
| `<F3>` / `<C-n>` | 開啟檔案瀏覽器（靠右） |
| `<leader>ff` | 找檔案 |
| `<leader>fg` | 全文搜尋（live grep） |
| `<leader>fb` | 切換 buffer |
| `<leader>fh` | 搜尋 help tags |

### LSP（lspsaga，`LspAttach` 後生效）

| 按鍵 | 動作 |
|------|------|
| `K` | hover 文件 |
| `gr` | finder（references / definition） |
| `gd` | peek definition（浮窗預覽定義） |
| `gn` | rename |
| `ge` | 顯示游標行診斷 |
| `[e` | 跳到下一個診斷 |
| `]e` | 跳到上一個診斷 |
| `<A-d>` | 開啟/關閉浮動終端機（normal 開、terminal 關） |

### 自動補全（blink.cmp，insert mode）

| 按鍵 | 動作 |
|------|------|
| `<C-j>` | 下一個候選 |
| `<C-k>` | 上一個候選 |
| `<Tab>` | 下一個候選 / snippet 往前 |
| `<S-Tab>` | 上一個候選 / snippet 往後 |
| `<CR>` | 確認選取 |
| `<C-Space>` | 顯示候選 / 切換文件 |
| `<C-e>` | 隱藏候選 |
| `<C-b>` / `<C-f>` | 文件視窗上 / 下捲動 |

### 除錯（nvim-dap，`ft=go`）

| 按鍵 | 動作 |
|------|------|
| `<F5>` | 開始 / 繼續除錯（dap continue） |
| `<leader>b` | 切換中斷點（dap toggle breakpoint） |

### 其他

| 按鍵 | 動作 | 來源 |
|------|------|------|
| `<leader>c<space>` | 切換註解（normal / visual） | Comment.nvim |
| `<F2>` | 切換 Tagbar 大綱 | tagbar |

---

## Git 設定

`gitconfig` 透過 `include` 引入 `my_config`，並設定：預設分支 `master`、git-lfs filter、`diff.external = difft`（需 [difftastic](https://github.com/Wilfred/difftastic)）、merge tool `vimdiff`、editor `vim`。

`my_config` 定義的 alias：

**短指令**

| Alias | 展開 |
|-------|------|
| `co` / `ci` / `st` / `sts` | checkout / commit / status / status -s |
| `br` / `re` / `di` / `cp` | branch / remote / diff / cherry-pick |
| `type` / `dump` | cat-file -t / cat-file -p |
| `lo` / `ll` / `lg` | 各式 log 格式（oneline / 詳細 / 圖形） |

**工作流**

| Alias | 用途 |
|-------|------|
| `start-feature` / `start-bugfix` / `start-hotfix` / `start-release` | `git flow <type> start` |
| `finish-feature` / `finish-bugfix` / `finish-hotfix` / `finish-release` | 從 HEAD 推導分支名後 `git flow <type> finish` |
| `publish` | 把目前分支推到 `origin` |
| `cleanup` | prune 遠端 ref，並刪除已 merge 進 master/develop 的本地分支 |

> git-flow wrapper 需安裝 `git-flow`。

---

## zsh Helper

`helper/*.helper` 內定義 zsh 函式（由 `install.sh` source 進 `~/.zprofile`）：

| 函式 | 用途 |
|------|------|
| `gen_docker-compose` | 在當前目錄產生一份 nginx 範例 `compose.yaml` |
| `gen_makefile` | 產生 Go 跨平台（darwin arm64 / amd64）建置用 `Makefile`（含 upx 壓縮、打包 zip） |

---

## 相依工具

| 工具 | 用於 |
|------|------|
| Neovim（true color 終端機） | 編輯器本體 |
| `gopls` | Go LSP |
| `dlv`（delve） | Go 除錯 |
| `gotags` + universal-ctags | Tagbar 大綱（首次會嘗試以 brew 安裝 universal-ctags） |
| tree-sitter CLI | nvim-treesitter main 分支建置 parser |
| `difft`（difftastic） | git 外部 diff |
| `git-flow` | git-flow alias |
| Nerd Font | 圖示顯示（lualine / blink 等） |
```
