# Unified Drinks Library (a unilib expansion pack)

## Latest release: v1.1.0 (4 January 2026) (see recent [changes](CHANGES.txt))

[unilib](https://github.com/axcore/unilib) is a mod for all Minetest-compatible engines, including [Luanti](https://www.luanti.org/).

[unidrinks](https://github.com/axcore/unidrinks) is an expansion pack for **unilib**, providing (mostly) alchoholic drinks and related items from the following mods:

* [bbq](https://github.com/Grizzly-Adam/BBQ) - imported only beer (used by the **bbq_extra** remix); all other material from the **bbq** mod appears in unilib itself (in the **bbq** remix)
* [beer_test](https://bitbucket.org/kingarthursteam/beer-test) - imported everything except the uncraftable drinks
* [wine](https://codeberg.org/tenplus1/wine) - imported everything

<u>This mod is rated as 18+</u>. It provides alcoholic drinks, but there are no intoxication effects. At their parents' discretion, this mod *might* be suitable for some younger players.

## 1 How to play

First, download the mod and its dependencies.

- Download [unidrinks](https://github.com/axcore/unidrinks), and add it to Minetest's **mods** folder
- Download [unilib](https://github.com/axcore/unilib) (v1.1.0 or later), and add it to Minetest's **mods** folder
    - Alternatively, download [unigame](https://github.com/axcore/unigame) (v1.1.0 or later), and add it to Minetest's **games** folder
    - **unigame** includes a copy of **unilib**

Then, set up a new world.

- In Minetest's main menu, create a new world (or choose an existing one)
- Click the **Select Mods** button, and enable both **unilib** and **unidrinks**
- Now click the **Settings** button in the top right corner
- In the left panel, scroll down and select **Unified Voxel Library (unilib)**
- In the right panel, you should be able to see a box marked **List of remixes and packages to load**
- In the box, add one or more of the remixes provided by **unidrinks**:

        bbq_extra
        beer_test
        wine

- In the right panel, find the box marked **Allow limited adult content**, and enable it
- Click the **Set** button to apply the changes

When you're ready, start the game!

## 2 Brewing beer, ale and mead

This section describes how to brew beer, ale and mead using items from the **beer_test** mod. This is multi-stage process, but the final product will be delicious!

### 2.1 Crafting beer

The first step is to find **wild hops** and **wild brewer's oats** growing in your world.

Wild hops is essential for brewing beer. It grows nears trees and water, but it is somewhat rare. Once you've collected a few seeds, you can farm them (see the section below).

Wild brewer's oats are only needed for brewing ale; they are not needed for beer or mead. They are rather common, so they probably aren't worth farming. If you *do* want to farm them, then no special equipment is needed - they can be planted on wet soil, just like any other seed crop.

### 2.2 Farming hops

Hops can be farmed, but you'll need some special equipment.

Firstly, craft some **fences**, and place them in two towers, five blocks high and several blocks apart.

Next, craft some **brewer's suspension ropes** and place them in a line between the two towers. There should be room for four blocks beneath the rope and the ground.

Then, craft some **brewere's cultivation ropes**. While wielding the cultivation ropes, punch the suspension ropes; this creates a knotted rope. Beneath the knotted rope you can hang up to three more cultivation ropes (leaving room for one block between the rope and the ground).

Now, prepare some wet soil in the usual way, directly beneath the cultivation ropes. Craft some **planting frames** and place them on the soil. Left-click the frames with **hops seeds**, in order to plant them.

Hops plants have ten growth stages, more than most seed crops. When they reach maturity then can be harvested by punching them with empty hands. Over time, mature hops plants will "climb" up the ropes; this will allow you to harvest more hops from a single plant, than would otherwise be possible.

### 2.3 Drying hops

Once hops has been harvested, it must be dried out. Place the harvested hops underneath a walkable node (wooden planks are ideal), with plenty of air all around. There are two drying stages; wait until the hops has fully dried out before collecting it.

### 2.4 Preparing wheat trays

Beer, ale and mead is made from dried hops and various grains; while you're waiting for the hops to dry out, you can start preparing the grains.

The first step is to craft three **empty trays**.

Then, harvest some **wheat** from your wheat farm; you'll need at least nine of them.

Finally, use the empty trays and wheat to craft three **wheat trays**.

### 2.5 Preparing malt trays

Place the three wheat trays *next to* a water source.

After a while, the wheat trays will start sprouting. Remove the trays, and place them *away* from any water source.

Wait for the trays to dry out. You should now have three **normal malt trays**.

Do nothing with the first tray. The second tray should be cooked in a furnace, to produce a **crystallised malt tray**. The third tray should be cooked twice, first producing a crystallised tray, then a **black malt tray**.

### 2.6 Preparing grains

You should now have three different malt trays. One by one, place them in your crafting grid, so you can remove three different **malt grains**.

Place these grains back in your crafting grid, along with three dried hops; you can now craft **mixed beer grains**.

Mixed beer grains are the final ingredient required to brew beer. Ale is brewed from **mixed ale grains**, which require the same malt grains (but no hops), brewer's oats and **ale yeast**. Mead is brewed from **mixed mead grains**, which are crafted from **apples**, ale yeast and **sugar**.

### 2.7 Brewing beer, ale and mead

Craft an empty barrel, and place it in the world. Left-click the barrel with one of the mixed grains - beer, ale or mead. Then, left-click the barrel with any wooden planks, which seals the barrel and starts the brewing process.

The brewing process takes some time, and passes through several stages. For example, when brewing beer, the stages are:

* Watery malt
* Fermenting malt
* Light beer
* Normal beer
* Dark beer

During any stage, you can punch the barrel with an empty tankard, in order to fill the tankard with beer (or ale, or mead). Punching the barrel at different stages of the brewing process produces different types of beer. When the barrel is empty, it can be re-used.

You can also dig the barrel, which will halt the brewing process at its current stage. For example, dig (and then place) the barrel at the "light beer" stage if you don't want to drink normal or dark beer.

## 3 Fermenting other drinks

This section describes how to ferment all other drinks, besides those described above. These drinks come from the **wine** mod.

First, craft an empty **fermentation barrel**, and place it in the world. Right-click the barrel to open its formspecs.

In the bottom slot, you can place some source of potable water - water source nodes, buckets of water and glasses of water are all compatible. Alternatively, place the barrel near water (flowing water fills the barrel at half the rate of a nearby water source node). You can also use water inlets from the **pipeworks** mod.

In the top slots, place the ingredient(s) for the drink and an empty glass. For example, in order to ferment cider, place an apple in one slot.

The fermentation process takes some minutes. When you've produced nine glasses of cider (and so on), you can use them to craft a bottle of cider.

Some ingredients are provided packages from other remixes, for example the **farming_redo** remix. You can find out which ingredients are needing for each drink, by checking the drink's description in your inventory mod.

## 4 More information

For more information about **unilib** remixes, see the **unilib** documentation.
