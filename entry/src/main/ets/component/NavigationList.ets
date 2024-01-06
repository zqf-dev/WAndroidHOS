import { IState } from '../model/IStatus';
import { INav, INavChildren, ITree, ITreeChildren } from '../model/ITreeBean';
import { getNav } from '../request/SquareReq';
import { Constants } from '../utils/Constants';

@Component
export struct NavigationList {
  @State status: IState = IState.Loading
  scroll: Scroller = new Scroller()
  @State mListNav: INav[] = new Array()

  category() {
    console.log("Tag");
    getNav().then((data: INav[]) => {
      this.mListNav = [...data];
      this.status = IState.Success;
    }).catch((err: string | Resource) => {
      console.log('getNav failed', err);
    })
  }

  aboutToAppear() {
    this.category();
  }

  @Builder LoadingLayout() {
    Text('加载中...').width('100%').height('100%').textAlign(TextAlign.Center)
  }

  @Builder showNav() {
    Scroll(this.scroll) {
      Column() {
        ForEach(this.mListNav, (item: INav, index) => {
          Column() {
            Text(item.name)
              .width(Constants.FULL_PERCENT)
              .textAlign(TextAlign.Start)
              .margin(10)
              .fontSize(20)
            Flex({
              wrap: FlexWrap.Wrap
            }) {
              ForEach(item.articles, (itemChild: INavChildren, item) => {
                Button(itemChild.title)
                  .backgroundColor('#EEEEEE')
                  .borderRadius(30)
                  .fontColor(Color.Black)
                  .margin(5)
                  .padding({ left: 8, right: 8 })
              }, (item: ITreeChildren, index?: number) => JSON.stringify(item) + index)
            }
          }.padding({ left: 10, right: 10 })
        }, (item: ITree, index?: number) => JSON.stringify(item) + index)
      }
      .width(Constants.FULL_PERCENT)
    }
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Spring)
  }

  build() {
    if (this.status === IState.Loading) {
      this.LoadingLayout()
    } else {
      this.showNav()
    }
  }
}