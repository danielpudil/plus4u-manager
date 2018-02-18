if (module.hot) {
  require("react-hot-loader/patch");
}

import React from "react";
import ReactDOM from "react-dom";
import { AppContainer } from "react-hot-loader";

import Spa from "./core/spa.js";

import "./index.less";

// store the target element selector to use it again during hot update
let _targetElementId;

export function render(targetElementId) {
  _targetElementId = targetElementId;

  if (module.hot) {
    dynamicRender(Spa, targetElementId);
  } else {
    ReactDOM.render(<Spa />, document.getElementById(targetElementId));
  }
}

function dynamicRender(Component, targetElementId = _targetElementId) {
  ReactDOM.render(
    <AppContainer>
      <Component />
    </AppContainer>,
    document.getElementById(targetElementId)
  );
}

if (module.hot) {
  module.hot.accept("./core/spa", () => {
    dynamicRender(require("./core/spa").default);
  });
}
