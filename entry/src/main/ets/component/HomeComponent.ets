import http from '@ohos.net.http';
import { BannerModel } from '../model/BannerModel';
import { Constants } from '../utils/Constants';

// class IIDataSource implements IDataSource {
//   private list: BannerModel[] = []
//   private lis: DataChangeListener
//
//   constructor(list) {
//     this.list = list
//   }
//
//   getData(index: number) {
//     return this.list[index]
//   }
//
//   totalCount(): number {
//     return this.list.length
//   }
//
//   unregisterDataChangeListener(listener: DataChangeListener): void {
//     throw new Error('Method not implemented.');
//   }
//
//   registerDataChangeListener(listener: DataChangeListener): void {
//     this.lis = listener
//   }
// }

@Component
export struct Home {
  private swiperController: SwiperController = new SwiperController()

  aboutToAppear() {
    let req = http.createHttp();
    req.request(Constants.API + '/banner/json', (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('result:' + JSON.stringify(data.result));
      }
      // 当该请求使用完毕时，调用destroy方法主动销毁
      req.destroy();
    })
  }

  build() {
    Navigation() {

    }
    .title(Constants.HOME_TITLE)
    .titleMode(NavigationTitleMode.Full)
    .hideToolBar(true)
    .hideBackButton(true)
    .backgroundColor('#fff')
  }
}