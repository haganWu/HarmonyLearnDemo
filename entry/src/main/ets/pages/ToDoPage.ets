import CommonConstants from '../common/constants/CommonConstant';
import { ToDoItem } from '../view/todopage/ToDoItem'
import ToDoListDataModel from '../viewmodel/ToDoListDataModel';

@Entry
@Component
struct ToDoPage {
  private totalTasks: Array<string> = []

  aboutToAppear(){
    this.totalTasks = ToDoListDataModel.getData();
  }
  build() {
    Column() {
      Text($r('app.string.page_title'))
        .fontSize($r('app.float.title_font_size'))
        .fontWeight(FontWeight.Bold)
        .lineHeight($r('app.float.title_font_height'))
        .width(CommonConstants.TITLE_WIDTH)
        .margin({
          top: $r('app.float.title_margin_top'),
          bottom: $r('app.float.title_margin_bottom')
        })
        .textAlign(TextAlign.Start)

     ForEach(this.totalTasks, (item:string ) => {
      ToDoItem({content: item})
     },(item:string) => JSON.stringify(item))

    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.page_background'))
  }
}