import type { HarmonyStyle, TaroElement, TaroStyleType } from '@tarojs/runtime'
import { isUndefined } from '../shared'
import { getNormalAttributes, getStyle } from './utils/helper'

function getTop (node: TaroElement): Length | number {
  return node?.hmStyle?.top || 0
}

function getLeft (node: TaroElement): Length | number {
  return node?.hmStyle?.left || 0
}

class CommonStyleModify implements AttributeModifier<CommonAttribute> {
  node: TaroElement | null = null
  style: TaroStyleType | null = null

  setNode (node: TaroElement) {
    this.node = node
    this.style = getNormalAttributes(this.node)

    return this
  }

  applyNormalAttribute(instance: CommonAttribute): void {
    if (this.node && this.style) {
      setNormalAttributeIntoInstance(instance, this.style)
    }
  }
}

class PseudoStyleModify implements AttributeModifier<CommonAttribute> {
  style: TaroStyleType | null = null

  setStyle (style: HarmonyStyle) {
    this.style = getStyle(style)
    return this
  }

  applyNormalAttribute(instance: CommonAttribute): void {
    if (this.style) {
      setNormalAttributeIntoInstance(instance, this.style)
    }
  }
}


function setNormalAttributeIntoInstance(instance: CommonAttribute, style: TaroStyleType) {
  if (!isUndefined(style.id)) {
    instance.id(style.id)
    instance.key(style.id)
  }
  if (!isUndefined(style.flexGrow)) {
    instance.flexGrow(style.flexGrow)
  }
  if (!isUndefined(style.flexShrink)) {
    instance.flexShrink(style.flexShrink)
  }
  if (!isUndefined(style.flexBasis)) {
    instance.flexBasis(style.flexBasis)
  }
  if (!isUndefined(style.alignSelf)) {
    instance.alignSelf(style.alignSelf)
  }
  if (!isUndefined(style.paddingTop) || !isUndefined(style.paddingRight) || !isUndefined(style.paddingBottom) || !isUndefined(style.paddingLeft)) {
    instance.padding({
      top: style.paddingTop,
      right: style.paddingRight,
      bottom: style.paddingBottom,
      left: style.paddingLeft
    })
  }
  if (!isUndefined(style.marginTop) || !isUndefined(style.marginRight) || !isUndefined(style.marginBottom) || !isUndefined(style.marginLeft)) {
    instance.margin({
      top: style.marginTop,
      right: style.marginRight,
      bottom: style.marginBottom,
      left: style.marginLeft
    })
  }
  if (!isUndefined(style.width)) {
    instance.width(style.width)
  }
  if (!isUndefined(style.height)) {
    instance.height(style.height)
  }
  if (!isUndefined(style.minWidth) || !isUndefined(style.maxWidth) || !isUndefined(style.minHeight) || !isUndefined(style.maxHeight)) {
    instance.constraintSize({
      minWidth: style.minWidth,
      maxWidth: style.maxWidth,
      minHeight: style.minHeight,
      maxHeight: style.maxHeight
    })
  }
  if (!isUndefined(style.backgroundColor)) {
    instance.backgroundColor(style.backgroundColor)
  }
  if (!isUndefined(style.backgroundImage)) {
    instance.backgroundImage(style.backgroundImage?.src, style.backgroundRepeat)
  }
  if (!isUndefined(style.backgroundSize)) {
    instance.backgroundImageSize(style.backgroundSize)
  }
  if (!isUndefined(style.backgroundPosition)) {
    instance.backgroundImagePosition(style.backgroundPosition)
  }
  if (!isUndefined(style.borderTopStyle) || !isUndefined(style.borderRightStyle) || !isUndefined(style.borderBottomStyle) || !isUndefined(style.borderLeftStyle)) {
    instance.borderStyle({
      top: style.borderTopStyle,
      right: style.borderRightStyle,
      bottom: style.borderBottomStyle,
      left: style.borderLeftStyle
    })
  }
  if (!isUndefined(style.borderTopWidth) || !isUndefined(style.borderRightWidth) || !isUndefined(style.borderBottomWidth) || !isUndefined(style.borderLeftWidth)) {
    instance.borderWidth({
      top: style.borderTopWidth,
      right: style.borderRightWidth,
      bottom: style.borderBottomWidth,
      left: style.borderLeftWidth
    })
  }
  if (!isUndefined(style.borderTopColor) || !isUndefined(style.borderRightColor) || !isUndefined(style.borderBottomColor) || !isUndefined(style.borderLeftColor)) {
    instance.borderColor({
      top: style.borderTopColor,
      right: style.borderRightColor,
      bottom: style.borderBottomColor,
      left: style.borderLeftColor
    })
  }
  if (!isUndefined(style.borderTopLeftRadius) || !isUndefined(style.borderTopRightRadius) || !isUndefined(style.borderBottomLeftRadius) || !isUndefined(style.borderBottomRightRadius)) {
    instance.borderRadius({
      topLeft: style.borderTopLeftRadius,
      topRight: style.borderTopRightRadius,
      bottomLeft: style.borderBottomLeftRadius,
      bottomRight: style.borderBottomRightRadius
    })
  }
  if (!isUndefined(style.zIndex)) {
    instance.zIndex(style.zIndex)
  }
  if (!isUndefined(style.opacity)) {
    instance.opacity(style.opacity)
  }
  if (!isUndefined(style.linearGradient)) {
    instance.linearGradient(style.linearGradient)
  }
  if (!isUndefined(style.overflow)) {
    instance.clip(style.overflow)
  }
  if (!isUndefined(style.transformOrigin)) {
    instance.rotate({ centerX: style.transformOrigin.x, centerY: style.transformOrigin.y, angle: 0 })
    instance.scale({ centerX: style.transformOrigin.x, centerY: style.transformOrigin.y })
  }
  if (!isUndefined(style.transform)) {
    instance.transform(style.transform)
  }
  if (style.position === 'absolute' || style.position === 'fixed') {
    instance.position({
      x: style.left || 0,
      y: style.top || 0,
    })
  }
  if (style.position === 'relative') {
    instance.offset({
      x: style.left || 0,
      y: style.top || 0,
    })
  }
}

const modify = new CommonStyleModify()

export const pseudoModify = new PseudoStyleModify()

export default modify