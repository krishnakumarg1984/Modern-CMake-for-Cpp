-- vim: foldmethod=marker:foldlevel=0:

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/SOURCES.md
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/859
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local cppcheck_clang_arg = ""
-- if vim.fn.executable "clang" == 1 then
--   cppcheck_clang_arg = "--clang"
-- end

local cppcheck_builddir_name = "cppcheck_build"
if vim.fn.isdirectory(cppcheck_builddir_name) == 0 then
  vim.fn.mkdir(cppcheck_builddir_name)
end
local cppcheck_builddir_arg = ""
if vim.fn.isdirectory(cppcheck_builddir_name) == 1 then
  cppcheck_builddir_arg = "--cppcheck-build-dir=" .. cppcheck_builddir_name
end

local cppcheck_project_arg = ""
local compilation_database_filename = "compile_commands.json"
if vim.fn.filereadable(compilation_database_filename) == 1 then
  cppcheck_project_arg = "--project=" .. compilation_database_filename
end

local cppcheck_suppressions_filename = "cppcheck_suppressions.txt"
if vim.fn.filereadable(cppcheck_suppressions_filename) == 0 then
  vim.fn.writefile({ "" }, cppcheck_suppressions_filename, "b")
end
local cppcheck_suppressions_filename_arg = ""
if vim.fn.readfile(cppcheck_suppressions_filename) == 1 then
  cppcheck_suppressions_filename_arg = "--suppressions-list=" .. cppcheck_suppressions_filename
end

null_ls.register({
  diagnostics.cmake_lint,
  diagnostics.cppcheck.with({
    extra_args = {
      cppcheck_clang_arg,
      cppcheck_builddir_arg,
      cppcheck_project_arg,
      cppcheck_suppressions_filename_arg,
      "--inline-suppr",
      "--language=c++",
      "--enable=all",
      "--suppress=missingIncludeSystem",
      -- "--addon=threadsafety.py",
    },
  }),
  -- diagnostics.clang_check, -- sometimes flags certain warnings with higher severity (i.e. as errors)
  diagnostics.cpplint,
  diagnostics.shellcheck.with({ diagnostics_format = "[#{c}] #{m} (#{s})" }),
  formatting.clang_format,
  formatting.gersemi,
  formatting.shfmt,
  formatting.stylua,
})
null_ls.enable({})

-- Other project-specific 'diagnostic-linters' and 'formatters' to consider {{{
-- formatting.asmformat,
-- formatting.bibclean,
-- formatting.brittany,
-- formatting.format_r, -- needs the 'R' command to be in $PATH
-- formatting.fprettify,
-- formatting.goformat,
-- formatting.goimports,
-- formatting.latexindent,
-- formatting.mdformat,
-- formatting.perltidy,
-- formatting.reorder_python_imports,
-- formatting.rustfmt,
-- formatting.shfmt.with { extra_args = { "-i", "2", "-ci" } },
-- formatting.sqlfluff,
-- formatting.standardrb,
-- formatting.styler, -- needs the 'R' command to be in $PATH
-- formatting.taplo,
-- diagnostics.actionlint,
-- diagnostics.ansiblelint,
-- diagnostics.checkmake,
-- diagnostics.chktex,
-- diagnostics.codespell,
-- diagnostics.cspell,  -- requires 'npm'
-- diagnostics.flake8,
-- diagnostics.gitlint,
-- diagnostics.hadolint,
-- diagnostics.jsonlint,
-- diagnostics.markdownlint,
-- diagnostics.mlint,
-- diagnostics.mypy,
-- diagnostics.proselint,
-- diagnostics.pydocstyle.with { extra_args = { "--config=$ROOT/setup.cfg" } },
-- diagnostics.pylama,
-- diagnostics.pylint,
-- diagnostics.pyproject_flake8,
-- diagnostics.revive.with { method = null_ls.methods.DIAGNOSTICS_ON_SAVE },
-- diagnostics.rstcheck,
-- diagnostics.selene,
-- diagnostics.semgrep,
-- diagnostics.shellcheck.with { diagnostics_format = "[#{c}] #{m} (#{s})" },
-- diagnostics.sqlfluff,
-- diagnostics.staticcheck.with { method = null_ls.methods.DIAGNOSTICS_ON_SAVE },
-- diagnostics.stylint,
-- diagnostics.textlint,
-- diagnostics.vale,
-- diagnostics.vint,
-- diagnostics.vulture, -- usually not available in path
-- diagnostics.write_good,
-- diagnostics.yamllint,
-- }}}

local status_ok_nvim_lint, nvim_lint = pcall(require, "lint")
if not status_ok_nvim_lint then
  return
end
nvim_lint.linters_by_ft = {
  cmake = { "cmakelint" },
  -- cpp = { "clangtidy", "flawfinder" },
  cpp = {},
  java = { "checkstyle" },
  latex = { "lacheck" },
  python = { "pycodestyle" },
  tex = { "lacheck" },
  rst = { "rstlint" },
}

local utils = require("astronvim.utils")

if vim.fn.executable("clang-tidy") == 1 then
  -- print "clang-tidy is installed"
  utils.list_insert_unique(nvim_lint.linters_by_ft.cpp, "clangtidy")
end
-- if vim.fn.executable "flawfinder" == 1 then
--   -- print "flawfinder is installed"
--   utils.list_insert_unique(nvim_lint.linters_by_ft.cpp, "flawfinder")
--   utils.list_insert_unique(nvim_lint.linters_by_ft.c, "flawfinder")
-- end

-- vim.cmd [[autocmd BufWritePost * lua require('lint').try_lint()]]
vim.cmd([[
autocmd BufReadPost * lua require('lint').try_lint()
autocmd BufWritePost * lua require('lint').try_lint()
]])
