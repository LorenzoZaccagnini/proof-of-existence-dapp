import UploadComponent from "./components/UploadComponent";

import { drizzleConnect } from "drizzle-react";

const mapStateToProps = state => {
  return {
    accounts: state.accounts,
    Poe: state.contracts.Poe,
    drizzleStatus: state.drizzleStatus,
  };
};

const LoadingContainer = drizzleConnect(UploadComponent, mapStateToProps);

export default LoadingContainer;
