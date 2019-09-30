#!/bin/bash

function printHelp() {
  echo "Usage: "
  echo "	./network.sh generate"
  echo "	./network.sh up"
  echo "	./network.sh down"
  echo "	./network.sh start"
  echo "	./network.sh init"  
}

function generateCerts() {
  echo
  echo "#################################################################"
  echo "#######        Generating cryptographic material       ##########"
  echo "#################################################################"

  cryptogen generate --config=./crypto-config.yaml

  mkdir channel-artifacts
  echo
  echo "##########################################################"
  echo "#########  Generating Orderer Genesis block ##############"
  echo "##########################################################"
  configtxgen -profile FourOrgsGenesis -channelID insurance-sys-channel -outputBlock $CLIPATH/genesis.block

  echo
  echo "#################################################################"
  echo "### Generating channel configuration transaction 'channel.tx' ###"
  echo "#################################################################"
  configtxgen -profile FourOrgsChannel -outputCreateChannelTx $CLIPATH/channel.tx -channelID $CHANNEL_NAME

  echo
  echo "#################################################################"
  echo "####### Generating anchor peer update for InsuranceOrg ##########"
  echo "#################################################################"
  configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/InsuranceOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg InsuranceOrgMSP

  echo
  echo "#################################################################"
  echo "#######    Generating anchor peer update for ShopOrg   ##########"
  echo "#################################################################"
  configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/ShopOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg ShopOrgMSP

  echo
  echo "##################################################################"
  echo "####### Generating anchor peer update for RepairShopOrg ##########"
  echo "##################################################################"
  configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/RepairShopOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg RepairShopOrgMSP

  echo
  echo "##################################################################"
  echo "#######   Generating anchor peer update for PoliceOrg   ##########"
  echo "##################################################################"
  configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/PoliceOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg PoliceOrgMSP
}


function networkUp() {
  mkdir -p $INSURANCE_CA_PATH/ca $INSURANCE_CA_PATH/tls
  mkdir -p $POLICE_CA_PATH/ca $POLICE_CA_PATH/tls
  mkdir -p $REPAIRSHOP_CA_PATH/ca $REPAIRSHOP_CA_PATH/tls
  mkdir -p $SHOP_CA_PATH/ca $SHOP_CA_PATH/tls

  cp $CRYPTO_PEER/insurance-org/ca/* $INSURANCE_CA_PATH/ca
  cp $CRYPTO_PEER/insurance-org/tlsca/* $INSURANCE_CA_PATH/tls
  mv $INSURANCE_CA_PATH/ca/*_sk $INSURANCE_CA_PATH/ca/key.pem
  mv $INSURANCE_CA_PATH/ca/*-cert.pem $INSURANCE_CA_PATH/ca/cert.pem
  mv $INSURANCE_CA_PATH/tls/*_sk $INSURANCE_CA_PATH/tls/key.pem
  mv $INSURANCE_CA_PATH/tls/*-cert.pem $INSURANCE_CA_PATH/tls/cert.pem

  cp $CRYPTO_PEER/police-org/ca/* $POLICE_CA_PATH/ca
  cp $CRYPTO_PEER/police-org/tlsca/* $POLICE_CA_PATH/tls
  mv $POLICE_CA_PATH/ca/*_sk $POLICE_CA_PATH/ca/key.pem
  mv $POLICE_CA_PATH/ca/*-cert.pem $POLICE_CA_PATH/ca/cert.pem
  mv $POLICE_CA_PATH/tls/*_sk $POLICE_CA_PATH/tls/key.pem
  mv $POLICE_CA_PATH/tls/*-cert.pem $POLICE_CA_PATH/tls/cert.pem

  cp $CRYPTO_PEER/repairshop-org/ca/* $REPAIRSHOP_CA_PATH/ca
  cp $CRYPTO_PEER/repairshop-org/tlsca/* $REPAIRSHOP_CA_PATH/tls
  mv $REPAIRSHOP_CA_PATH/ca/*_sk $REPAIRSHOP_CA_PATH/ca/key.pem
  mv $REPAIRSHOP_CA_PATH/ca/*-cert.pem $REPAIRSHOP_CA_PATH/ca/cert.pem
  mv $REPAIRSHOP_CA_PATH/tls/*_sk $REPAIRSHOP_CA_PATH/tls/key.pem
  mv $REPAIRSHOP_CA_PATH/tls/*-cert.pem $REPAIRSHOP_CA_PATH/tls/cert.pem

  cp $CRYPTO_PEER/shop-org/ca/* $SHOP_CA_PATH/ca
  cp $CRYPTO_PEER/shop-org/tlsca/* $SHOP_CA_PATH/tls
  mv $SHOP_CA_PATH/ca/*_sk $SHOP_CA_PATH/ca/key.pem
  mv $SHOP_CA_PATH/ca/*-cert.pem $SHOP_CA_PATH/ca/cert.pem
  mv $SHOP_CA_PATH/tls/*_sk $SHOP_CA_PATH/tls/key.pem
  mv $SHOP_CA_PATH/tls/*-cert.pem $SHOP_CA_PATH/tls/cert.pem


  cp ./crypto-config/ordererOrganizations/orderer-org/orderers/orderer0/tls/ca.crt $WEBCERTS/ordererOrg.pem

  cp $CRYPTO_PEER/insurance-org/peers/insurance-peer/tls/ca.crt $WEBCERTS/insuranceOrg.pem
  cp $CRYPTO_PEER/police-org/peers/police-peer/tls/ca.crt $WEBCERTS/policeOrg.pem
  cp $CRYPTO_PEER/repairshop-org/peers/repairshop-peer/tls/ca.crt $WEBCERTS/repairShopOrg.pem
  cp $CRYPTO_PEER/shop-org/peers/shop-peer/tls/ca.crt $WEBCERTS/shopOrg.pem

  cp $CRYPTO_PEER/insurance-org/users/Admin@insurance-org/msp/keystore/* $WEBCERTS/Admin@insurance-org-key.pem
  cp $CRYPTO_PEER/insurance-org/users/Admin@insurance-org/msp/signcerts/* $WEBCERTS/
  cp $CRYPTO_PEER/shop-org/users/Admin@shop-org/msp/keystore/* $WEBCERTS/Admin@shop-org-key.pem
  cp $CRYPTO_PEER/shop-org/users/Admin@shop-org/msp/signcerts/* $WEBCERTS/
  cp $CRYPTO_PEER/police-org/users/Admin@police-org/msp/keystore/* $WEBCERTS/Admin@police-org-key.pem
  cp $CRYPTO_PEER/police-org/users/Admin@police-org/msp/signcerts/* $WEBCERTS/
  cp $CRYPTO_PEER/repairshop-org/users/Admin@repairshop-org/msp/keystore/* $WEBCERTS/Admin@repairshop-org-key.pem
  cp $CRYPTO_PEER/repairshop-org/users/Admin@repairshop-org/msp/signcerts/* $WEBCERTS/

  docker-compose up -d
  docker ps
  if [ $? -ne 0 ]; then
    echo "ERROR !!!! Unable to start network"
    exit 1
  fi
}


function networkDown() {
  docker-compose down --volumes --remove-orphans
  docker rmi -f $(docker images | grep bcins | awk {'print $3'})
  docker container rm $(docker container ps -aq)
  y | docker network prune
  echo

  sudo rm -rf $INSURANCE_CA_PATH
  sudo rm -rf $POLICE_CA_PATH
  sudo rm -rf $REPAIRSHOP_CA_PATH
  sudo rm -rf $SHOP_CA_PATH
  sudo rm -rf $WEBCERTS/*

  rm -rf ./insurance/insurance-peer
  rm -rf ./insurance/shop-peer
  rm -rf ./insurance/repairshop-peer
  rm -rf ./insurance/police-peer
  echo
}

function startAPI() {
  cd insurance
  echo
	if [ -d node_modules ]; then
		echo "============== node modules installed already ============="
	else
		echo "============== Installing node modules ============="
		npm install
	fi
	echo

  echo "============== Running API ============="
  npm start
}


INSURANCE_CA_PATH=./configCA/insuranceCA/crypto
POLICE_CA_PATH=./configCA/policeCA/crypto
REPAIRSHOP_CA_PATH=./configCA/repairshopCA/crypto
SHOP_CA_PATH=./configCA/shopCA/crypto

CRYPTO_PEER=./crypto-config/peerOrganizations
WEBCERTS=./insurance/certs

CHANNEL_NAME="default"
CLIPATH=./channel-artifacts

MODE=$1
if [ "${MODE}" == "up" ]; then
  networkUp
elif [ "${MODE}" == "down" ]; then
  networkDown
elif [ "${MODE}" == "generate" ]; then
  generateCerts
elif [ "${MODE}" == "start" ]; then
  startAPI
else
  printHelp
  exit 1
fi