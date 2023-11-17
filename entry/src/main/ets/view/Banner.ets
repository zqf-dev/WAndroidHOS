import router from '@ohos.router';
import { getBanner } from '../request/Home';
import BannerModel from '../model/BannerModel';
import { Constants } from '../utils/Constants';

@Extend(Text) function textStyle(fontSize: number, fontWeight: number) {
  .fontSize(fontSize)
  .fontColor($r('app.color.start_window_background'))
  .fontWeight(fontWeight)
}

@Component
export struct Banner {
  // Change the index value through a scheduled task to perform a round robin.
  @State index: number = 0;
  private swiperController: SwiperController = new SwiperController();
  private list: BannerModel[] = []
  private timerIds: number[] = []

  //请求Banner数据
  requestBanner() {
    getBanner().then((data: BannerModel[]) => {
      this.list = data
    }).catch((err: string | Resource) => {
      console.log('Tag', err)
    })
  }

  //启动计划任务
  startPlay(swiperController: SwiperController): void {
    let timerId = setInterval(() => {
      swiperController.showNext();
    }, Constants.SWIPER_TIME);
    this.timerIds.push(timerId);
  }

  aboutToAppear() {
    this.requestBanner();
    this.startPlay(this.swiperController);
  }

  aboutToDisappear() {
    this.timerIds.forEach((item: number) => {
      clearTimeout(item);
    })
  }

  build() {
    Swiper(this.swiperController) {
      ForEach(this.list, (item: BannerModel) => {
        Stack({ alignContent: Alignment.TopStart }) {
          Image(item.title)
            .objectFit(ImageFit.Fill)
            .height(Constants.FULL_SIZE)
            .width(Constants.FULL_SIZE)
            .borderRadius(Constants.BORDER_RADIUS)
            .align(Alignment.Center)
            .onClick(() => {
              //点击跳转Web组件打开网页
            })
        }
        .height(Constants.FULL_SIZE)
        .width(Constants.FULL_SIZE)
      }, (item: BannerModel) => JSON.stringify(item))
    }
    .width(Constants.PAGE_WIDTH)
    .height(Constants.HEIGHT_BANNER)
    .index(this.index)
    .indicatorStyle({ selectedColor: $r('app.color.start_window_background') })
    .indicator(true)
    .duration(Constants.DURATION_ADS)
  }
}