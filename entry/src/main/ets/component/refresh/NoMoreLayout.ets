import { RefreshConst } from './RefreshConst'
import { Constants } from '../../utils/Constants'

@Component
export default struct NoMoreLayout {
  build() {
    Row() {
      Text($r('app.string.prompt_message'))
        .margin({ left: RefreshConst.NoMoreLayoutConstant_NORMAL_PADDING })
        .fontSize(RefreshConst.NoMoreLayoutConstant_TITLE_FONT)
        .textAlign(TextAlign.Center)
    }
    .width(Constants.FULL_SIZE)
    .justifyContent(FlexAlign.Center)
    .height(RefreshConst.CUSTOM_LAYOUT_HEIGHT)
  }
}