import router from '@ohos.router';

@Entry
@Component
struct SecondPage {
  @State message: string = 'Second Page';
  @State src: string = router.getParams()?.['src'];

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
        Text(this.src)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(Color.Gray)
          .margin({ top: 12, bottom: 30 })

        Button('Back')
          .width('60%')
          .onClick(() => {
            // router.enableAlertBeforeBackPage({message:'Message Info '})
            router.back();
            // router.back({
            //   url: 'pages/IndexPage',
            //   params:{ src: "SecondPage返回传递过来的数据" }
            // });
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}