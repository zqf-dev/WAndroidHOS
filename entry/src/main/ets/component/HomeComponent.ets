import { Constants } from '../utils/Constants';
import { ArticleList } from '../view/ArticleList';
import { Banner } from '../view/Banner';

@Component
export struct Home {
  build() {
    Scroll() {
      Column() {
        //广告页面
        Banner()
        //文章列表
        ArticleList()
      }
      .width(Constants.FULL_SIZE)
    }
    .scrollable(ScrollDirection.Vertical).scrollBar(BarState.Off)
  }
}