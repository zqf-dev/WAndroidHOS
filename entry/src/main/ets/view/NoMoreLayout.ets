
import { Constants } from '../utils/Constants'
@Component
export default struct NoMoreLayout {
  build() {
    Row() {
      Text($r('app.string.prompt_message'))
        .margin({ left: Constants.NoMoreLayoutConstant_NORMAL_PADDING })
        .fontSize(Constants.NoMoreLayoutConstant_TITLE_FONT)
        .textAlign(TextAlign.Center)
    }
    .width(Constants.FULL_SIZE)
    .justifyContent(FlexAlign.Center)
    .height(Constants.CUSTOM_LAYOUT_HEIGHT)
  }
}