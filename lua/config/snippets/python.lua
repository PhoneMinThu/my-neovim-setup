local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("python", {
    s("drfser", {
        t({ "from rest_framework import serializers", "", "" }),
        t({ "class " }),
        i(1, "MySerializer"),
        t("(serializers.ModelSerializer):"),
        t({ "", "    class Meta:" }),
        t({ "", "        model = " }),
        i(2, "MyModel"),
        t({ "", "        fields = [" }),
        i(3, "'field1', 'field2'"),
        t("]"),
    }),

    s("drfview", {
        t({ "from rest_framework import viewsets", "", "" }),
        t({ "class " }),
        i(1, "MyViewSet"),
        t("(viewsets.ModelViewSet):"),
        t({ "", "    queryset = " }),
        i(2, "MyModel.objects.all()"),
        t({ "", "    serializer_class = " }),
        i(3, "MySerializer"),
    }),
    s("cls_init", {
        t({ "class " }),
        i(1, "MyClass"),
        t({ ":" }),
        t({ "", "   def __init__(self):" }),
        t({ "", "        pass" }),
    }),
})

local f = ls.function_node

-- Helper to get system python version (e.g., "Python 3.12")
local function python_version()
    local handle = io.popen("python3 --version 2>&1")
    if not handle then
        return "Python 3 (ipykernel)"
    end
    local result = handle:read("*a") or ""
    handle:close()
    return result:gsub("\n", "")
end

-- Helper to get Jupytext version (e.g., "1.17.3")
local function jupytext_version()
    local handle = io.popen("jupytext --version 2>&1")
    if not handle then
        return "1.17.3"
    end
    local result = handle:read("*a") or ""
    handle:close()
    return result:gsub("\n", "")
end

return {
    s("jupytext", {
        t("# ---"),
        t({ "", "# jupyter:" }),
        t({ "", "#   jupytext:" }),
        t({ "", "#     formats: py:percent,ipynb" }),
        t({ "", "#     text_representation:" }),
        t({ "", "#       extension: .py" }),
        t({ "", "#       format_name: percent" }),
        t({ "", "#       format_version: '1.3'" }),
        t({ "", "#       jupytext_version: " }),
        f(jupytext_version, {}),
        t({ "", "#   kernelspec:" }),
        t({ "", "#     display_name: " }),
        f(python_version, {}),
        t({ "", "#     language: python" }),
        t({ "", "#     name: python3" }),
        t({ "", "# ---", "" }),
    }),
}
