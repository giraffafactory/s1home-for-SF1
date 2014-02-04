@isTest
private class MtHomeTest {
    static testMethod void TestCase01(){
        Datetime testDt = Datetime.now();
        String testTxt = testDt.format('yyyyMMddHHmmss');
        
        //プロファイル取得
        Id profId1 = [SELECT Id FROM Profile WHERE name = 'システム管理者'].Id;

        //リード作成
        Lead ld1 = new Lead();
        ld1.Company            = 'test' + testTxt;
        ld1.Status             = 'test' + testTxt;
        ld1.LastName           = 'test' + testTxt;
        ld1.FirstName          = 'test' + testTxt;
        insert ld1;
        
        //取引先作成
        Account acc1 = new Account();
        acc1.Name = 'test' + testTxt;
        insert acc1;
        
        //取引先責任者作成
        Contact con1 = new Contact();
        con1.AccountId          = acc1.Id;
        con1.LastName           = 'test' + testTxt;
        con1.FirstName          = 'test' + testTxt;
        insert con1;
        
        //ユーザ作成
        User usr1 = new User();
        usr1.LastName           = 'test' + testTxt;
        usr1.FirstName          = 'test' + testTxt;
        usr1.Email              = 'test' + testTxt + '@test.jp';
        usr1.Username           = 'test' + testTxt + '@test.jp';
        usr1.IsActive           = true;
        usr1.CompanyName        = 'test' + testTxt;
        usr1.Street             = '';
        usr1.City               = '';
        usr1.State              = '';
        usr1.Country            = '';
        usr1.PostalCode         = '';
        usr1.ProfileId          = profId1;
        usr1.Alias              = testDt.format('ddHHmmss');
        usr1.CommunityNickname  = 'test' + testTxt + '@test.jp';
        usr1.EmailEncodingKey   = 'ISO-2022-JP';
        usr1.TimeZoneSidKey     = 'Asia/Tokyo';
        usr1.LocaleSidKey       = 'ja_JP';
        usr1.LanguageLocaleKey  = 'ja';
        insert usr1;
        
        //商談作成
        Opportunity opp1 = new Opportunity();
        opp1.Name                 = 'test' + testTxt;
        opp1.CloseDate            = Date.today();
        opp1.StageName            = 'test' + testTxt;
        insert opp1;

        //行動データ作成
        Event ev1 = new Event();
        ev1.Subject          = 'test' + testTxt;
        ev1.OwnerId          = usr1.Id;
        ev1.StartDateTime    = testDt;
        ev1.EndDateTime      = testDt.addHours(1);
        ev1.ActivityDate     = Date.today();
        ev1.ActivityDateTime = testDt;
        ev1.IsAllDayEvent    = false;
        ev1.WhatId           = opp1.Id;
        ev1.WhoId            = con1.Id;
        insert ev1;

        Event ev2 = new Event();
        ev2.Subject          = 'test' + testTxt + 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
        ev2.OwnerId          = usr1.Id;
        ev2.StartDateTime    = testDt.addDays(1);
        ev2.EndDateTime      = testDt.addDays(2);
        ev2.ActivityDate     = Date.today().addDays(1);
        ev2.ActivityDateTime = testDt.addDays(1);
        ev2.IsAllDayEvent    = false;
        ev2.WhatId           = opp1.Id;
        ev2.WhoId            = con1.Id;
        insert ev2;
        
        Event ev3 = new Event();
        ev3.Subject          = null;
        ev3.OwnerId          = usr1.Id;
        ev3.ActivityDate     = Date.today().addDays(2);
        ev3.ActivityDateTime = testDt.addDays(2);
        ev3.IsAllDayEvent    = true;
        ev3.WhatId           = null;
        ev3.WhoId            = null;
        insert ev3;

        Event ev4 = new Event();
        ev4.Subject          = null;
        ev4.OwnerId          = usr1.Id;
        ev4.ActivityDate     = Date.today().addDays(3);
        ev4.ActivityDateTime = testDt.addDays(3);
        ev4.IsAllDayEvent    = true;
        ev4.WhatId           = null;
        ev4.WhoId            = null;
        insert ev4;

        Event ev5 = new Event();
        ev5.Subject          = null;
        ev5.OwnerId          = usr1.Id;
        ev5.ActivityDate     = Date.today().addDays(4);
        ev5.ActivityDateTime = testDt.addDays(4);
        ev5.IsAllDayEvent    = true;
        ev5.WhatId           = null;
        ev5.WhoId            = null;
        insert ev5;

        Event ev6 = new Event();
        ev6.Subject          = null;
        ev6.OwnerId          = usr1.Id;
        ev6.ActivityDate     = Date.today().addDays(4);
        ev6.ActivityDateTime = testDt.addDays(4);
        ev6.IsAllDayEvent    = true;
        ev6.WhatId           = null;
        ev6.WhoId            = null;
        insert ev6;

        Event ev7 = new Event();
        ev7.Subject          = null;
        ev7.OwnerId          = usr1.Id;
        ev7.ActivityDate     = Date.today().addDays(6);
        ev7.ActivityDateTime = testDt.addDays(6);
        ev7.IsAllDayEvent    = true;
        ev7.WhatId           = null;
        ev7.WhoId            = null;
        insert ev7;

        Event ev8 = new Event();
        ev8.Subject          = null;
        ev8.OwnerId          = usr1.Id;
        ev8.ActivityDate     = Date.today().addDays(7);
        ev8.ActivityDateTime = testDt.addDays(7);
        ev8.IsAllDayEvent    = true;
        ev8.WhatId           = null;
        ev8.WhoId            = null;
        insert ev8;
        
        //ToDoデータ作成
        Task tsk1 = new Task();
        tsk1.Subject      = 'test' + testTxt;
        tsk1.OwnerId      = usr1.Id;
        tsk1.ActivityDate = Date.today();
        tsk1.IsRecurrence = false;
        tsk1.WhatId       = opp1.Id;
        tsk1.WhoId        = con1.Id;
        insert tsk1;

        Task tsk2 = new Task();
        tsk2.Subject      = null;
        tsk2.OwnerId      = usr1.Id;
        tsk2.ActivityDate = Date.today();
        tsk2.IsRecurrence = false;
        tsk2.WhatId       = null;
        tsk2.WhoId        = null;
        insert tsk2;

        Task tsk3 = new Task();
        tsk3.Subject      = 'test' + testTxt + 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
        tsk3.OwnerId      = usr1.Id;
        tsk3.ActivityDate = Date.today();
        tsk3.IsRecurrence = false;
        tsk3.WhatId       = null;
        tsk3.WhoId        = null;
        insert tsk3;

        System.runAs(usr1) {
            MtHome cls = new MtHome();
            
            cls.testFlg = true;
            
            cls.getRvData();
            cls.changeEvent();
            cls.changeTask();
            cls.openTask();
            
            Date searchDate = Date.today();
            cls.searchTaskDataList('overdue', searchDate);
            cls.searchTaskDataList('today', searchDate);
            cls.searchTaskDataList('todayAndOverdue', searchDate);
            cls.searchTaskDataList('tomorrow', searchDate);
            cls.searchTaskDataList('next7days', searchDate);
            cls.searchTaskDataList('next7daysAndOverdue', searchDate);
            cls.searchTaskDataList('thisMonth', searchDate);
            cls.searchTaskDataList('allOpen', searchDate);
            
            MtHome.recentryViewedFormat rf = new MtHome.recentryViewedFormat();
            MtHome.eventFormat ef = new MtHome.eventFormat();
            MtHome.taskFormat tf = new MtHome.taskFormat();
        }
    }

    static testMethod void TestCase02(){

        Datetime testDt = Datetime.now();
        String testTxt = testDt.format('yyyyMMddHHmmss');

        //プロファイル取得
        Id profId1 = [SELECT Id FROM Profile WHERE name = 'システム管理者'].Id;

        //リード作成
        Lead ld1 = new Lead();
        ld1.Company            = 'test' + testTxt;
        ld1.Status             = 'test' + testTxt;
        ld1.LastName           = 'test' + testTxt;
        ld1.FirstName          = 'test' + testTxt;
        insert ld1;

        //取引先作成
        Account acc1 = new Account();
        acc1.Name = 'test' + testTxt;
        insert acc1;

        //取引先責任者作成
        Contact con1 = new Contact();
        con1.AccountId          = acc1.Id;
        con1.LastName           = 'test' + testTxt;
        con1.FirstName          = 'test' + testTxt;
        insert con1;

        //ユーザ作成
        User usr1 = new User();
        usr1.LastName           = 'test' + testTxt;
        usr1.FirstName          = 'test' + testTxt;
        usr1.Email              = 'test' + testTxt + '@test.jp';
        usr1.Username           = 'test' + testTxt + '@test.jp';
        usr1.IsActive           = true;
        usr1.CompanyName        = 'test' + testTxt;
        usr1.Street             = '';
        usr1.City               = '';
        usr1.State              = '';
        usr1.Country            = '';
        usr1.PostalCode         = '';
        usr1.ProfileId          = profId1;
        usr1.Alias              = testDt.format('ddHHmmss');
        usr1.CommunityNickname  = 'test' + testTxt + '@test.jp';
        usr1.EmailEncodingKey   = 'ISO-2022-JP';
        usr1.TimeZoneSidKey     = 'Asia/Tokyo';
        usr1.LocaleSidKey       = 'ja_JP';
        usr1.LanguageLocaleKey  = 'ja';
        insert usr1;

        //商談作成
        Opportunity opp1 = new Opportunity();
        opp1.Name                 = 'test' + testTxt;
        opp1.CloseDate            = Date.today();
        opp1.StageName            = 'test' + testTxt;
        insert opp1;
        

        System.runAs(usr1) {
            MtHome cls = new MtHome();
            
            cls.calendarDate = null;
            cls.testFlg = true;
            
            cls.getRvData();
            cls.changeEvent();
            cls.changeTask();
            cls.openTask();
        }
    }
}