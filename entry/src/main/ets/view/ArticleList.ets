import router from '@ohos.router';
import { Article, IArticle } from '../model/HomeEntity';
import { getArticle, } from '../request/Home'
import { Constants } from '../utils/Constants';

@Component
export struct ArticleList {
  @State page: number = 0;
  @State list: Article = new Article()
  @State isRefreshing: boolean = false
  @State over: boolean = true

  aboutToAppear() {
    this.reqArticle()
  }

  /**
   * 请求文章列表数据
   */
  reqArticle() {
    getArticle(this.page).then((res: Article) => {
      this.over = res.over
      if (this.list && this.list.datas && this.list.datas.length > 0) {
        this.list.datas = this.list.datas.concat(res.datas)
        return
      }
      this.list.datas = res.datas
    })
  }

  @Builder showData() {
    //下拉刷新
    List() {
      ForEach(this.list.datas, (item: IArticle) => {
        ListItem() {
          Flex({ direction: FlexDirection.Column }) {
            //作者+新/置顶/时间
            Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
              Flex({ alignItems: ItemAlign.Center }) {
                //作者
                Text(item.author ? "作者：" + item.author : "分享者：" + item.shareUser).fontSize(Constants.fs_11)
                //置顶数据
                if (item.type === 1) {
                  Text('置顶')
                    .fontColor(Color.Red)
                    .borderRadius(Constants.fs_12)
                    .fontSize(Constants.fs_10)
                    .borderWidth(1)
                    .borderColor(Color.Red)
                    .margin({ left: Constants.fs_10 })
                    .padding({ left: 5, right: 5, top: 3, bottom: 3 })
                }
                if (item.fresh) {
                  //是否最新数据
                  Text('新')
                    .fontColor(Color.Red)
                    .fontSize(11)
                    .borderRadius(5)
                    .borderWidth(1)
                    .borderColor(Color.Red)
                    .margin({ left: 10 })
                    .textAlign(TextAlign.Center)
                    .padding({ left: 5, right: 5, top: 3, bottom: 3 })
                } else {
                  if (item.tags.length > 0) {
                    Text(item.tags[0].name)
                      .fontColor(Color.Green)
                      .fontSize(Constants.fs_10)
                      .borderRadius(Constants.fs_12)
                      .borderWidth(1)
                      .textAlign(TextAlign.Center)
                      .borderColor(Color.Green)
                      .padding({ left: 5, right: 5, top: 3, bottom: 3 })
                      .margin({ left: 10 })
                  }
                }
              }
              //发布时间
              Text(item.niceDate).fontSize(Constants.fs_11).width(Constants.forth_percent).textAlign(TextAlign.End)
            }
            //title
            Text(item.title).fontSize(18).fontColor(Color.Black).margin({ top: 10 }).fontWeight(700)
            //分类
            Text("分类：" + item.superChapterName + " / " + item.chapterName)
              .margin({ top: 10, bottom: 5 })
              .fontSize(Constants.fs_11)
          }
        }
        .onClick(() => {
          router.pushUrl({
            url: 'pages/DetailsWeb',
            params: {
              url: item.link
            }
          })
        })
        .backgroundColor($r('app.color.font_color_white'))
        .margin({ top: 10 })
        .borderRadius(Constants.BORDER_RADIUS)
      }, (item: IArticle, index?: number) => JSON.stringify(item) + index) //赋值一个key标识
    }
    .onScrollIndex((start: number, end: number) => {
      if (this.list.datas && end == this.list.datas.length - 1) {
        this.page++;
        this.reqArticle()
      }
    })
    .width(Constants.Article_LIST_WIDTH)
    .height(Constants.FULL_SIZE)
    .margin({ left: Constants.Article_LIST_MARGIN_LEFT, right: Constants.Article_LIST_MARGIN_RIGHT })
    .backgroundColor($r('app.color.font_color_white'))
    .divider({
      color: '#E2E2E2',
      strokeWidth: Constants.Article_LIST_DIVIDER_STROKE_WIDTH,
      endMargin: Constants.Article_LIST_MARGIN_RIGHT
    })
    .edgeEffect(EdgeEffect.None)
  }

  build() {
    this.showData()
  }
}