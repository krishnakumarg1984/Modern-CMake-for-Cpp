-- vim: foldmethod=marker:foldlevel=0:

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/SOURCES.md
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/859
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- list of globally installed sources in $PATH (not those installed with ':FInstall')
null_ls.register {
  -- diagnostics.codespell,
  -- diagnostics.shellcheck.with { diagnostics_format = "[#{c}] #{m} (#{s})" },
  -- formatting.codespell,
  -- formatting.shfmt,
  -- null_ls.builtins.code_actions.cspell,
  -- null_ls.builtins.hover.dictionary,
  diagnostics.buf,
  diagnostics.clang_check.with {
    extra_args = { "-x c++" },
  },
  diagnostics.cmake_lint,
  diagnostics.cppcheck.with {
    extra_args = { "-std=c++20" },
  },
  diagnostics.cpplint,
  diagnostics.gitlint,
  diagnostics.protolint,
  formatting.buf,
  formatting.clang_format,
  formatting.cmake_format,
  formatting.gersemi,
  formatting.protolint,
  formatting.stylua,
}
null_ls.enable {}

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
  -- c = { "clangtidy", "clazy", "flawfinder" },
  c = { "clazy", "flawfinder" },
  cmake = { "cmakelint" },
  -- cpp = { "clangtidy", "flawfinder" },
  cpp = { "flawfinder" },
  java = { "checkstyle" },
  latex = { "lacheck" },
  python = { "pycodestyle" },
  tex = { "lacheck" },
  rst = { "rstlint" },
}
vim.cmd [[autocmd BufWritePost * lua require('lint').try_lint()]]
