import { Square } from '../component/SquareComponent';
import { Home } from '../component/HomeComponent';
import { Me } from '../component/MeComponent';
import { BottomTabsList } from '../model/BottomTabsModel';
import { Constants } from '../utils/Constants';

@Entry
@Component
struct Index {
  @Provide data: string[] = ['Home', 'Square', 'Me']
  @State @Watch('onIndexChange') bottomTabIndex: number = 0;
  private controller: TabsController = new TabsController()

  @Builder TabBuild(index: number, name: string) {
    Column() {
      Image(this.bottomTabIndex === index ? BottomTabsList[index].iconSelected : BottomTabsList[index].icon)
        .width(Constants.ICON_SIZE)
        .height(Constants.ICON_SIZE)
        .objectFit(ImageFit.Contain)

      Text(BottomTabsList[index].text)
        .fontSize($r('app.float.bottom_font_size'))
        .opacity(Constants.OPACITY)
        .fontColor(this.bottomTabIndex === index ?
        $r('app.color.bottom_tabs_font_color_selected') : $r('app.color.bottom_tabs_font_color'))
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FFF')
  }

  //切换改变的监听
  onIndexChange() {
    this.controller.changeIndex(this.bottomTabIndex);
  }

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.End, justifyContent: FlexAlign.End }) {
      Tabs({ barPosition: BarPosition.End, index: 0, controller: this.controller }) {
        ForEach(this.data, (item, index) => {
          TabContent() {
            if (index === 0) {
              Home()
            } else if (index === 1) {
              Square()
            } else if (index === 2) {
              Me()
            }
          }.tabBar(this.TabBuild(index, item))
        })
      }
      .width(Constants.FULL_PERCENT)
      .height(Constants.FULL_PERCENT)
      .vertical(false)
      .scrollable(false)
      .barHeight(Constants.BAR_HEIGHT)
      .onChange((index: number) => {
        this.bottomTabIndex = index;
      })
    }
  }
}
