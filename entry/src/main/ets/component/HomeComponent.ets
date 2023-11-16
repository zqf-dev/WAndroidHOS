import BannerModel from '../model/BannerModel';
import { getBannerList } from '../request/Home';
import { Constants } from '../utils/Constants';

@Component
export struct Home {
  private controller: SwiperController = new SwiperController()
  private list: BannerModel[] = []

  aboutToAppear() {
    this.requestBanner()
  }

  requestBanner() {
    getBannerList().then((data: BannerModel[]) => {
      this.list = data
    }).catch((err: string | Resource) => {
      console.log('Tag', err)
    })
  }

  build() {
    Swiper(this.controller) {
      Text(this.list[0].title)
        .width('100%')
        .height(160)
        .backgroundColor(0xAFEEEE)
        .textAlign(TextAlign.Center)
        .fontSize(30)
    }
    .cachedCount(2)
    .index(1)
    .autoPlay(true)
    .interval(4000)
    .indicator(true)
    .loop(true)
    .duration(1000)
    .itemSpace(0)
    .curve(Curve.Linear)
    .onChange((index: number) => {
      console.info(index.toString())
    })
  }
}