import { Constants } from '../../utils/Constants';
import { RefreshConst } from './RefreshConst';
import { RefreshLoadLayoutClass } from './RefreshModel';

@Component
export default struct RefreshLayout {
  @ObjectLink rlc: RefreshLoadLayoutClass;

  build() {
    Column() {
      if (this.rlc.isVisible) {
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
        .width(Constants.FULL_PERCENT)
        .justifyContent(FlexAlign.Center)
        .height(this.rlc.heightValue)
      }
    }
  }
}