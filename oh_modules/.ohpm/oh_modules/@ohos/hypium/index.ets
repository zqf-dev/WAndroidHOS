/*
 * Copyright (c) 2021-2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Core from './src/main/core';
import {DEFAULT, TestType, Size, Level} from './src/main/Constant';
import DataDriver from './src/main/module/config/DataDriver';
import ExpectExtend from './src/main/module/assert/ExpectExtend';
import OhReport from './src/main/module/report/OhReport';
import SysTestKit from './src/main/module/kit/SysTestKit';
import {describe, beforeAll, beforeEach, afterEach, afterAll, it, expect} from './src/main/interface';
import {MockKit, when} from './src/main/module/mock/MockKit';
import ArgumentMatchers from './src/main/module/mock/ArgumentMatchers';

class Hypium {
    static setData(data) {
        const core = Core.getInstance();
        const dataDriver = new DataDriver({data});
        core.addService('dataDriver', dataDriver);
    }

    static setTimeConfig(systemTime) {
        SysTestKit.systemTime = systemTime;
    }

    static hypiumTest(abilityDelegator, abilityDelegatorArguments, testsuite) {
        const core = Core.getInstance();
        const expectExtend = new ExpectExtend({
            'id': 'extend'
        });
        core.addService('expect', expectExtend);
        const ohReport = new OhReport({
            'delegator': abilityDelegator,
            'abilityDelegatorArguments': abilityDelegatorArguments
        });
        SysTestKit.delegator = abilityDelegator;
        core.addService('report', ohReport);
        core.init();
        core.subscribeEvent('spec', ohReport);
        core.subscribeEvent('suite', ohReport);
        core.subscribeEvent('task', ohReport);
        const configService = core.getDefaultService('config');

        let testParameters = {};
        if (abilityDelegatorArguments !== null) {
            testParameters = configService.translateParams(abilityDelegatorArguments.parameters);
        }
        console.info('parameters:' + JSON.stringify(testParameters));
        configService.setConfig(testParameters);

        testsuite();
        if (Object.prototype.hasOwnProperty.call(globalThis, 'setupUiTestEnvironment')) {
            globalThis.setupUiTestEnvironment().then(() => {
                console.info('UiTestKit::after run uitest setup, start run testcases');
                core.execute(abilityDelegator);
            }).catch((error) => {
                console.error('UiTestKit:: call setupUiTestEnvironment failure:' + error);
                core.execute(abilityDelegator);
            });
        } else {
            console.info('UiTestKit:: no need to setup uitest, start run testcases');
            core.execute(abilityDelegator);
        }
    }
}

export {
    Hypium,
    Core,
    DEFAULT,
    TestType,
    Size,
    Level,
    DataDriver,
    ExpectExtend,
    OhReport,
    SysTestKit,
    describe, beforeAll, beforeEach, afterEach, afterAll, it, expect,
    MockKit, when,
    ArgumentMatchers
};