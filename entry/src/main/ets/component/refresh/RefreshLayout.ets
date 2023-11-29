import { Constants } from '../../utils/Constants';
import { RefreshConst } from './RefreshConst';

@Component
export default struct RefreshLayout {
  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_pull_down_refresh'))
          .width(RefreshConst.RefreshLayout_IMAGE_WIDTH)
          .height(RefreshConst.RefreshLayout_IMAGE_HEIGHT)

        Text($r('app.string.pull_down_refresh_text'))
          .margin({
            left: RefreshConst.RefreshLayout_TEXT_MARGIN_LEFT,
            bottom: RefreshConst.RefreshLayout_TEXT_MARGIN_BOTTOM
          })
          .fontSize(RefreshConst.RefreshLayout_TEXT_FONT_SIZE)
          .textAlign(TextAlign.Center)
      }
      .clip(true)
      .width(Constants.FULL_PERCENT)
      .justifyContent(FlexAlign.Center)
      .height(RefreshConst.CUSTOM_LAYOUT_HEIGHT)
    }
  }
}