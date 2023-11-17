import { Constants } from '../utils/Constants';
import { Banner } from '../view/Banner';

@Component
export struct Home {
  build() {
    Scroll() {
      Column() {
        //广告页面
        Banner()
        //List列表
      }
      .width(Constants.FULL_SIZE)
    }
    .scrollable(ScrollDirection.Vertical).scrollBar(BarState.Off)
  }
}