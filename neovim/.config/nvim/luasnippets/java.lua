local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

return {

    s("test", fmt([[
@Test
public void test{}() {{
{}
}}
    ]], {
        i(1, "Scenario"),
        i(2, "// test code"),
    })),

    s("get", fmt([[
public {} get{}() {{
return {};
}}
    ]], {
        i(1, "String"),
        i(2, "PropertyName"),
        i(3, "propertyName"),
    })),

    s("set", fmt([[
public void set{}({} {}) {{
this.{} = {};
}}
    ]], {
        i(1, "PropertyName"),
        i(2, "String"),
        i(3, "propertyName"),
        rep(3),
        rep(3),
    })),

    s("log", fmt([[
private static final java.util.logging.Logger LOGGER = java.util.logging.Logger.getLogger({}.class.getName());
    ]], {
        i(1, "ClassName"),
    })),
}
