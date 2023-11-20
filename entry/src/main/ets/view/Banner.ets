import { IBannerModel, HomeModel } from '../model/HomeEntity';
import { IState } from '../model/IStatus';
import { getBanner } from '../request/Home';
import { Constants } from '../utils/Constants';


@Component
export struct Banner {
  private controller: SwiperController = new SwiperController();
  @State list: HomeModel = new HomeModel()

  requestBanner() {
    getBanner().then((data: IBannerModel[]) => {
      this.list.bannerData = [...data]
      this.list.status = IState.Success
    }).catch((err: string | Resource) => {
      this.list.status = IState.Fail
    })
  }

  aboutToAppear() {
    this.requestBanner()
  }

  @Builder LoadingLayout() {
    Text('加载中...').width('100%').height('100%').textAlign(TextAlign.Center)
  }

  @Builder ShowData() {
    Swiper(this.controller) {
      ForEach(this.list.bannerData, (item: IBannerModel) => {
        Image(item.imagePath)
          .objectFit(ImageFit.Fill)
          .height(Constants.FULL_SIZE)
          .width(Constants.FULL_SIZE)
          .borderRadius(Constants.fs_6)
          .align(Alignment.Center)
          .onClick(() => {
          })
      }, (item: IBannerModel, index?: number) => JSON.stringify(item) + index)
    }
    .width(Constants.PAGE_WIDTH)
    .height(Constants.HEIGHT_BANNER)
    .indicatorStyle({ selectedColor: $r('app.color.start_window_background') })
    .indicator(true)
    .loop(true)
    .margin({ top: 5 })
    .autoPlay(true)
    .duration(Constants.DURATION_ADS)
  }

  build() {
    if (this.list.status === IState.Loading) {
      this.LoadingLayout()
    } else {
      this.ShowData()
    }
  }
}