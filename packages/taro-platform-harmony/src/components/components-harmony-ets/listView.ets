import commonStyleModify from './style'

import type { TaroViewElement, TaroAny } from '@tarojs/runtime'

@Reusable
@Component
export default struct TaroListView {
  @Builder customBuilder() {}
  @BuilderParam createLazyChildren: (node: TaroViewElement, layer?: number) => void = this.customBuilder
  @ObjectLink node: TaroViewElement
  @State overwriteStyle: Record<string, TaroAny> = {}

  aboutToAppear(): void {
    if (this.node) {
      this.node._instance = this
    }
  }

  aboutToReuse(params: TaroAny): void {
    // this.node = params.node;
  }

  build() {
    ListItem() {
      Stack() {
        this.createLazyChildren(this.node, 0)
      }
    }
    .attributeModifier(commonStyleModify.setNode(this.node).setAnimationStyle(this.overwriteStyle))
  }
}
