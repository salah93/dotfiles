local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

-- Create directory if it doesn't exist
local snippet_group = vim.api.nvim_create_augroup("JavaSnippets", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        -- Class template
        ls.add_snippets("java", {
            s("class", fmt([[
public class {} {{
    {}
}}
            ]], {
                i(1, "ClassName"),
                i(2, "// code"),
            })),

            -- Main method
            s("main", fmt([[
public static void main(String[] args) {{
    {}
}}
            ]], {
                i(1, "// code"),
            })),

            -- System.out.println
            s("sout", fmt([[
System.out.println({});
            ]], {
                i(1, ""),
            })),

            -- System.out.printf
            s("soutf", fmt([[
System.out.printf({}, {});
            ]], {
                i(1, "\"%s\""),
                i(2, "var"),
            })),

            -- For loop
            s("for", fmt([[
for (int {} = 0; {} < {}; {}++) {{
    {}
}}
            ]], {
                i(1, "i"),
                rep(1),
                i(2, "length"),
                rep(1),
                i(3, "// code"),
            })),

            -- Enhanced for loop
            s("fore", fmt([[
for ({} {} : {}) {{
    {}
}}
            ]], {
                i(1, "String"),
                i(2, "item"),
                i(3, "items"),
                i(4, "// code"),
            })),

            -- If statement
            s("if", fmt([[
if ({}) {{
    {}
}}
            ]], {
                i(1, "condition"),
                i(2, "// code"),
            })),

            -- If-else statement
            s("ife", fmt([[
if ({}) {{
    {}
}} else {{
    {}
}}
            ]], {
                i(1, "condition"),
                i(2, "// code"),
                i(3, "// code"),
            })),

            -- Try-catch block
            s("try", fmt([[
try {{
    {}
}} catch ({} {}) {{
    {}
}}
            ]], {
                i(1, "// code"),
                i(2, "Exception"),
                i(3, "e"),
                i(4, "// handle exception"),
            })),

            -- Try-catch-finally block
            s("tryf", fmt([[
try {{
    {}
}} catch ({} {}) {{
    {}
}} finally {{
    {}
}}
            ]], {
                i(1, "// code"),
                i(2, "Exception"),
                i(3, "e"),
                i(4, "// handle exception"),
                i(5, "// cleanup code"),
            })),

            -- Method declaration
            s("method", fmt([[
{} {} {}({}) {{
    {}
}}
            ]], {
                c(1, {
                    t("public"),
                    t("private"),
                    t("protected"),
                }),
                c(2, {
                    t("void"),
                    t("String"),
                    t("int"),
                    t("boolean"),
                    t("double"),
                    t("Object"),
                    i(nil, ""),
                }),
                i(3, "methodName"),
                i(4, ""),
                i(5, "// code"),
            })),

            -- Constructor
            s("ctor", fmt([[
{} {}({}) {{
    {}
}}
            ]], {
                c(1, {
                    t("public"),
                    t("private"),
                    t("protected"),
                }),
                i(2, "ClassName"),
                i(3, ""),
                i(4, "// code"),
            })),

            -- JUnit test method
            s("test", fmt([[
@Test
public void test{}() {{
    {}
}}
            ]], {
                i(1, "Scenario"),
                i(2, "// test code"),
            })),

            -- Getter method
            s("get", fmt([[
public {} get{}() {{
    return {};
}}
            ]], {
                i(1, "String"),
                i(2, "PropertyName"),
                i(3, "propertyName"),
            })),

            -- Setter method
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

            -- Interface declaration
            s("interface", fmt([[
public interface {} {{
    {}
}}
            ]], {
                i(1, "InterfaceName"),
                i(2, "// methods"),
            })),

            -- Enum declaration
            s("enum", fmt([[
public enum {} {{
    {}
}}
            ]], {
                i(1, "EnumName"),
                i(2, "VALUE1, VALUE2, VALUE3"),
            })),

            -- Spring @RestController
            s("restcontroller", fmt([[
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping("{}")
public class {} {{
    {}
}}
            ]], {
                i(1, "/api"),
                i(2, "ControllerName"),
                i(3, "// endpoints"),
            })),

            -- Spring @GetMapping
            s("getmapping", fmt([[
@GetMapping("{}")
public {} {}({}) {{
    {}
}}
            ]], {
                i(1, "/path"),
                i(2, "ResponseType"),
                i(3, "methodName"),
                i(4, ""),
                i(5, "// implementation"),
            })),

            -- Spring @PostMapping
            s("postmapping", fmt([[
@PostMapping("{}")
public {} {}({} {}) {{
    {}
}}
            ]], {
                i(1, "/path"),
                i(2, "ResponseType"),
                i(3, "methodName"),
                i(4, "RequestType"),
                i(5, "request"),
                i(6, "// implementation"),
            })),

            -- Log statement
            s("log", fmt([[
private static final java.util.logging.Logger LOGGER = java.util.logging.Logger.getLogger({}.class.getName());
            ]], {
                i(1, "ClassName"),
            })),

            -- Log info
            s("logi", fmt([[
LOGGER.info({});
            ]], {
                i(1, "\"Message\""),
            })),

            -- Log warning
            s("logw", fmt([[
LOGGER.warning({});
            ]], {
                i(1, "\"Warning message\""),
            })),

            -- Log severe
            s("loge", fmt([[
LOGGER.severe({});
            ]], {
                i(1, "\"Error message\""),
            })),
        })
    end,
    group = snippet_group,
})
