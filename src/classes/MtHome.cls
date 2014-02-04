public class MtHome {

    private Id usrId { get; set; }
    
//    public List<recentryViewedFormat> rvData { get; set; }
    public List<List<eventFormat>> evData { get; set; }
    public List<taskFormat> tskData { get; set; }

    public String calendarDate { get; set; }
    public String taskSelectFlg { get; set; }
    public List<SelectOption> taskSelectOptions { get; set; }

    public Boolean errflg { get; private set; }           // true：エラー
    public String message { get; private set; }           // エラー時等のメッセージ表示用

    public Boolean tskOpenFlg { get; set; }               // true：全て表示
    public Boolean tskMoreLinkFlg { get; set; }           // true：「さらに表示... ≫」リンクを表示
    public Integer tskDispNum { get; set; }               // ToDoの初期表示数

    public Boolean testFlg { get; set; }                  // テストコード用フラグ


    //コンストラクタ
    public MtHome() {
        usrId = UserInfo.getUserId();
System.debug('debug : MtTestHome usrId : ' + usrId);

//        //最近使ったデータ取得
//        rvData = getRvData();
        
        calendarDate = Date.today().year() + '/' + Date.today().month() + '/' + Date.today().day();

        //行動初期表示
        evData = new List<List<eventFormat>>();
        evData = getEvDataList();
        
        //ToDo表示条件選択リスト生成
        taskSelectOptions = getTaskSelectList();
        
        //ToDoの初期表示数セット
        tskDispNum = 15;
        
        //ToDo初期表示
        tskOpenFlg = false;
        tskData = new List<taskFormat>();
        tskData = getTskDataList(tskOpenFlg);
    }


    //最近使ったデータ取得
    public List<recentryViewedFormat> getRvData() {
        List<recentryViewedFormat> rvData = new List<recentryViewedFormat>();
        
        if(testFlg == false || testFlg == null) {

            List<RecentlyViewed> tmpList = [ SELECT
                                                 Id
                                                 ,Name
                                                 ,Type
                                                 ,LastViewedDate
                                                 ,IsActive
                                             FROM
                                                 RecentlyViewed
                                             ORDER BY
                                                 LastViewedDate DESC
                                             LIMIT 10
                                           ];

            if(tmpList.size() == 0) {
                rvData = null;
            } else {
                rvData = new List<recentryViewedFormat>();
                rvData = setRecentryViewedFormat(tmpList);
            }
        
        } else {
            rvData = null;
        }
        
        return rvData;
    }


    //最近使ったデータを表示用に成型
    public List<recentryViewedFormat> setRecentryViewedFormat(List<RecentlyViewed> rvList) {

        List<recentryViewedFormat> ret = new List<recentryViewedFormat>();
        recentryViewedFormat tmp       = new recentryViewedFormat();
        if(rvList != null && rvList.size() > 0) {
            for(RecentlyViewed rv : rvList) {
                tmp = new recentryViewedFormat();
                tmp.rvId   = rv.Id;
                tmp.rvName = rv.Name.abbreviate(18);
                tmp.rvType = rv.Type;

                ret.add(tmp);
            }
        }
        
        return ret;
    }


    //行動　日付指定
    public PageReference changeEvent() {

        try {
            evData = new List<List<eventFormat>>();
            evData = getEvDataList();
            if(evData.size() == 0) {
                evData = null;
            }
        } catch(Exception ex) {
            errflg = true;
            message = '予期せぬエラーが発生しました。管理者にご連絡ください。（' + ex + '）';
        }

        return null;
    }


    //行動データ取得
    public  List<List<eventFormat>> getEvDataList() {

        List<List<eventFormat>> dataList = new List<List<eventFormat>>();
    
        Date searchDateFrom;
        Date searchDateTo;
        if(calendarDate != null && calendarDate != '') {
            searchDateFrom = Date.parse(calendarDate);
            searchDateTo = searchDateFrom.addDays(7);
            
        } else {
            searchDateFrom = Date.today();
            searchDateTo = searchDateFrom.addDays(7);
        }
        
        List<Event> tmpData = new List<Event>();
        List<eventFormat> tmpDataFmt = new List<eventFormat>();
        
        for(Integer i = 0; i < 7; i++) {
            //各日の行動取得
            tmpData = new List<Event>();
            tmpData = searchEventDataList(searchDateFrom.addDays(i));

            //行動を表示用に成型
            tmpDataFmt = new List<eventFormat>();
            tmpDataFmt = setEventFormat(tmpData, searchDateFrom.addDays(i));

            if(tmpDataFmt != null) {
                dataList.add(tmpDataFmt);
            }
        }

        if(dataList.size() == 0) {
            dataList = null;
        }

        return dataList;
    }


    //行動データ取得
    public List<Event> searchEventDataList(Date prmDate) {
    
        Date prmDateTo = prmDate.addDays(1);
        
        Datetime prmDateTime = Datetime.newInstance(prmDate, Time.newInstance(0,0,0,0));
        Datetime prmDateTimeTo = Datetime.newInstance(prmDateTo, Time.newInstance(0,0,0,0));
    
        String soql = '';
        soql += ' SELECT ';
        soql += '     Id ';
        soql += '     ,Subject ';
        soql += '     ,OwnerId ';
        soql += '     ,StartDateTime ';
        soql += '     ,EndDateTime ';
        soql += '     ,ActivityDate ';
        soql += '     ,ActivityDateTime ';
        soql += '     ,IsAllDayEvent ';
        soql += '     ,WhatId ';
        soql += '     ,What.Name ';
        soql += '     ,WhoId ';
        soql += '     ,Who.Name ';
        soql += ' FROM ';
        soql += '     Event ';
        soql += ' WHERE ';
        soql += '     OwnerId = :usrId ';
        soql += '     AND IsRecurrence = false ';
        soql += '     AND ( ';
        soql += '             (StartDateTime >= :prmDateTime AND StartDateTime < :prmDateTimeTo) ';
        soql += '             OR (EndDateTime >= :prmDateTime AND EndDateTime < :prmDateTimeTo) ';
        soql += '             OR (StartDateTime <= :prmDateTime AND EndDateTime >= :prmDateTimeTo) ';
        soql += '         ) ';
        soql += '     ORDER BY ';
        soql += '         IsAllDayEvent DESC';
        soql += '         , StartDateTime ';

        List<Event> ret = Database.query(soql);

        if(ret.size() == 0) {
            ret = null;
        }
        
        return ret;
    }


    //行動データを表示用に成型
    public List<eventFormat> setEventFormat(List<Event> evList, Date prmDate) {

        List<eventFormat> ret = new List<eventFormat>();
        eventFormat tmp       = new eventFormat();
        if(evList != null && evList.size() > 0) {
            for(Event ev : evList) {
                tmp = new eventFormat();
                tmp.efId            = ev.Id;
                if(ev.Subject != null) {
                    tmp.efSubject       = ev.Subject.abbreviate(23);
                } else {
                    tmp.efSubject       = ev.Subject;
                }
                tmp.efStartDateTime = ev.StartDateTime;
                tmp.efEndDateTime   = ev.EndDateTime;
                tmp.efDate          = prmDate.year() + '/' + prmDate.month() + '/' + prmDate.day();
                
                if(ev.IsAllDayEvent == true) {
                    tmp.efAllDayStr = '終日';
                
                } else {
                    tmp.efAllDayStr = '';

                    if(ev.StartDateTime.date() < prmDate) {
                        tmp.efStartTime = '0:00';
                        tmp.efContinueStr = 'の続き';
                    } else {
                        String padZeroStart = '';
                        if(ev.StartDateTime.time().minute() < 10) {
                            padZeroStart = '0';
                        }
                        tmp.efStartTime = ev.StartDateTime.time().hour() + ':' + padZeroStart + ev.StartDateTime.time().minute();
                        tmp.efContinueStr = '';
                    }
                    if(ev.EndDateTime.date() > prmDate) {
                        tmp.efEndTime   = '0:00';
                    } else {
                        String padZeroEnd = '';
                        if(ev.EndDateTime.time().minute() < 10) {
                            padZeroEnd = '0';
                        }
                        tmp.efEndTime   = ev.EndDateTime.time().hour() + ':' + padZeroEnd + ev.EndDateTime.time().minute();
                    }
                }
                
                tmp.efWhatWhoId = '';
                if(ev.WhoId != null) {
                    tmp.efWhatWhoId = ev.WhoId;
                } else if(ev.WhatId != null) {
                    tmp.efWhatWhoId = ev.WhatId;
                }
                tmp.efWhatWhoName = '';
                if(ev.Who.Name != null) {
                    tmp.efWhatWhoName = ev.Who.Name.abbreviate(23);
                } else if(ev.What.Name != null) {
                    tmp.efWhatWhoName = ev.What.Name.abbreviate(23);
                }

                tmp.efWeekDay = getYobi(prmDate) + '曜日';
                if(prmDate == Date.today()) {
                    tmp.efWeekDay = '今日';
                }

                ret.add(tmp);
            }
        }
        if(ret.size() == 0) {
            ret = null;
        }
        
        return ret;
    }


    //ToDo表示条件選択リスト生成
    public List<SelectOption> getTaskSelectList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('overdue', '期限切れ'));
        options.add(new SelectOption('today', '今日'));
        options.add(new SelectOption('todayAndOverdue', '今日＋期限切れ'));
        options.add(new SelectOption('tomorrow', '明日'));
        options.add(new SelectOption('next7days', '７日先まで'));
        options.add(new SelectOption('next7daysAndOverdue', '７日先まで＋期限切れ'));
        options.add(new SelectOption('thisMonth', '今月'));
        options.add(new SelectOption('allOpen', '全ての未完了'));
        
        taskSelectFlg = 'todayAndOverdue';
        
        return options;
    }


    //ToDo表示条件変更
    public PageReference changeTask() {

        try {

            tskData = new List<taskFormat>();
            tskData = getTskDataList(tskOpenFlg);
            if(tskData.size() == 0) {
                tskData = null;
            }

        } catch(Exception ex) {

            errflg = true;
            message = '予期せぬエラーが発生しました。管理者にご連絡ください。（' + ex + '）';
        }

        return null;
    }


    //ToDo全件表示
    public PageReference openTask() {

        try {

            tskOpenFlg = true;

            tskData = new List<taskFormat>();
            tskData = getTskDataList(tskOpenFlg);
            if(tskData.size() == 0) {
                tskData = null;
            }

        } catch(Exception ex) {
            errflg = true;
            message = '予期せぬエラーが発生しました。管理者にご連絡ください。（' + ex + '）';
        }

        return null;
    }



    //ToDoデータ取得
    public  List<taskFormat> getTskDataList(Boolean prmOpenFlg) {
    
        tskData = new List<taskFormat>();
        
        Date searchDate;
        searchDate = Date.today();
        
        List<Task> tmpData = new List<Task>();
        tmpData = searchTaskDataList(taskSelectFlg, searchDate);

        //ToDoを表示用に成型
        List<taskFormat> tmpDataFmt = new List<taskFormat>();
        tmpDataFmt = setTaskFormat(tmpData);
        
        if(tmpDataFmt != null && tmpDataFmt.size() > tskDispNum) {

            if(prmOpenFlg != true) {
                //ToDo「さらに表示」リンク表示フラグ
                tskMoreLinkFlg = true;
                
                for(Integer i = 0; i < tskDispNum; i++) {

                    tskData.add(tmpDataFmt[i]);
                }
            } else {
                tskMoreLinkFlg = false;
                tskData = tmpDataFmt;
            }
        } else {
            tskMoreLinkFlg = false;
            tskData = tmpDataFmt;
        }

        return tskData;
    }


    //ToDoデータ取得
    public List<Task> searchTaskDataList(String flg, Date prmDate) {
    
        String soql = '';
        soql += ' SELECT ';
        soql += '     Id ';
        soql += '     ,Subject ';
        soql += '     ,OwnerId ';
        soql += '     ,ActivityDate ';
        soql += '     ,IsClosed ';
        soql += '     ,IsRecurrence ';
        soql += '     ,WhatId ';
        soql += '     ,What.Name ';
        soql += '     ,WhoId ';
        soql += '     ,Who.Name ';
        soql += ' FROM ';
        soql += '     Task ';
        soql += ' WHERE ';
        soql += '     OwnerId = :usrId ';
        soql += '     AND IsRecurrence = false ';
        soql += '     AND IsClosed = false ';
        
        List<Date> fromToDate = new List<Date>();
        Date fromDate;
        Date toDate;
        
        if(flg == 'overdue') {
            fromToDate = getTaskFromToDate(prmDate, 'today');
            fromDate = fromToDate[0];

            soql += '     AND (ActivityDate < :fromDate ';
            soql += '          OR ActivityDate = null ) ';
        
        } else if(flg == 'today') {
            fromToDate = getTaskFromToDate(prmDate, 'today');
            fromDate = fromToDate[0];
            toDate = fromToDate[1];

            soql += '     AND ActivityDate >= :fromDate ';
            soql += '     AND ActivityDate < :toDate ';
        
        } else if(flg == 'tomorrow') {
            fromToDate = getTaskFromToDate(prmDate, 'tomorrow');
            fromDate = fromToDate[0];
            toDate = fromToDate[1];

            soql += '     AND ActivityDate >= :fromDate ';
            soql += '     AND ActivityDate < :toDate ';
        
        } else if(flg == 'next7days') {
            fromToDate = getTaskFromToDate(prmDate, 'next7days');
            fromDate = fromToDate[0];
            toDate = fromToDate[1];

            soql += '     AND ActivityDate >= :fromDate ';
            soql += '     AND ActivityDate < :toDate ';
        
        } else if(flg == 'next7daysAndOverdue') {
            fromToDate = getTaskFromToDate(prmDate, 'next7days');
            fromDate = fromToDate[0];
            toDate = fromToDate[1];

            soql += '     AND (ActivityDate < :toDate ';
            soql += '          OR ActivityDate = null) ';
        
        } else if(flg == 'thisMonth') {
            fromToDate = getTaskFromToDate(prmDate, 'thisMonth');
            fromDate = fromToDate[0];
            toDate = fromToDate[1];

            soql += '     AND ActivityDate >= :fromDate ';
            soql += '     AND ActivityDate < :toDate ';
        
        } else if(flg == 'allOpen') {
            soql += '';
        
        } else {
            fromToDate = getTaskFromToDate(prmDate, 'today');
            toDate = fromToDate[1];

            soql += '     AND (ActivityDate < :toDate ';
            soql += '          OR ActivityDate = null ) ';
        }

        soql += ' ORDER BY ';
        soql += '     ActivityDate ';
        
        List<Task> ret = Database.query(soql);

        if(ret.size() == 0) {
            ret = null;
        }
        
        return ret;
    }


    //ToDoデータを表示用に成型
    public List<taskFormat> setTaskFormat(List<Task> prmTskList) {

        List<taskFormat> ret = new List<taskFormat>();
        taskFormat tmp       = new taskFormat();
        if(prmTskList != null && prmTskList.size() > 0) {
            for(Task tsk : prmTskList) {

                tmp = new taskFormat();
                tmp.tskId           = tsk.Id;
                if(tsk.Subject != null) {
                    tmp.tskSubject      = tsk.Subject.abbreviate(11);
                } else {
                    tmp.tskSubject      = tsk.Subject;
                }
                tmp.tskOwnerId      = tsk.OwnerId;
                tmp.tskActivityDate = tsk.ActivityDate;
                tmp.tskIsClosed     = tsk.IsClosed;
                tmp.tskIsRecurrence = tsk.IsRecurrence;
                tmp.tskWhatId       = tsk.WhatId;
                if(tsk.What.Name != null) {
                    tmp.tskWhatName     = tsk.What.Name.abbreviate(11);
                } else {
                    tmp.tskWhatName     = tsk.What.Name;
                }
                tmp.tskWhoId        = tsk.WhoId;
                if(tsk.Who.Name != null) {
                    tmp.tskWhoName      = tsk.Who.Name.abbreviate(10);
                } else {
                    tmp.tskWhoName      = tsk.Who.Name;
                }

                ret.add(tmp);
            }
        }
        if(ret.size() == 0) {
            ret = null;
        }
        
        return ret;
    }


    //ToDo取得範囲日付
    public List<Date> getTaskFromToDate(Date prmDate, String prmFlg) {

        //prmFlg: today, default
        Integer prmFrom = 0;
        Integer prmCnt = 0;
        if(prmFlg == 'tomorrow') {
            prmFrom = 1;
            prmCnt = 0;
        } else if(prmFlg == 'next7days') {
            prmFrom = 0;
            prmCnt = 6;
        } else if(prmFlg == 'thisMonth') {
            prmFrom = (prmDate.day() - 1) * -1;
            prmCnt = Date.daysInMonth(prmDate.year(), prmDate.month());
        }

        prmDate = prmDate.addDays(prmFrom);
        Date prmDateTo = prmDate.addDays(prmCnt + 1);
            
        Datetime prmDateTime = Datetime.newInstance(prmDate, Time.newInstance(0,0,0,0));
        Datetime prmDateTimeTo = Datetime.newInstance(prmDateTo, Time.newInstance(0,0,0,0));

        Date prmRetDate = prmDateTime.date();
        Date prmRetDateTo = prmDateTimeTo.date();
        
        List<Date> ret = new List<Date>();
        ret.add(prmRetDate);
        ret.add(prmRetDateTo);
        
        return ret;
    }


    public String getYobi(Date vdDate){
        datetime tDate = datetime.newInstance(vdDate.year(), vdDate.month(), vdDate.day());
        String week = tDate.format('E');
        
        if(week == 'Sun'){
            return '日';
        }else if(week == 'Mon'){
            return '月';
        }else if(week == 'Tue'){
            return '火';
        }else if(week == 'Wed'){
            return '水';
        }else if(week == 'Thu'){
            return '木';
        }else if(week == 'Fri'){
            return '金';
        }else if(week == 'Sat'){
            return '土';
        }
            return null;
    }




    public class recentryViewedFormat {
        public String rvId             { get; set; }
        public String rvName           { get; set; }
        public String rvType           { get; set; }

        public recentryViewedFormat() {
        }
    }


    public class eventFormat {
        public String efId              { get; set; }
        public String efSubject         { get; set; }
        public Datetime efStartDateTime { get; set; }
        public Datetime efEndDateTime   { get; set; }
        public String efDate            { get; set; }
        public String efStartTime       { get; set; }
        public String efEndTime         { get; set; }
        public String efActivityDate    { get; set; }
        public String efContinueStr     { get; set; }
        public String efWeekDay         { get; set; }
        public String efAllDayStr       { get; set; }
        public String efWhatWhoId       { get; set; }
        public String efWhatWhoName     { get; set; }

        public eventFormat() {
        }
    }


    public class taskFormat {
        public String tskId             { get; set; }
        public String tskSubject        { get; set; }
        public String tskOwnerId        { get; set; }
        public Date tskActivityDate     { get; set; }
        public Boolean tskIsClosed      { get; set; }
        public Boolean tskIsRecurrence  { get; set; }
        public String tskWhatId         { get; set; }
        public String tskWhatName       { get; set; }
        public String tskWhoId          { get; set; }
        public String tskWhoName        { get; set; }
        
        public taskFormat() {
        }
    }
}