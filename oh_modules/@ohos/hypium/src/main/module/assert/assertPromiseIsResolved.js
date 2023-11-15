/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
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

import isPromiseLike from './isPromiseLike';

function assertPromiseIsResolved(actualPromise) {
    if (!isPromiseLike(actualPromise)) {
        return Promise.reject().then(function () {
        }, function () {
            return {pass: false, message: 'Expected not be called on a promise.'};
        });
    }

    const helper = {};
    return Promise.race([actualPromise, Promise.resolve(helper)]).then(
        function (got) {
            return helper === got ? {
                pass: false,
                message: 'expect resolve, actualValue is isPending'
            }
                : {pass: true, message: 'actualValue is isResolved'};
        },
        function (rej) {
            return {
                pass: false,
                message: 'Expected a promise to be resolved but it was ' +
                    'rejected with ' + JSON.stringify(rej) + '.'
            };
        }
    );
}

export default assertPromiseIsResolved;