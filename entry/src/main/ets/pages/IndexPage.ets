import CommonConstants from '../common/constants/CommonConstant';
import { FontSize } from '../common/constants/Constants';
import router from '@ohos.router';

let msg: string = 'Index页面传递过来的数据'

// class routerParams {
//   src: string
//   constructor(src: string) {
//     this.src = src;
//   }
// }

@Entry
@Component
struct IndexPage {
  private itemList: Array<string>;
  // private src:string = '';

  aboutToAppear() {
    this.itemList = CommonConstants.INDEX_PAGE_LIST_DATA
  }

  // onPageShow(){
  //   this.src = (router.getParams() as routerParams).src
  //   if(this.src != null && this.src.length > 0){
  //     promptAction.showToast({
  //       message: this.src
  //     })
  //   }
  // }

  build() {
    Column() {
      ForEach(this.itemList, (item: string, index: number) => {
        this.item(item, index)
      }, (item: string) => JSON.stringify(item))
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.page_background'))
  }

  @Builder item(content: string, index: number) {
    Row() {
      Text(content)
        .textAlign(TextAlign.Center)
        .width('100%')
        .fontSize(FontSize.SMALL)
    }
    .margin({ top: 16 })
    .borderRadius(12)
    .backgroundColor($r('app.color.start_window_background'))
    .width('80%')
    .height($r('app.float.home_list_item_height'))
    .onClick(() => {
      console.log('跳转--', 'hagan')
      this.toNextPage(index);
    })
  }

  toNextPage(index: number) {
    switch (index) {
      case 0:
        router.pushUrl({ url: 'pages/RankPage' })
        break;
      case 1:
        router.pushUrl({ url: 'pages/ToDoPage' })
        break;
      case 2:
        router.pushUrl({ url: 'pages/SecondPage', params: { src: msg } })
        break;
      case 3:
        router.pushUrl({ url: 'pages/NoticePage'})
        break;
    }
  }
}