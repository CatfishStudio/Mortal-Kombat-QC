class SocialVK {
    public static vkInvite(): void {
        //VK.callMethod("showInviteBox");
    }

    public static vkWallPost(): void {
        if (GameData.Data.progressIndex > 0) {
            let postPers: GameData.IPersonage = GameData.Data.personages[GameData.Data.tournamentListIds[GameData.Data.progressIndex - 1]];
            //VK.api("wall.post", { message: 'Я одержал победу в схватке с ' + postPers.name + ' в игре Street Fighter Cards.\nДрузья присоединяйтесь к игре https://vk.com/app5883565', attachments: 'photo-62618339_456239021' });
        }
    }

    public static vkWallPostWin(): void {
        //VK.api("wall.post", { message: 'Примите поздравления! Вы победили всех соперников в игре Street Fighter Cards.\nДрузья присоединяйтесь к игре https://vk.com/app5883565', attachments: 'photo-62618339_456239022' });
    }

    /**
     * Сохранение данных на сервер VK
     */
    public static vkSaveData(): void {
        let jsonData: string = '{';
        jsonData += '"fi": ' + GameData.Data.fighterIndex.toString() + ',';
        jsonData += '"pi": ' + GameData.Data.progressIndex.toString() + ',';
        jsonData += '"ci": ' + GameData.Data.comixIndex.toString() + ',';
        jsonData += '"list": [' + GameData.Data.tournamentListIds.toString() + ']';
        jsonData += '}';

        //VK.api('storage.set', { key: 'sfc_data', value: jsonData, global: 0 }, SocialVK.onVkDataSet, SocialVK.onVkSetDataError);

        Utilits.Data.debugLog('VK SAVE DATA:', jsonData);
    }

    public static onVkDataSet(response: any): void {
        //Utilits.Data.debugLog('VK SET DATA:', response);
    }

    public static onVkSetDataError(response: any): void {
        //console.error('VK SET DATA ERROR:', response);
    }

    /**
     * Загрузка данных с сервера VK
     */
    public static vkLoadData(onVkDataGet: any): void {
        //VK.api('storage.get', { key: 'sfc_data' }, onVkDataGet, onVkDataGet);
    }

    public static onVkGetDataError(response: any): void {
        console.error('VK GET DATA ERROR:', response);
    }

    public static LoadData(jsonData: string): boolean {
        GameData.Data.comixIndex = 0;
        GameData.Data.progressIndex = -1;
        GameData.Data.fighterIndex = -1;
        GameData.Data.tournamentListIds = [];

        JSON.parse(jsonData, function (key, value) {
            if (key === 'fi') GameData.Data.fighterIndex = value;
            if (key === 'pi') GameData.Data.progressIndex = value;
            if (key === 'ci') GameData.Data.comixIndex = value;
            if (key === 'list') GameData.Data.tournamentListIds = value;
            return value;
        });

        Utilits.Data.debugLog('LOAD DATA COMPLETE',
            GameData.Data.comixIndex.toString() + " " +
            GameData.Data.progressIndex.toString() + " " +
            GameData.Data.fighterIndex.toString() + " " +
            GameData.Data.tournamentListIds.toString());

        if (GameData.Data.fighterIndex > -1){
            return true;
        }else{
            return false;
        }
    }
}