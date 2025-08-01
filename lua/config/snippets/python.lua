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
