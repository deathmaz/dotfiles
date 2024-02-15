local ok, luasnip = pcall(require, 'luasnip')
if not ok then
  return
end

local ls = luasnip
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

ls.setup({
  history = true,
  region_check_events = "InsertEnter",
  delete_check_events = "TextChanged,InsertLeave",
})

ls.add_snippets('vue', {
  s('vue:setup',
    fmt([[
<script setup lang="ts">
{}
</script>

<template>
  <div>
    {}
  </div>
</template>
    ]], {
      i(1),
      i(2)
    })),
  s('html:todo',
    fmt([[
<!-- TODO: {} -->
    ]], {
      i(1),
    }))
})

ls.add_snippets('typescript', {
  s('test:elem',
    fmta([[
const <> = (wrapper: VueWrapper) =>> wrapper.find('<>');
    ]], {
      i(1),
      i(2),
    })),
  s('test:factory',
    fmta([[
function factory(payload?: {
  props?: Record<<string, any>>,
  slots?: Record<<string, any>>,
}) {
  return mount(<>, {
    attachTo: document.body,
    props: {
      ...payload?.props,
    },
    slots: {
      ...payload?.slots,
    },
  });
}
    ]], {
      i(1),
    })),
  s('test:setup',
    fmta([[
import {
  it,
  expect,
  describe,
} from 'vitest';
import {
  mount,
  VueWrapper,
} from '@vue/test-utils';

describe('<>', () =>> {
  <>
});
    ]], {
      i(1),
      i(2),
    })),
  s('test:setup-api',
    fmta([[
import {
  expect,
  MockInstance,
  it,
  describe,
  afterEach,
  vi,
  beforeEach,
} from 'vitest';
import {
  defineComponent,
  onBeforeUnmount,
  PropType,
} from 'vue';
import {
  mount,
  enableAutoUnmount,
  flushPromises,
  VueWrapper,
} from '@vue/test-utils';
import {
  api,
} from '@/api/api';
<>

let getHandler: MockInstance;
const apiHandlers: MockInstance[] = [];
const prepareApiCalls = () =>> {
  apiHandlers.push(
    getHandler = vi.spyOn(api, 'get').mockImplementation((url) =>> {
      switch (url) {
        case 'url':
          return Promise.resolve();
        default:
          return Promise.reject();
      }
    }),
  );
};
beforeEach(async () =>> {
  prepareApiCalls();
});

afterEach(async () =>> {
  apiHandlers.forEach((handler) =>> handler.mockReset());
});

enableAutoUnmount(afterEach);

describe('<>', () =>> {
  it('<>', async() =>> {
    <>
  })
})
    ]], {
      i(1),
      i(2),
      i(3),
      i(4),
    })),
  s('test:it',
    fmta([[
it('<>', async () =>> {
  <>
})
    ]], {
      i(1),
      i(2),
    })),
})

ls.add_snippets('markdown', {
  s('detsum',
    fmta([[
<<details>>
  <<summary>>
    <>
  <</summary>>



<</details>>
    ]], {
      i(1),
    })),
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
