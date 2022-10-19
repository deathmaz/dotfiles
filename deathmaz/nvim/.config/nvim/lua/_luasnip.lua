local ok, luasnip = pcall(require, 'luasnip')
if not ok then
  return
end

local ls = luasnip
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets('vue', {
  s('vue:setup', {
    t({
      '<script setup lang="ts">',
      '  ',
    }),
    i(1),
    t({
      '',
      '</script>',
      '',
      '<template>',
      '  <div>',
      '    ',
    }),
    i(2),
    t({
      '',
      '  </div>',
      '</template>',
      '',
    }),
  })
})

ls.add_snippets('markdown', {
  s('sec', {
    i(1, '####'),
    t(' '),
    i(2),
    t(' [' .. os.date("%a, %d.%m.%Y %H:%M") .. ']'),
    t({
      '',
      '',
      '---'
    })
  }),
  s('details', {
    t({
      '<details>',
      ''
    }),
    i(1),
    t({
      '',
      '</details>',
    })
  }),
  s('date:list:item', {
    t('-'),
    t(' [' .. os.date("%a, %d.%m.%Y %H:%M") .. ']'),
    t('('),
    i(1),
    t(')'),
    t(' <- '),
    i(3),
    t(' - '),
    i(2),
  }),
})
