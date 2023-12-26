import CommonConstants from '../common/constants/CommonConstant';
import { FontSize } from '../common/constants/Constants';

@Entry
@Component
struct IndexPage {
  private itemList: Array<string>;

  aboutToAppear() {
    this.itemList = CommonConstants.INDEX_PAGE_LIST_DATA
  }

  build() {
    Column() {
      ForEach(this.itemList, (item: string) => {
        this.item(item)
      }, (item: string) => JSON.stringify(item))
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.page_background'))
  }

  @Builder item(content: string) {
    Row(){
      Text(content)
        .textAlign(TextAlign.Center)
        .width('100%')
        .fontSize(FontSize.SMALL)
    }
    .margin({top:16})
    .borderRadius(12)
    .backgroundColor($r('app.color.start_window_background'))
    .width('80%')
    .height($r('app.float.home_list_item_height'))
    .onClick(() => {
    })
  }
}