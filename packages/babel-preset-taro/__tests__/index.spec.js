/* eslint-disable @typescript-eslint/no-unused-vars */
const babelPresetTaro = require('..')

describe('babel-preset-taro', () => {
  it('react', () => {
    const config = babelPresetTaro({}, {
      framework: 'react'
    })

    expect(config.sourceType).toBe('unambiguous')
  })

  it('vue3', () => {
    const config = babelPresetTaro({}, {
      framework: 'vue3'
    })

    expect(config.sourceType).toBe('unambiguous')

    const [override] = config.overrides

    const [[jsxPlugin, jsxOptions]] = override.plugins
    expect(jsxPlugin === require('@vue/babel-plugin-jsx')).toBeTruthy()
    expect(jsxOptions).toEqual({})
  })

  it('vue3 without jsx', () => {
    const config = babelPresetTaro({}, {
      framework: 'vue3',
      vueJsx: false
    })

    expect(config.sourceType).toBe('unambiguous')

    const [override] = config.overrides

    const [[jsxPlugin, jsxOptions]] = override.plugins
    expect(jsxPlugin === require('@vue/babel-plugin-jsx')).toBeFalsy()
  })

  it('typescript react', () => {
    const config = babelPresetTaro({}, {
      framework: 'react',
      ts: true
    })

    expect(config.sourceType).toBe('unambiguous')

    const [override] = config.overrides

    const [, , [ts, tsconfig]] = override.presets
    expect(typeof ts.default === 'function').toBeTruthy()
    expect(tsconfig.jsxPragma === 'React').toBeTruthy()
  })

  it('typescript vue3', () => {
    const config = babelPresetTaro({}, {
      framework: 'vue3',
      ts: true
    })

    const [, vueOverride] = config.overrides
    const [[ts, tsConfig]] = vueOverride.presets

    expect(typeof ts.default === 'function').toBeTruthy()
    expect(tsConfig.hasOwnProperty('jsxPragma') === false).toBeTruthy()
    expect(tsConfig.allExtensions).toBeTruthy()
    expect(tsConfig.isTSX).toBeTruthy()

    expect(vueOverride.include.test('a.vue')).toBeTruthy()
  })

  it('can change env options', () => {
    const config = babelPresetTaro({}, {
      framework: 'react',
      ts: true,
      spec: false,
      loose: false
    })

    expect(config.sourceType).toBe('unambiguous')

    const [override] = config.overrides

    const [, env] = override.presets[0]
    expect(env.spec).toBeFalsy()
    expect(env.loose).toBeFalsy()
  })

  it('default env options', () => {
    const config = babelPresetTaro({}, {
      framework: 'react',
      ts: true,
      spec: true,
      loose: true
    })

    expect(config.sourceType).toBe('unambiguous')

    const [override] = config.overrides

    const [, env] = override.presets[0]
    expect(env).toEqual({
      spec: true,
      loose: true,
      debug: false,
      modules: 'commonjs',
      targets: { node: 'current' },
      useBuiltIns: false,
      ignoreBrowserslistConfig: true
    })
  })

  it('has dynamic-import-node', () => {
    const config = babelPresetTaro({}, {
      framework: 'react',
      ts: true
    })

    expect(config.sourceType).toBe('unambiguous')

    const [override] = config.overrides

    const [dynamicImportNode] = override.plugins[override.plugins.length - 2]
    expect(dynamicImportNode === require('babel-plugin-dynamic-import-node')).toBeTruthy()
  })

  it('disable dynamic-import-node', () => {
    const config = babelPresetTaro({}, {
      framework: 'react',
      ts: true,
      'dynamic-import-node': false
    })

    expect(config.sourceType).toBe('unambiguous')

    const [override] = config.overrides

    const [dynamicImportNode] = override.plugins[override.plugins.length - 2]
    expect(dynamicImportNode === require('babel-plugin-dynamic-import-node')).toBeFalsy()
  })

  it('can react preset change', () => {
    const config = babelPresetTaro({}, {
      framework: 'react',
      ts: true,
      react: {
        throwIfNamespace: false
      }
    })

    expect(config.sourceType).toBe('unambiguous')

    const [override] = config.overrides

    const [, [, reactConfig]] = override.presets
    expect(reactConfig.throwIfNamespace).toBeFalsy()
  })
})
