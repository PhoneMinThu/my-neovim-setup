return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local ok_registry, mason_registry = pcall(require, "mason-registry")
      if not ok_registry then
        return
      end
      local ok_jdtls, jdtls = pcall(require, "jdtls")
      if not ok_jdtls then
        return
      end

      -- DAP bundles
      local bundles = {}
      if mason_registry.has_package("java-debug-adapter") then
        local pkg = mason_registry.get_package("java-debug-adapter")
        local path = pkg:get_install_path()
        table.insert(bundles, path .. "/extension/server/com.microsoft.java.debug.plugin.jar")
      end
      if mason_registry.has_package("java-test") then
        local pkg = mason_registry.get_package("java-test")
        local path = pkg:get_install_path()
        local jars = vim.split(vim.fn.glob(path .. "/extension/server/*.jar"), "\n", { trimempty = true })
        vim.list_extend(bundles, jars)
      end

      jdtls.start_or_attach({ init_options = { bundles = bundles } })
    end,
  },
}
