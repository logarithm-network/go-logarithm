// Copyright 2016 The go-logarithm Authors
// This file is part of the go-logarithm library.
//
// The go-logarithm library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-logarithm library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-logarithm library. If not, see <http://www.gnu.org/licenses/>.

package ethclient

import "github.com/logarithm-network/go-logarithm"

// Verify that Client implements the logarithm interfaces.
var (
	_ = logarithm.ChainReader(&Client{})
	_ = logarithm.TransactionReader(&Client{})
	_ = logarithm.ChainStateReader(&Client{})
	_ = logarithm.ChainSyncReader(&Client{})
	_ = logarithm.ContractCaller(&Client{})
	_ = logarithm.GasEstimator(&Client{})
	_ = logarithm.GasPricer(&Client{})
	_ = logarithm.LogFilterer(&Client{})
	_ = logarithm.PendingStateReader(&Client{})
	// _ = logarithm.PendingStateEventer(&Client{})
	_ = logarithm.PendingContractCaller(&Client{})
)
