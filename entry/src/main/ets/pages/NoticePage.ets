import notification from '@ohos.notificationManager';
import image from '@ohos.multimedia.image';
import wantAgent from '@ohos.wantAgent';
import reminderAgentManager from '@ohos.reminderAgentManager';
import notificationManager from '@ohos.notificationManager';

@Entry
@Component
struct NoticePage {
  build() {
    Row() {
      Column() {
        Button('发送普通通知')
          .margin({ top: 30 })
          .onClick(() => this._sendNormalNotice());
        Button('发送图片通知')
          .margin({ top: 30 })
          .onClick(() => this._sendPicNotice());
        Button('发送进度通知')
          .margin({ top: 30 })
          .onClick(() => this._sendDownloadNotice());
        Divider().margin({ top: 30 })
        Button('添加提醒')
          .margin({ top: 30 })
          .onClick(() => this._addReminder());
      }
      .width('100%')
    }
    .height('100%')
  }

  _sendNormalNotice() {
    console.log('notice', '发送普通通知');
    let notificationRequest: notification.NotificationRequest = {
      id: 1,
      slotType: notification.SlotType.SERVICE_INFORMATION,
      content: {
        contentType: notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: '通知内容',
          text: '通知内容详情',
          additionalText: '通知附加内容',
        },
      },
      deliveryTime: new Date().getTime(),
      showDeliveryTime: true
    }
    notification.publish(notificationRequest).then(() => {
      console.info('publish success')
      setTimeout(() => {
        notification.cancel(1);
      }, 5000) // 5s之后消失
    }).catch((error) => {
      console.error(`publish failed, dcode:${error.code}, message: ${error.message}`)
    })

  }

  async _sendPicNotice() {
    // 将资源图片转化为PixelMap
    let resourceManager = getContext(this).resourceManager;
    let imageArray = await resourceManager.getMediaContent($r('app.media.icon').id);
    let imageResource = image.createImageSource(imageArray.buffer);
    let pixelMap = await imageResource.createPixelMap();

    let notificationRequest: notification.NotificationRequest = {
      id: 2,
      content: {
        contentType: notification.ContentType.NOTIFICATION_CONTENT_PICTURE,
        picture: {
          title: '好物热销中',
          text: '展开查看详情',
          expandedTitle: '今日热门推荐',
          briefText: '这里一定有您惊喜的',
          picture: pixelMap,
        }
      }
    }
    notification.publish(notificationRequest).then(() => {
      console.info('publish success')
    }).catch((error) => {
      console.error(`publish failed, dcode:${error.code}, message: ${error.message}`)
    })
  }

  async _sendDownloadNotice() {
    // 点击通知返回到应用
    var wantAgentInfo = {
      wants: [
        {
          bundleName: "com.hagan.myapplication",
          abilityName: "EntryAbility"
        }
      ],
      operationType: wantAgent.OperationType.START_ABILITY,
      requestCode: 100
    }
    let wantAgentObj = await wantAgent.getWantAgent(wantAgentInfo)
    let template = {
      name: 'downloadTemplate',
      data: {
        progressValue: 60,
        progressMaxValue: 100
      }
    }
    let notificationRequest = {
      id: 3,
      content: {
        contentType: notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: '文件下载： music.mp4',
          text: 'senTemplate',
          additionalText: '60%'
        }
      },
      template: template,
      wantAgent: wantAgentObj // 点击通知返回到应用
    }
    notification.publish(notificationRequest).then(() => {
      console.info('publish success')
    }).catch((error) => {
      console.error(`publish failed, dcode:${error.code}, message: ${error.message}`)
    })
  }

  _addReminder() {
    console.log('notice', '添加闹钟提醒');
    let targetReminderAgent: reminderAgentManager.ReminderRequestAlarm = {
      reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_ALARM, // 闹钟类型
      hour: 21,
      minute: 31,
      daysOfWeek: [],
      title: '',
      ringDuration: 5,
      snoozeTimes: 0,
      timeInterval: 0,
      actionButton: [
        {
          title: '关闭',
          type: reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_CLOSE
        },
        {
          title: '稍后提醒',
          type: reminderAgentManager.ActionButtonType.ACTION_BUTTON_TYPE_SNOOZE
        },
      ],
      notificationId: 1,
      expiredContent: 'this reminder has expired',
      slotType: notificationManager.SlotType.SOCIAL_COMMUNICATION
    }
    reminderAgentManager.publishReminder(targetReminderAgent).then(res => {
      console.info('Success in publishing reminder.')
      let reminderId: number = res; // 发布提醒ID
    }).catch(err => {
      console.error(`Failed to publish reminder: Code: ${err.code}, message:${err.message}`);
    })
  }
}


