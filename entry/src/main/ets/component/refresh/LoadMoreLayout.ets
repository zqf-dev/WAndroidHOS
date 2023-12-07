/**
 * 加载更多组件
 */
import { RefreshConst } from './RefreshConst';
import { Constants } from '../../utils/Constants';
import { RefreshLoadLayoutClass } from './RefreshModel';

@Component
export default struct LoadMoreLayout {
  @ObjectLink rlc: RefreshLoadLayoutClass;

  build() {
    Column() {
      Row() {
        Image(this.rlc.imageSrc)
          .width(RefreshConst.RefreshLayout_IMAGE_WIDTH)
          .height(RefreshConst.RefreshLayout_IMAGE_HEIGHT)
        Text(this.rlc.textValue)
          .margin({
            left: RefreshConst.RefreshLayout_TEXT_MARGIN_LEFT,
            bottom: RefreshConst.RefreshLayout_TEXT_MARGIN_BOTTOM
          })
          .fontSize(RefreshConst.RefreshLayout_TEXT_FONT_SIZE)
          .textAlign(TextAlign.Center)
      }
      .clip(true)
      .width(Constants.FULL_SIZE)
      .justifyContent(FlexAlign.Center)
      .height(this.rlc.isVisible ? this.rlc.heightValue : 0)
    }
  }
}
