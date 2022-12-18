# Auctions
 English and Dutch auctions using Solidity.

English auction proceeds as follows:
- The auctioneer opens the auction by announcing a suggested opening bid, a starting price or reserve for the item on sale.
- Then the auctioneer accepts increasingly higher bids from the floor and sometimes from other sources, for example online or telephone bids, consisting of buyers with an interest in the item. The auctioneer usually determines the minimum increment of bids, often making them larger as bidding reaches higher levels.
- The highest bidder at any given moment is considered to have the standing bid, which can only be displaced by a higher bid from a competing buyer.
- If no competing bidder challenges the standing bid within the time allowed by the auctioneer, the standing bid becomes the winner, and the item is sold to the highest bidder at a price equal to their bid.
- If no bidder accepts the starting price, the auctioneer either begins to lower the starting price in increments, or bidders are allowed to bid prices lower than the starting price, or the item is not sold at all, according to the wishes of the seller or protocols of the auction house.

A Dutch auction initially offers an item at a price in excess of the amount the seller expects to receive. The price lowers in steps until a bidder accepts the current price. That bidder wins the auction and pays that price for the item.

