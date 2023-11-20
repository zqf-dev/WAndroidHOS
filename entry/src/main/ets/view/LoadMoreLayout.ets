/**
 * 加载更多组件
 */
import { Constants } from '../utils/Constants';

@Component
export default struct LoadMoreLayout {
  build() {
    Row() {
      Image($r('app.media.loading_icon'))
        .width(Constants.RefreshLayout_IMAGE_WIDTH)
        .height(Constants.RefreshLayout_IMAGE_HEIGHT)

      Text('加载中...')
        .margin({
          left: Constants.RefreshLayout_TEXT_MARGIN_LEFT,
          bottom: Constants.RefreshLayout_TEXT_MARGIN_BOTTOM
        })
        .fontSize(Constants.RefreshLayout_TEXT_FONT_SIZE)
        .textAlign(TextAlign.Center)
    }
    .clip(true)
    .width(Constants.FULL_SIZE)
    .justifyContent(FlexAlign.Center)
    .height(Constants.CUSTOM_LAYOUT_HEIGHT)
  }
}