---@class UIGridLayout : UIGridStyleLayout, UILayout, UIComponent, UIBase, Instance
---@field public AbsoluteCellCount Vector2
---@field public AbsoluteCellSize Vector2
---@field public CellPadding UDim2
---@field public CellSize UDim2
---@field public FillDirectionMaxCells int
---@field public StartCorner StartCorner
---A UIGridLayout (not to be confused with the abstract `UIGridStyleLayout` from
---which this class inherits) lays out sibling UI elements in multiple rows
---within the parent UI element, adding elements to a row one-by-one until the
---next element would not fit. It then continues adding elements in the next row.
---A UIGridLayout will take UI elements' `GuiObject/Size` and
---`GuiObject/Position` under control. While under control, these UI elements'
---properties will not be editable in the Properties window.
---
---![A UIGridLayout arranging inventory slots in a grid][1]
---
---By default, it lays out elements from left-to-right, top-to-bottom in
---**alphabetical** order, but this can be changed to use elements'
---`GuiObject/LayoutOrder` by changing `UIListLayout/SortOrder` to LayoutOrder. A
---UIListLayout will automatically re-layout elements when elements are
---added/removed, or if a relevant property changes: `GuiObject/LayoutOrder` or
---`Instance/Name`. This can be triggered manually by calling
---`UIGridStyleLayout/ApplyLayout`, though this is typically not necessary.
---
---The actual cell sizes are the same for all cells. A UIGridLayout will respect
---UI constraints placed with it, such as `UISizeConstraint` and
---`UIAspectRatioConstraint`. Elements in the layout can span multiple cells if
---they have a `UISizeConstraint` with a `UISizeConstraint/MinSize|MinSize` set
---higher than the `UIGridLayout/CellSize|CellSize`. It is possible to limit the
---number of elements per row using `UIGridLayout/FillDirectionMaxCells`. If set
---to 1, it is possible to create a single row of elements (as each element would
---be positioned in its own row).
---
---This layout is appropriate when line breaks are OK after arbitrary cells. For
---example, a set of inventory spaces is a good use of this layout. If building a
---table of values in which a line break is not appropriate in the middle of
---tabular data, it might be a better idea to use a `UITableLayout` instead.
---
---[1]: /assets/bltdf5323e2df741820/GamepadGrid_Image03.png
---
local UIGridLayout;
---Measures the maximum number of elements in each direction. Read-only.
---
UIGridLayout.AbsoluteCellCount = nil;
---Provides the size of each element of the grid in offsets. Read-only. Not
---affected by any `UIScale`, `UISizeConstraint` or `UIAspectRatioConstraint`
---applied to any individual element in the grid.
---
UIGridLayout.AbsoluteCellSize = nil;
---(default {0, 5},{0, 5}) Determines how much space there is between
---elements in the grid. As with all UDim2s, this space can be both in a
---percentage of the parent container's size and raw pixel offset.
---
UIGridLayout.CellPadding = nil;
---(default {0, 100},{0, 100}) Determines the size of each element in the
---grid. As with all UDim2s, this size can be both in a percentage of the
---parent container's size and raw pixel offset. If the element being size
---has a `UIConstraint` then the size will be determined by the constraint,
---not the grid.
---
UIGridLayout.CellSize = nil;
---FillDirectionMaxCells determines the number of cells in the grid that can
---be used before continuing on the next row/column (whether this is a row or
---column is dependent on `UIGridStyleLayout/FillDirection`). This value must
---be non-negative.
---
---- If set to zero, there is no maximum number of cells that may appear in
---  one row/column except for how many can fit within the parent UI element.
---- If set to one, this creates a list similar to those created by
---  `UIListLayout`.
---
UIGridLayout.FillDirectionMaxCells = nil;
---StartCorner (`Enum/StartCorner`) determines from which corner the grid
---starts laying out UI elements. The grid continues in the
---`UIGridStyleLayout/FillDirection`, filling elements one by one until
---`UIGridLayout/FIllDirectionMaxCells` cells have been laid out in that
---row/column or if all the parent UI element's space has been occupied by
---previous cells.
---
---![UIGridLayout with a StartCorner of BottomRight][1]
---
---Above, the potion is the first `ImageLabel`, followed by the gem and the
---sword. The UIGridLayout is using a `Enum/StartCorner` of BottomRight. The
---`UIGridStyleLayout/FillDirection` is Horizontal.
---
---[1]: /assets/bltb27258f9e16b81e2/UIGridLayout_StartCorner.png
---
UIGridLayout.StartCorner = nil;
---@class UIGridStyleLayout : UILayout, UIComponent, UIBase, Instance
---@field public AbsoluteContentSize Vector2
---@field public FillDirection FillDirection
---@field public HorizontalAlignment HorizontalAlignment
---@field public SortOrder SortOrder
---@field public VerticalAlignment VerticalAlignment
---The base class for grid style UI layouts.
---
local UIGridStyleLayout;
---The AbsoluteContentSize property of a `UIGridStyleLayout` shows how much
---space the elements of the grid are taking up, including any padding
---created by the grid. This property is particularly useful to size
---containers of grids such as `Frame`s and Frame to make sure they aren't
---any larger than the grid itself.
---
---It updates as soon as it's read. It won't fire a changed event immediately
---after the UI has changed, but if the value is read it will be up to date.
---A `Instance/Changed` event should fire on the next render step.
---
UIGridStyleLayout.AbsoluteContentSize = nil;
---The FillDirection property determines the axis in which UI elements are
---laid out. Horizontal will arrange elements from left to right, while
---Vertical will arrange from top to bottom. To reverse elements (for
---instance, arrange right to left) you will need to reverse the sorting.
---This can be done by negating the child UI elements'
---`GuiObject/LayoutOrder` values when `UIGridStyleLayout/SortOrder` is set
---to LayoutOrder.
---
UIGridStyleLayout.FillDirection = nil;
---The HorizontalAlignment property determines the X-axis alignment of the
---laid-out grid of UI elements, much like `TextLabel/TextXAlignment` does
---with `TextLabel/Text`.
---
UIGridStyleLayout.HorizontalAlignment = nil;
---The SortOrder property determines the next UI element to be placed in a
---layout. For Name, a simple alphabetic sort is used on the Name property of
---the child UI elements. For LayoutOrder, a low-to-high sort is used on the
---`GuiObject/LayoutOrder` property of child UI elements. If two share the
---same `GuiObject/LayoutOrder`, whichever was added sooner to the parent
---object takes precedence. An easy way to reverse the sorting order is to
---negate LayoutOrder.
---
UIGridStyleLayout.SortOrder = nil;
---The VerticalAlignment property determines the Y-axis alignment of the
---laid-out grid of UI elements, much like `TextLabel/TextYAlignment` does
---with `TextLabel/Text`.
---
UIGridStyleLayout.VerticalAlignment = nil;
---@param kw_function Function
---@return void
---This method is deprecated. Use `UIGridStyleLayout/SortOrder` instead.
---
---$DESCRIPTION_SHORT The function should take two arguments (each will be an
---Instance child to compare), and return true if a comes before b, otherwise
---return false. In other words, use this function the same way you would use
---a ' function. The sorting should be deterministic, otherwise sort will
---fail and fall back to name order.
---
UIGridStyleLayout.SetCustomSortFunction = function(self, kw_function) end;
---@return void
---The ApplyLayout method forces sibling UI elements to be re-laid out in
---case the sorting criteria may have changed (such as when
---`UIGridStyleLayout/SortOrder` is set to Custom, and the
---`UIGridStyleLayout/SetCustomSortFunction` behavior changed). Re-layouts
---automatically happen when UI elements are added/removed, or their
---`Instance/Name` or `GuiObject/LayoutOrder` change.
---
---The manner in which sibling UI elements are laid out is dependent on the
---implementation of this abstract class. In other words, a concrete class
---like `UIListLayout` or `UIGridLayout` is responsible for the actual
---element positioning.
---
UIGridStyleLayout.ApplyLayout = function(self) end;
---@class UILayout : UIComponent, UIBase, Instance
---The base class for UI layout classes.
---
local UILayout;
---@class UIListLayout : UIGridStyleLayout, UILayout, UIComponent, UIBase, Instance
---@field public Padding UDim
---A UIListLayout lays out sibling UI elements in a single row within the parent
---UI element, either horizontally or vertically. Each sibling UI element retains
---its original `GuiObject/Size`, but its `GuiObject/Position` will be taken
---under control by the UIListLayout. While under control, the Position property
---of sibling UI elements will not be editable in the Properties window.
---
---You can use the elements' `GuiObject/LayoutOrder` by changing
---`UIListLayout/SortOrder` to LayoutOrder. A UIListLayout will automatically
---re-layout elements when elements are added/removed, or if a relevant property
---changes: `GuiObject/LayoutOrder`, `Instance/Name` or `GuiObject/Size`. This
---can be triggered manually by calling `UIGridStyleLayout/ApplyLayout`, though
---this is typically not necessary.
---
---Since each property that changes how elements are laid out will re-apply the
---layout, it is recommended to set the `Instance/Parent` property last so that
---the layout is only applied once. Similarly, since adding more UI elements will
---also re-apply the layout, add the UIListLayout last so it does not recalculate
---positions after each element.
---
local UIListLayout;
---Determines the amount of free space between each element. Can be set
---either using scale (Percentage of parent's size in the current direction)
---or offset (a static spacing value, similar to pixel size).
---
UIListLayout.Padding = nil;
---@class UIPadding : UIComponent, UIBase, Instance
---@field public PaddingBottom UDim
---@field public PaddingLeft UDim
---@field public PaddingRight UDim
---@field public PaddingTop UDim
---Applies padding to the borders of the GuiObject that this is parented to.
---
local UIPadding;
---The padding to apply on the bottom side relative to the parent's normal
---size.
---
UIPadding.PaddingBottom = nil;
---The padding to apply on the left side relative to the parent's normal
---size.
---
UIPadding.PaddingLeft = nil;
---The padding to apply on the right side relative to the parent's normal
---size.
---
UIPadding.PaddingRight = nil;
---The padding to apply on the top side relative to the parent's normal size.
---
UIPadding.PaddingTop = nil;
---@class UIPageLayout : UIGridStyleLayout, UILayout, UIComponent, UIBase, Instance
---@field public Animated bool
---@field public Circular bool
---@field public CurrentPage GuiObject
---@field public EasingDirection EasingDirection
---@field public EasingStyle EasingStyle
---@field public GamepadInputEnabled bool
---@field public Padding UDim
---@field public ScrollWheelInputEnabled bool
---@field public TouchInputEnabled bool
---@field public TweenTime float
---@field public PageEnter RBXScriptSignal.PageEnter
---@field public PageLeave RBXScriptSignal.PageLeave
---@field public Stopped RBXScriptSignal.Stopped
---Creates a paged viewing window, like the home screen of a mobile device. You
---can use a UIPageLayout by parenting it to a GuiObject. The UIPageLayout will
---then apply itself to all of its GuiObject siblings.
---
local UIPageLayout;
---Whether or not to animate transitions between pages.
---
UIPageLayout.Animated = nil;
---Whether or not the page layout wraps around at the ends.
---
UIPageLayout.Circular = nil;
---The page that is either currently being displayed or is the target of the
---current animation.
---
UIPageLayout.CurrentPage = nil;
---The easing direction to use when performing an animation.
---
UIPageLayout.EasingDirection = nil;
---The easing style to use when performing an animation.
---
UIPageLayout.EasingStyle = nil;
---Controls the overrides of `NextSelection{Up,Down,Left,Right}`. Defaults to
---true.
---
UIPageLayout.GamepadInputEnabled = nil;
---Determines the amount that pages are separated from each other by. Can be
---set either using scale (Percentage of parent's size in the current
---direction) or offset (a static spacing value, similar to pixel size).
---
UIPageLayout.Padding = nil;
---Controls the use of scroll wheel, in case that it is intended for
---something else. Defaults to true.
---
UIPageLayout.ScrollWheelInputEnabled = nil;
---Controls touch scrolling, in case this is a non-interactive layout.
---Defaults to true.
---
UIPageLayout.TouchInputEnabled = nil;
---The length of the animation.
---
UIPageLayout.TweenTime = nil;
---@return void
---Sets `UIPageLayout/CurrentPage` to the page before the current page and
---animates to it, or does nothing if there isn't a previous page.
---
UIPageLayout.Previous = function(self) end;
---@param index int
---@return void
---If the index is `>= 0` and less than the size of the layout, this method
---acts like `UIPageLayout/JumpTo`. If it's out of bounds and circular is
---set, it will animate the full distance between the in-bounds index of
---`UIPageLayout/CurrentPage` and the new index.
---
UIPageLayout.JumpToIndex = function(self, index) end;
---@param page Instance
---@return void
---If the `page` is in the UIPageLayout, then it sets
---`UIPageLayout/CurrentPage` to it and animates to it. If the circular
---layout is enabled, it will take the shortest path to this page.
---
UIPageLayout.JumpTo = function(self, page) end;
---@return void
---Sets `UIPageLayout/CurrentPage` to the page after the current page and
---animates to it, or does nothing if there isn't a next page.
---
UIPageLayout.Next = function(self) end;
---@class RBXScriptSignal.PageEnter : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.PageEnter, callback: fun(page: Instance)): RBXScriptConnection
---Fires when a page comes into view, and is going to be rendered.
---
UIPageLayout.PageEnter = nil;
---@class RBXScriptSignal.PageLeave : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.PageLeave, callback: fun(page: Instance)): RBXScriptConnection
---Fires when a page leaves view, and will not be rendered.
---
UIPageLayout.PageLeave = nil;
---@class RBXScriptSignal.Stopped : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.Stopped, callback: fun(currentPage: Instance)): RBXScriptConnection
---Fires when an animation to `UIPageLayout/CurrentPage` is completed without
---being canceled, and the view stops scrolling.
---
UIPageLayout.Stopped = nil;
---@class UIScale : UIComponent, UIBase, Instance
---@field public Scale float
---A UIScale object simply contains a number that is used to multiply the
---`GuiBase2d/AbsoluteSize` of the parent UI element. This number is stored in
---`UIScale/Scale`.
---
local UIScale;
---The Scale property determines the multiplier used on the parent UI
---element's `GuiBase2d/AbsoluteSize`. When set to 0.5, an AbsoluteSize of
---{0, 200}, {0, 50} becomes {0, 100}, {0, 25}. Similarly, when set to 2,
---such an AbsoluteSize would become {0, 400}, {0, 100}.
---
UIScale.Scale = nil;
---@class UISizeConstraint : UIConstraint, UIComponent, UIBase, Instance
---@field public MaxSize Vector2
---@field public MinSize Vector2
---The UISizeConstraint ensures a `GuiObject` does not become larger or smaller
---than the `UISizeConstraint/MaxSize` and `UISizeConstraint/MinSize`.
---
---For example, if the MaxSize is set to `{200, 200}` and the MinSize is set to
---`{100, 100}`, then the constrained GuiObject cannot scale to be larger than
---200 pixels wide and 200 pixels tall or smaller than 100 pixels wide and 100
---pixels tall.
---
---If the object with this constraint is also under the control of a `UILayout`
---such as `UIGridLayout`, then the constraint determines the objects size and
---overwrites any size the layout would apply.
---
---A UISizeConstraint can be applied to a GuiObject by parenting it to that
---object.
---
local UISizeConstraint;
---The largest size in pixels the object is allowed to be. The X and Y of
---this value must be greater than or equal to the corresponding components
---of `UISizeConstraint/MinSize`.
---
UISizeConstraint.MaxSize = nil;
---The smallest size in pixels the object is allowed to be. The X and Y of
---this value must be less than or equal to the corresponding components of
---`UISizeConstraint/MaxSize`.
---
UISizeConstraint.MinSize = nil;
---@class UIStroke : UIComponent, UIBase, Instance
---@field public ApplyStrokeMode ApplyStrokeMode
---@field public Color Color3
---@field public Enabled bool
---@field public LineJoinMode LineJoinMode
---@field public Thickness float
---@field public Transparency float
---For a more detailed walkthrough of the UIStroke object, take a look at the
---<a href="../..https://developer.roblox.com/articles/applying-strokes">Applying
---Strokes</a> article.
---
---An instance that applies an outline to text or a UI border. Key features
---include:
---
---- Adjust the color and thickness of the stroke outline.
---- Change the stroke transparency independently from the text or UI object.
---- Choose the corner style of the stroke (round, bevel, or miter).
---- Add a gradient to the stroke via the `UIGradient` instance.
---- Use rich text tags to add stroke to inline text segments.
---
---## Rich Text
---
---If your text object has [rich text](/building-and-visuals/ui/rich-text)
---enabled, you can control stroke properties on segments of the string via the
---`<stroke>` tag.
---
---<table>
---    <thead>
---        <tr>
---            <th>Property</th>
---            <th>Description</th>
---            <th>Default</th>
---        </tr>
---    </thead>
---    <tbody>
---        <tr>
---            <td><code>color</code></td>
---            <td>Sets the stroke <a href="#color-gradient">color</a>.</td>
---            <td><code>rgb(0, 0, 0)</code></td>
---        </tr>
---        <tr>
---            <td><code>joins</code></td> 
---            <td>Sets the <a href="#corner-style">corner style</a>. Can be set to <code>round</code>, <code>bevel</code>, or
---            <code>miter</code>.</td> 
---            <td><code>round</code></td>
---        </tr>
---        <tr>
---            <td><code>thickness</code></td>
---            <td>Sets the stroke <a href="#thickness">thickness</a>.</td>
---            <td><code>1</code></td>
---        </tr>
---        <tr>
---            <td><code>transparency</code></td>
---            <td>Sets the stroke <a href="#transparency">transparency</a>.</td>
---            <td><code>0</code></td>
---        </tr>
---    </tbody>
---</table>
---
---```html
---The &lt;font color="#c80032"&gt;<mark
---  >&lt;stroke color="#fcc633" thickness="4"&gt;dragon&lt;/stroke&gt;</mark
--->&lt;/font&gt; is hungry.
---```
---
---<img src="/assets/blt2fa6854d87124e34/Stroke-RichText.png" />
---
local UIStroke;
---When a `UIStroke` instance is applied to a text object, this property
---determines whether to apply the stroke to the object's border instead of
---the text itself.
---
---<figure>
---<img src="/assets/blt951ea44531dd3c5b/Text-Outline-Slim.png" />
---<figcaption>Contextual</figcaption>
---</figure>
---
---<figure>
---<img src="/assets/blt751c49e6311d71d7/Text-Border.png" />
---<figcaption>Border</figcaption>
---</figure>
---      
---See also:
---
---For a more detailed walkthrough of the UIStroke object, take a look at the
---<a href="https://developer.roblox.com/articles/applying-strokes">Applying
---Strokes</a> article.
---
UIStroke.ApplyStrokeMode = nil;
---Determines the `UIStroke` stroke color. You can also insert a `UIGradient`
---instance as a child of the UIStroke to create gradient strokes.
---
---<figure>
---<img src="/assets/blt705164afff9a8a97/Outline-Color-Solid.png" />
---<figcaption>Stroke <code>UIStroke/Color|Color</code> of **0**, **95**, **225**</figcaption>
---</figure>
---
---<figure>
---<img src="/assets/blt18c7d4b815364461/Outline-Color-Gradient.png" />
---<figcaption><code>UIStroke</code> with <code>UIGradient</code> child</figcaption>
---</figure>
---
---Note that both the parent object and UIStroke can have child UIGradients,
---letting you set gradients on both the stroke and fill independently.
---
---See also:
---
---For a more detailed walkthrough of the UIStroke object, take a look at the
---<a href="https://developer.roblox.com/articles/applying-strokes">Applying
---Strokes</a> article.
---
UIStroke.Color = nil;
---This property determines whether the `UIStroke` is visible. When set to
---false, the stroke will not be rendered. The value defaults to true.
---
---See also:
---
---For a more detailed walkthrough of the UIStroke object, take a look at the
---<a href="https://developer.roblox.com/articles/applying-strokes">Applying
---Strokes</a> article.
---
UIStroke.Enabled = nil;
---This property determines how corners are interpreted. It accepts a value
---of either **Round**, **Bevel**, or **Miter**. Default is **Round**.
---
---<figure>
---<img src="/assets/blt08417c7c81c4adb5/Outline-Corner-Round.png" />
---<figcaption>Round</figcaption>
---</figure>
---
---<figure>
---<img src="/assets/blt7f4422322e7f0841/Outline-Corner-Bevel.png" />
---<figcaption>Bevel</figcaption>
---</figure>
---
---<figure>
---<img src="/assets/blt4ab29c3097329c96/Outline-Corner-Miter.png" />
---<figcaption>Miter</figcaption>
---</figure>
---      
---See also:
---
---For a more detailed walkthrough of the UIStroke object, take a look at the
---<a href="https://developer.roblox.com/articles/applying-strokes">Applying
---Strokes</a> article.
---
UIStroke.LineJoinMode = nil;
---This property determines the stroke's thickness, measured in pixels from
---the parent's outer edges.
---
---<figure>
---<img src="/assets/blte2189b6f00c809b9/Outline-Thickness-4.png" />
---<figcaption>4</figcaption>
---</figure>
---
---<figure>
---<img src="/assets/blt62d4cb5b19b1d1aa/Outline-Thickness-12.png" />
---<figcaption>12</figcaption>
---</figure>
---
---Be mindful of tweening the Thickness property of a <code>UIStroke</code>
---applied to text objects. This renders and stores many glyph sizes each
---frame, potentially causing performance issues or text flickering.
---
---See also:
---
---For a more detailed walkthrough of the UIStroke object, take a look at the
---<a href="https://developer.roblox.com/articles/applying-strokes">Applying
---Strokes</a> article.
---
UIStroke.Thickness = nil;
---The `UIStroke/Transparency|Transparency` property sets the stroke opacity
---independently of the parent object's
---`GuiObject/BackgroundTransparency|BackgroundTransparency` or
---`TextLabel/TextTransparency|TextTransparency`. This allows you to render
---text and borders that are "hollow" (consisting of only an outline).
---
---<figure>
---<img src="/assets/blt1f5e6933077f2429/Outline-Transparency-A.png" />
---<figcaption>Stroke <code>UIStroke/Transparency|Transparency</code> of **0.5**Object <code>TextLabel/TextTransparency|TextTransparency</code> of **0**</figcaption>
---</figure>
---
---<figure>
---<img src="/assets/blt578f49b66021ec35/Outline-Transparency-B.png" />
---<figcaption>Stroke <code>UIStroke/Transparency|Transparency</code> of **0**Object <code>TextLabel/TextTransparency|TextTransparency</code> of **1**</figcaption>
---</figure>
---      
---See also:
---
---For a more detailed walkthrough of the UIStroke object, take a look at the
---<a href="https://developer.roblox.com/articles/applying-strokes">Applying
---Strokes</a> article.
---
UIStroke.Transparency = nil;
---@class UITableLayout : UIGridStyleLayout, UILayout, UIComponent, UIBase, Instance
---@field public FillEmptySpaceColumns bool
---@field public FillEmptySpaceRows bool
---@field public MajorAxis TableMajorAxis
---@field public Padding UDim2
---A UITableLayout lays out sibling UI elements as rows in a table. Child UI
---elements (the table cells) of these rows are then arranged in columns (within
---rows). Each cell within a row has the same height, and each cell within a
---column has the same width. The hierarchy in the explorer should look like this
---(`Frame`s are yellow rows, `TextLabel`s are cells)
---
---<img src="/assets/bltae19601e50058387/UITableLayout_Hierarchy.png" alt="Hierarchy of UI elements used with a UITableLayout" />
---<img src="/assets/bltfda742fd4e1d6db9/UITableLayout_Padding.png" alt="UITableLayout result" />
---
---By changing the `UIGridStyleLayout/FillDirection`, sibling UI elements can act
---as columns instead.
---
---When applied, a UITableLayout will take control of sibling and cell elements'
---`GuiObject/Size` and `GuiObject/Position`. Changing these in the Properties
---window is still possible will not produce any effect.
---
---Dimensions of the cells in the resulting table are controlled by the parent UI
---element's dimensions. Unless `UITableLayout/FillEmptySpaceColumns` or
---`UITableLayout/FillEmptySpaceRows` is enabled, the cell dimensions will be
---that of the parent UI element (and thus tables with more than one cell extend
---outside of their parent).
---
---Cells will continue to respect `UISizeConstraint` objects within them. In
---other words, setting `UISizeConstraint/MinSize` on `UISizeConstraint`s within
---the header cells can determine the size of the rest of the cells. If
---`UISizeConstraint/MaxSize` restricts a cell's size from filling the allotted
---space (i.e. another row/column is wider than it), it will align to the
---top-left.
---
local UITableLayout;
---FillEmptySpaceColumns determines whether cells' X size are set such that
---the entire horizontal space of the parent UI element is used. Enabling
---this is useful for making sure your table takes up a more easily
---predictable amount of horizontal space (the X-axis size of the parent UI
---element). It is still possible that a `UISizeConstraint` applied to cells
---will cause underflow/overflow.
---
---When enabling this property, the column widths will be approximately equal
---to the parent's `GuiBase2d/AbsoluteSize`.X component divided by the number
---of columns (not accounting for padding or other factors).
---
UITableLayout.FillEmptySpaceColumns = nil;
---FillEmptySpaceRows determines whether cells' Y size are set such that the
---entire vertical space of the parent UI element is used. Enabling this is
---useful for making sure your table takes up a more easily predictable
---amount of vertical space (the Y-axis size of the parent UI element). It is
---still possible that a `UISizeConstraint` applied to cells will cause
---underflow/overflow.
---
---When enabling this property, the row heights will be approximately equal
---to the parent's `GuiBase2d/AbsoluteSize`.Y component divided by the number
---of rows (not accounting for padding or other factors).
---
UITableLayout.FillEmptySpaceRows = nil;
---MajorAxis determines whether sibling UI elements are treated as rows or
---columns. Below, the left uses a `Enum/TableMajorAxis` of RowMajor, and the
---right uses ColumnMajor.
---
---![Row major][1]![Column major][2]
---
---**Note: it seems that this property isn't making noticeable changes, and
---rather its behavior is determined by `UIGridStyleLayout/FillDirection`
---instead.**
---
---[1]: /assets/bltff6ce5d154eee764/UITableLayout_Padding.png
---[2]: /assets/bltd94eef328b68fed5/UITableLayout_FillDirection.png
---
UITableLayout.MajorAxis = nil;
---Padding will position elements with extra space between them. This can be
---done using Scale or Offset components of UDim2. Negative values can bring
---elements closer together. When non-zero, the sibling UI elements may be
---visible between the cells contained within them. In the image below, you
---can see the padding of 5 pixels applied between the cells (and the sibling
---UI elements acting as rows in yellow).
---
---![UITableLayout with padding between cells][1]
---
---[1]: /assets/bltff6ce5d154eee764/UITableLayout_Padding.png
---
UITableLayout.Padding = nil;
---@class UITextSizeConstraint : UIConstraint, UIComponent, UIBase, Instance
---@field public MaxTextSize int
---@field public MinTextSize int
---A **UITextSizeConstraint** ensures that the size of text rendered by certain
---`GuiObject` classes (`TextLabel`, `TextButton`, or `TextBox`) lies within the
---range described by `UITextSizeConstraint/MaxTextSize|MaxTextSize` and
---`UITextSizeConstraint/MinTextSize|MinTextSize`. It is meant to be used
---alongside `TextLabel/TextScaled`, which automatically scales text to fill its
---containing object. Like other UI constraints, it is applied when parented to
---the object to be constrained.
---
---![Constraints visual][1]
---
---It's recommended that no values lower than 9 be used for
---`UITextSizeConstraint/MinTextSize|MinTextSize` property, otherwise text may
---not be readable to most users.
---
---[1]: /assets/blte9c47efb631349e0/UITextSizeConstraintDemo.gif
---
local UITextSizeConstraint;
---this property indicates the largest size in pixels the font is allowed to
---be. It defaults to 1000 pixels and much be set larger than or equal to the
---`UITextSizeConstraint|UITextSizeConstraint's`
---`UITextSizeConstraint/MinTextSize|MinTextSize` property.
---
---![Constraints visual][1]
---
---If the affected `GuiObject` has its `TextLabel/TextScaled|TextScaled`
---property set to true the text size constrained by this property will scale
---dynamically with the container's size. It will scale upwards with the
---GuiObject's size until the max size is reached, at which point it will
---stay constant if the UI element continues to grow.
---
---[1]: /assets/blte9c47efb631349e0/UITextSizeConstraintDemo.gif
---
UITextSizeConstraint.MaxTextSize = nil;
---This property indicated the smallest size in pixels the font is allowed to
---be. This value defaults to 1 pixel and must be set less than or equal to
---`UITextSizeConstraint/MaxTextSize`.
---
---![Max and min constraints demo][1]
---
---If the affected `GuiObject` has its `TextLabel/TextScaled|TextScaled`
---property set to true the text size constrained by this property will scale
---dynamically with the container's size. It will scale downwards with the
---GuiObject's size until the min size is reached, at which point it will
---stay constant if the UI element continues to shrink.
---
---[1]: /assets/blte9c47efb631349e0/UITextSizeConstraintDemo.gif
---
UITextSizeConstraint.MinTextSize = nil;
---@class UnionOperation : PartOperation, TriangleMeshPart, BasePart, PVInstance, Instance
---The UnionOperation combines parts together into a single solid model. To use
---it, select the parts you want to combine and click the **Union** button in the
---**Model** tab. This will create a new part called **Union**.
---
---<img src="/assets/blt12f1f9b92d9773ec/CSG-Union-Button.png" />
---
---This function can be used in conjunction with `NegateOperation` to shape,
---resize, and create holes in solid models. Combined parts can also be
---separated, allowing developers to revert (undo) the result of a unioned model.
---
---You should only use **Union** on basic parts (block, sphere, wedge, or
---cylinder). Also, these parts should **not** have any children such as scripts,
---surface GUIs, etc. If a part with children is unioned, the children will be
---hidden from the `DataModel`.
---
---See also:
---
---- <a href="/building-and-visuals/modeling/solid-modeling">Solid modeling</a>,
---  an article that dives into solid modeling and how it lets you create complex
---  models from simple blocks, spheres, wedges, and cylinders
---- <a href="https://developer.roblox.com/articles/in-game-solid-modeling">In
---  Game Solid Modeling</a>, an article discussing how developers can perform
---  solid modeling live in-game as well as in Studio
---
local UnionOperation;
---@class UniversalConstraint : Constraint, Instance
---@field public LimitsEnabled bool
---@field public MaxAngle float
---@field public Radius float
---@field public Restitution float
---A physics constraint that ensures two axes on two rigid bodies remain
---perpendicular. An example use of this constraint are power transmission
---between the transmission and rear drive shafts of rear-wheel drive cars,
---robotics, etc.
---
---The constraint ensures that two attachments are co-located (similar to
---`BallSocketConstraint`) and that their secondary axes remain perpendicular
---(see the picture below). In this sense, this constraint is more restrictive
---than the BallSocketConstraint but is less restrictive than `HingeConstraint`
---(by one degree of freedom).
---
---<img src="/assets/blt96586dfb35538032/UniversalConstraintDemo.jpg?auto=yes&amp;bg=222&amp;fg=000" alt="Example UniversalConstraint" />
---
---If `UniversalConstraint/LimitsEnabled|LimitsEnabled` is `true`, then the
---relative motion of the primary axis of `Constraint/Attachment1|Attachment1` is
---limited by a cone. This cone is formed via
---`Constraint/Attachment0|Attachment0` and its primary axis and makes an angle
---of `UniversalConstraint/MaxAngle|MaxAngle` with it.
---
local UniversalConstraint;
---This property, when enabled, limits the relative angular motion of the
---primary axes of attachments through a cone constraint. The default value
---is false.
---
---The example below demonstrates how developers can enable a cone limit on
---the relative motion of the primary axes:
---
---```lua
---universalConstraint.LimitsEnabled = true
---```
---
UniversalConstraint.LimitsEnabled = nil;
---This property determines the max angle, in degrees, of the
---`UniversalConstraint|UniversalConstraint's` limiting cone. The limiting
---cone is formed from `Constraint/Attachment0|Attachment0` and its primary
---axis. The default value is 45.0 degrees.
---
---In order for this property to take affect, the constraint's
---`UniversalConstraint/LimitsEnabled` property must be set to `true`.
---
---For example, the code snippet below sets LimitsEnabled to true and limits
---the `UniversalConstraint/MaxAngle` to 10 degrees:
---
---```lua
---universalConstraint.LimitsEnabled = true
---universalConstraint.MaxAngle = 10
---```
---
UniversalConstraint.MaxAngle = nil;
---This property indicates the visualization radius, in studs, of the
---constraint when the constraint's details are off and the constraint is
---selected. The default value is 0.2 studs.
---
UniversalConstraint.Radius = nil;
---This property determines the restitution of the two limits, or how elastic
---they are. The value defaults to 0 and can be any floating number in the
---range [0, 1].
---
---    This property only applies when `UniversalConstraint/LimitsEnabled` is set to true.
---
---The elasticity affects the `Attachment|Attachments` connected by the
---`UniversalConstraint` when they reach the end of the range specified by
---`UniversalConstraint/MaxAngle`.
---
UniversalConstraint.Restitution = nil;
---@class UnvalidatedAssetService : Instance
local UnvalidatedAssetService;
---@param userId int64
---@param id int64
---@param lookAt Vector3
---@param camPos Vector3
---@return bool
UnvalidatedAssetService.AppendVantagePoint = function(self, userId, id, lookAt, camPos) end;
---@param userId int64
---@param id int64
---@param lookAt Vector3
---@param camPos Vector3
---@param usage string
---@return void
UnvalidatedAssetService.AppendTempAssetId = function(self, userId, id, lookAt, camPos, usage) end;
---@param userId int64
---@param tempId int64
---@param assetId int64
---@return bool
UnvalidatedAssetService.UpgradeTempAssetId = function(self, userId, tempId, assetId) end;
---@class UserGameSettings : Instance
---@field public AllTutorialsDisabled bool
---@field public CameraMode CustomCameraMode
---@field public CameraYInverted bool
---@field public ChatVisible bool
---@field public ComputerCameraMovementMode ComputerCameraMovementMode
---@field public ComputerMovementMode ComputerMovementMode
---@field public ControlMode ControlMode
---@field public DefaultCameraID string
---@field public Fullscreen bool
---@field public GamepadCameraSensitivity float
---@field public GraphicsQualityLevel int
---@field public HasEverUsedVR bool
---@field public IsUsingCameraYInverted bool
---@field public IsUsingGamepadCameraSensitivity bool
---@field public MasterVolume float
---@field public MicroProfilerWebServerEnabled bool
---@field public MicroProfilerWebServerIP string
---@field public MicroProfilerWebServerPort int
---@field public MouseSensitivity float
---@field public MouseSensitivityFirstPerson Vector2
---@field public MouseSensitivityThirdPerson Vector2
---@field public OnScreenProfilerEnabled bool
---@field public OnboardingsCompleted string
---@field public PerformanceStatsVisible bool
---@field public RCCProfilerRecordFrameRate int
---@field public RCCProfilerRecordTimeFrame int
---@field public RotationType RotationType
---@field public SavedQualityLevel SavedQualitySetting
---@field public StartMaximized bool
---@field public StartScreenPosition Vector2
---@field public StartScreenSize Vector2
---@field public TouchCameraMovementMode TouchCameraMovementMode
---@field public TouchMovementMode TouchMovementMode
---@field public UsedCoreGuiIsVisibleToggle bool
---@field public UsedCustomGuiIsVisibleToggle bool
---@field public UsedHideHudShortcut bool
---@field public VREnabled bool
---@field public VRRotationIntensity int
---@field public VignetteEnabled bool
---@field public FullscreenChanged RBXScriptSignal.FullscreenChanged
---@field public PerformanceStatsVisibleChanged RBXScriptSignal.PerformanceStatsVisibleChanged
---@field public StudioModeChanged RBXScriptSignal.StudioModeChanged
---The UserGameSettings is a singleton class found inside of the `UserSettings`
---singleton. It holds various persistent settings relating to how the user wants
---to control their camera, and their character.
---
---You can access this object from a `LocalScript` via:
---
---```lua
---UserSettings():GetService("UserGameSettings")
---```
---
---This object is intended to be used on the client only, as it serves no purpose
---on the server. It will also reflect your own settings when testing in Roblox
---Studio.
---
local UserGameSettings;
---
UserGameSettings.AllTutorialsDisabled = nil;
---
UserGameSettings.CameraMode = nil;
---
UserGameSettings.CameraYInverted = nil;
---
UserGameSettings.ChatVisible = nil;
---The camera movement mode currently in-use by the client on desktop.
---
UserGameSettings.ComputerCameraMovementMode = nil;
---The type of controls being used by the client on desktop.
---
UserGameSettings.ComputerMovementMode = nil;
---Toggles whether or not the client can use the Mouse Lock Switch mode.
---
UserGameSettings.ControlMode = nil;
---
UserGameSettings.DefaultCameraID = nil;
---
UserGameSettings.Fullscreen = nil;
---Describes how sensitive the camera is when using a gamepad.
---
UserGameSettings.GamepadCameraSensitivity = nil;
---
UserGameSettings.GraphicsQualityLevel = nil;
---
UserGameSettings.HasEverUsedVR = nil;
---
UserGameSettings.IsUsingCameraYInverted = nil;
---
UserGameSettings.IsUsingGamepadCameraSensitivity = nil;
---A <a href="/scripting/luau/numbers">float</a> between 0 and 1 representing
---the volume of the game's client.
---
UserGameSettings.MasterVolume = nil;
---
UserGameSettings.MicroProfilerWebServerEnabled = nil;
---
UserGameSettings.MicroProfilerWebServerIP = nil;
---
UserGameSettings.MicroProfilerWebServerPort = nil;
---A <a href="/scripting/luau/numbers">float</a> between 0 and 100
---representing the sensitivity of the client's mouse.
---
UserGameSettings.MouseSensitivity = nil;
---
UserGameSettings.MouseSensitivityFirstPerson = nil;
---
UserGameSettings.MouseSensitivityThirdPerson = nil;
---
UserGameSettings.OnScreenProfilerEnabled = nil;
---
UserGameSettings.OnboardingsCompleted = nil;
---
UserGameSettings.PerformanceStatsVisible = nil;
---
UserGameSettings.RCCProfilerRecordFrameRate = nil;
---
UserGameSettings.RCCProfilerRecordTimeFrame = nil;
---Controls how the client's character is rotated.
---
UserGameSettings.RotationType = nil;
---The graphics quality level set by the client.
---
UserGameSettings.SavedQualityLevel = nil;
---
UserGameSettings.StartMaximized = nil;
---
UserGameSettings.StartScreenPosition = nil;
---
UserGameSettings.StartScreenSize = nil;
---The camera type in-use by the client while on a mobile device.
---
UserGameSettings.TouchCameraMovementMode = nil;
---The type of controls being used by the client on a mobile device.
---
UserGameSettings.TouchMovementMode = nil;
---
UserGameSettings.UsedCoreGuiIsVisibleToggle = nil;
---
UserGameSettings.UsedCustomGuiIsVisibleToggle = nil;
---
UserGameSettings.UsedHideHudShortcut = nil;
---
UserGameSettings.VREnabled = nil;
---
UserGameSettings.VRRotationIntensity = nil;
---
UserGameSettings.VignetteEnabled = nil;
---@param tutorialId string
---@return bool
UserGameSettings.GetTutorialState = function(self, tutorialId) end;
---@return void
---If called, Roblox toggles the menu option to invert the user's camera y
---axis.
---
UserGameSettings.SetCameraYInvertVisible = function(self) end;
---@return void
---If called, Roblox toggles the menu option to control the camera
---sensitivity with gamepads.
---
UserGameSettings.SetGamepadCameraSensitivityVisible = function(self) end;
---@return bool
---Returns true if the user's Roblox window is in full screen mode.
---
UserGameSettings.InFullScreen = function(self) end;
---@param onboardingId string
---@return bool
---Checks whether or not the given onboarding has been completed yet, which
---is useful for avoiding showing the onboarding animation again.
---
---If onboardingId is not one of the accepted IDs, an error is thrown.
---
---The onboarding process is one-way. This means that, as a developer, you
---can force the onboarding process to completion but cannot reset it.
---
---See also:
---
---- `UserGameSettings/SetOnboardingCompleted`, sets onboarding as completed
---
UserGameSettings.GetOnboardingCompleted = function(self, onboardingId) end;
---@param tutorialId string
---@param value bool
---@return void
UserGameSettings.SetTutorialState = function(self, tutorialId, value) end;
---@return bool
---Returns true if the client's game session is in Roblox Studio.
---
UserGameSettings.InStudioMode = function(self) end;
---@param onboardingId string
---@return void
---Sets the given onboarding as completed, so it won't be shown again to the
---user the next time they play.
---
---Currently, this function only accepts [DynamicThumbstick][1], and it is
---used to persistently track whether or not the player has finished the
---tutorial for the Dynamic Thumbstick control scheme. If onboardingId is not
---one of the accepted IDs, an error is thrown.
---
---The onboarding process is one-way. This means that, as a developer, you
---can force the onboarding process to completion but cannot reset it.
---
---See also:
---
---- `UserGameSettings/GetOnboardingCompleted`, checks if onboarding has been
---  completed
---
---[1]: /scripting/luau/strings
---
UserGameSettings.SetOnboardingCompleted = function(self, onboardingId) end;
---@return int
---Returns the camera's Y-invert value.
---
UserGameSettings.GetCameraYInvertValue = function(self) end;
---@param onboardingId string
---@return void
UserGameSettings.ResetOnboardingCompleted = function(self, onboardingId) end;
---@class RBXScriptSignal.FullscreenChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.FullscreenChanged, callback: fun(isFullscreen: bool)): RBXScriptConnection
---Fires if the user's full screen mode is changed. The event will only fire
---on desktop devices that can toggle full screen mode. The game will always
---be in full screen on mobile devices and consoles.
---
UserGameSettings.FullscreenChanged = nil;
---@class RBXScriptSignal.PerformanceStatsVisibleChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.PerformanceStatsVisibleChanged, callback: fun(isPerformanceStatsVisible: bool)): RBXScriptConnection
---
UserGameSettings.PerformanceStatsVisibleChanged = nil;
---@class RBXScriptSignal.StudioModeChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.StudioModeChanged, callback: fun(isStudioMode: bool)): RBXScriptConnection
---Fired when the user's client switches between studio mode and in-game
---mode. This gets fired periodically in Roblox Studio when a session starts.
---
UserGameSettings.StudioModeChanged = nil;
---@class UserInputService : Instance
---@field public AccelerometerEnabled bool
---@field public BottomBarSize Vector2
---@field public GamepadEnabled bool
---@field public GazeSelectionEnabled bool
---@field public GyroscopeEnabled bool
---@field public KeyboardEnabled bool
---@field public LegacyInputEventsEnabled bool
---@field public ModalEnabled bool
---@field public MouseBehavior MouseBehavior
---@field public MouseDeltaSensitivity float
---@field public MouseEnabled bool
---@field public MouseIconEnabled bool
---@field public NavBarSize Vector2
---@field public OnScreenKeyboardAnimationDuration double
---@field public OnScreenKeyboardPosition Vector2
---@field public OnScreenKeyboardSize Vector2
---@field public OnScreenKeyboardVisible bool
---@field public OverrideMouseIconBehavior OverrideMouseIconBehavior
---@field public RightBarSize Vector2
---@field public StatusBarSize Vector2
---@field public TouchEnabled bool
---@field public UserHeadCFrame CFrame
---@field public VREnabled bool
---@field public DeviceAccelerationChanged RBXScriptSignal.DeviceAccelerationChanged
---@field public DeviceGravityChanged RBXScriptSignal.DeviceGravityChanged
---@field public DeviceRotationChanged RBXScriptSignal.DeviceRotationChanged
---@field public GamepadConnected RBXScriptSignal.GamepadConnected
---@field public GamepadDisconnected RBXScriptSignal.GamepadDisconnected
---@field public InputBegan RBXScriptSignal.InputBegan
---@field public InputChanged RBXScriptSignal.InputChanged
---@field public InputEnded RBXScriptSignal.InputEnded
---@field public JumpRequest RBXScriptSignal.JumpRequest
---@field public LastInputTypeChanged RBXScriptSignal.LastInputTypeChanged
---@field public PointerAction RBXScriptSignal.PointerAction
---@field public StatusBarTapped RBXScriptSignal.StatusBarTapped
---@field public TextBoxFocusReleased RBXScriptSignal.TextBoxFocusReleased
---@field public TextBoxFocused RBXScriptSignal.TextBoxFocused
---@field public TouchEnded RBXScriptSignal.TouchEnded
---@field public TouchLongPress RBXScriptSignal.TouchLongPress
---@field public TouchMoved RBXScriptSignal.TouchMoved
---@field public TouchPan RBXScriptSignal.TouchPan
---@field public TouchPinch RBXScriptSignal.TouchPinch
---@field public TouchRotate RBXScriptSignal.TouchRotate
---@field public TouchStarted RBXScriptSignal.TouchStarted
---@field public TouchSwipe RBXScriptSignal.TouchSwipe
---@field public TouchTap RBXScriptSignal.TouchTap
---@field public TouchTapInWorld RBXScriptSignal.TouchTapInWorld
---@field public UserCFrameChanged RBXScriptSignal.UserCFrameChanged
---@field public WindowFocusReleased RBXScriptSignal.WindowFocusReleased
---@field public WindowFocused RBXScriptSignal.WindowFocused
---The `UserInputService` is a service used to detect and capture the different
---types of input available on a user's device.
---
---The primary purpose of this service is to allow for games to cooperate with
---multiple forms of available input - such as gamepads, touch screens, and
---keyboards. It allows a `LocalScript` to perform different actions depending on
---the device, and in turn, helps developers provide the best experience for the
---end user.
---
---Some usages of this service include detecting user input when they interact
---with GUIs, tools, and other game instances. In order to detect user input, the
---service must look for a service event. For example, the service can detect
---events such as when the user touches the screen of a mobile device using
---`UserInputService/TouchStarted`, or connects a gamepad such as an Xbox
---controller to their device using `UserInputService/GamepadConnected`.
---
---Since this service is client-side only, it will only work when used in a
---`LocalScript` or a `ModuleScript` required by a `LocalScript`. As
---UserInputService is client-side only, users in the game can only detect their
---own input - and not the input of others.
---
---See also:
---
---- `ContextActionService`, a service which allows you to bind functions to
---  multiple user inputs
---
local UserInputService;
---This property describes whether the the user's device has an accelerometer
---
---An accelerometer is a component found in most mobile devices that measures
---acceleration (change in speed).
---
---For example, the following code snippet demonstrates how to check if the
---user's device has an accelerometer.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---local accelerometerEnabled = oserInputService.AccelerometerEnabled
---if accelerometerEnabled then
---	print("Accelerometer enabled!")
---else
---	print("Accelerometer not enabled!")
---end
---```
---
---If the device has an enabled accelerometer, you can get it's current
---acceleration by using the `UserInputService/GetDeviceAcceleration`
---function or track when the device's acceleration changes by using the
---`UserInputService/DeviceAccelerationChanged` event.
---
---As `UserInputService` is client-side only, this property can only be used
---in a `LocalScript`.
---
UserInputService.AccelerometerEnabled = nil;
---
UserInputService.BottomBarSize = nil;
---This property describes whether the device being used by a user has an
---available gamepad.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---if userInputService.GamepadEnabled then
---	print("Gamepad enabled")
---else
---	print("Gamepad not enabled")
---end
---```
---
---If gamepads are available, you can use
---`UserInputService/GetConnectedGamepads` to retrieve a list of connected
---gamepads and `UserInputService/GetNavigationGamepads` to retrieve a list
---of connected gamepads that also controlnavigation GUIs.
---
---As `UserInputService` is client-side only, this property can only be used
---in a `LocalScript`.
---
---See [this][1] page for articles on cross-platform development.
---
---See also:
---
---- `UserInputService/GamepadConnected`
---- `UserInputService/GamepadDisconnected`
---- `UserInputService/GetConnectedGamepads`
---- `UserInputService/GetNavigationGamepads`
---- `UserInputService/SetNavigationGamepad`
---- `UserInputService/IsNavigationGamepad`
---- `UserInputService/IsGamepadButtonDown`
---- `UserInputService/GetSupportedGamepadKeyCodes`
---- `UserInputService/GetGamepadState`
---- `UserInputService/GetGamepadConnected`
---- `UserInputService/GamepadSupports`
---
---[1]: /learn-roblox/cross-platform
---
UserInputService.GamepadEnabled = nil;
---
UserInputService.GazeSelectionEnabled = nil;
---This property describes whether the user's device has a gyroscope.
---
---A gyroscope is an component found in most mobile devices that detects
---orientation and rotational speed.
---
---If a user's device has a gyroscope, you can use incorporate it into your
---game using the `UserInputService/GetDeviceRotation` function and
---`UserInputService/DeviceRotationChanged` event.
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---local gyroIsEnabled = UserInputService.GyroscopeEnabled
---if (gyroIsEnabled) then
---    print("Gyroscope is enabled!")
---else
---    print("Gyroscope is not enabled!")
---end
---```
---
---As `UserInputService` is client-side only, this property can only be used
---in a `LocalScript`.
---
---See [this][1] page for articles on cross-platform development.
---
---[1]: /learn-roblox/cross-platform
---
UserInputService.GyroscopeEnabled = nil;
---This property describes whether the user's device has a keyboard
---available. This property is _true_ when the user's device has an available
---keyboard, and _false_ when it does not.
---
---It can be used to determine whether the user has an available keyboard -
---which can be important if you want to check if you can use
---`UserInputService/IsKeyDown` or `UserInputService/GetKeysPressed` to check
---for keyboard input.
---
---As `UserInputService` is client-side only, this property can only be used
---in a `LocalScript`.
---
UserInputService.KeyboardEnabled = nil;
---
UserInputService.LegacyInputEventsEnabled = nil;
---**ModalEnabled** property determines whether character controls are hidden
---on `UserInputService/TouchEnabled|TouchEnabled` devices. By default, this
---property is _false_ and controls are visible.
---
---![ModalEnabled = false][1]
---
---![ModalEnabled = true][2]
---
---This property will only work when used in a `LocalScript` running for the
---player whose character controls are to be hidden.
---
---Even if mobile controls are hidden for a player on a mobile device, other
---UserInputService events such as `UserInputService/InputBegan` and
---`UserInputService/TouchSwipe` can still be used to process other forms of
---user input on mobile devices with an enabled touch screen (see the main
---UserInputService class page for a full list).
---
---[1]: /assets/blt0785000a560d8788/UISModalEnabledFalse.png
---[2]: /assets/bltb592006955fd388d/UISModalEnabledTrue.png
---
UserInputService.ModalEnabled = nil;
---This property sets how the user's mouse behaves based on the
---`Enum/MouseBehavior` Enum. The default value is
---Enum.MouseBehavior.Default.
---
---It can be set to three values:
---
---1.  _Default_: The mouse moves freely around the user's screen.
---2.  _LockCenter_: The mouse is locked, and cannot move from, the center of
---    the user's screen.
---3.  _LockCurrentPosition_: The mouse is locked, and cannot move from, it's
---    current position on the user's screen at the time of locking.
---
---The value of this property does not affect the sensitivity of events
---tracking mouse movement. For example,
---`UserInputService/GetMouseDelta|GetMouseDelta` returns the same
---`DataType/Vector2|Vector2` screen position in pixels regardless of whether
---the mouse is locked or able to move freely around the user's screen. As a
---result, default scripts like those controlling the camera are not impacted
---by this property.
---
---This property is overridden if a `GuiButton` with `GuiButton/Modal|Modal`
---enabled is `GuiButton/Visible` unless the player's right mouse button is
---down.
---
---Note that, if the mouse is locked, `UserInputService/InputChanged` will
---still fire when the player moves the mouse and will pass in the Delta that
---the mouse attempted to move by. Additionally, if the player is kicked from
---the game, the mouse will be forcefully unlocked.
---
---As `UserInputService` is client-side only, this property can only be used
---in a `LocalScript`.
---
UserInputService.MouseBehavior = nil;
---This property determines the sensitivity of the user's `Mouse`.
---
---The sensitivity determines the extent to which a movement of the physical
---mouse translates to a movement of the mouse in-game. This can be used to
---adjusted how sensitive events tracking mouse movement, like
---`UserInputService/GetMouseDelta|GetMouseDelta`, are to mouse movement.
---
---This property does not affect the movement of the mouse icon. Nor does it
---affect the _Camera Sensitivity_ setting found in the _Settings_ tab of the
---client's _Settings_ menu, which also adjusts the sensitivity of events
---tracking mouse movement.
---
---This property has a maximum value of 10 and a minimum value of 0. A lower
---value corresponds to lower sensitivity, and a higher value to higher
---sensitivity.
---
---When sensitivity is 0, events that track the mouse's movement will still
---fire but all parameters and properties indicating the change in mouse
---position will return `DataType/Vector2|Vector2.new()`, or
---`DataType/Vector3|Vector3.new()` in the case of
---`InputObject/Delta|InputObject.Delta`. For example,
---`UserInputService/GetMouseDelta|GetMouseDelta` will always return (0, 0).
---
UserInputService.MouseDeltaSensitivity = nil;
---This property describes whether the user's device has a mouse available.
---This property is _true_ when the user's device has an available mouse, and
---_false_ when it does not.
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---if (UserInputService.MouseEnabled) then
---    print("The user's device has an available mouse!")
---else
---    print("The user's device does not have an available mouse!")
---end
---```
---
---It is important to check this before using `UserInputService` mouse
---functions such as `UserInputService/GetMouseLocation`.
---
---As `UserInputService` is client-side only, this property can only be used
---in a `LocalScript`.
---
---See also:
---
---- `UserInputService/MouseBehavior`
---- `UserInputService/MouseDeltaSensitivity`
---- `UserInputService/MouseIconEnabled`
---- `UserInputService/GetMouseLocation`
---- `UserInputService/GetMouseDelta`
---- `UserInputService/GetMouseButtonsPressed`
---
UserInputService.MouseEnabled = nil;
---This property determines whether the `Mouse|Mouse's` icon is visible When
---_true_ the mouse's icon is visible, when _false_ it is not.
---
---For example, the code snippet below hides the mouse's icon.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---userInputService.MouseIconEnabled = false
---```
---
---As `UserInputService` is client-side only, this property can only be used
---in a `LocalScript`.
---
UserInputService.MouseIconEnabled = nil;
---
UserInputService.NavBarSize = nil;
---
UserInputService.OnScreenKeyboardAnimationDuration = nil;
---This property describes the position of the on-screen keyboard in pixels.
---The keyboard's position is `DataType/Vector2|Vector2.new(0, 0)` when it is
---not `UserInputService/OnScreenKeyboardVisible|visible`.
---
---The code snippet below prints the position of the keyboard.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---print(userInputService.OnScreenKeyboardPosition)
---```
---
---As `UserInputService` is client-side only, this property can only be used
---in a `LocalScript`.
---
---![On screen keyboard][1]
---
---See also:
---
---- `UserInputService/OnScreenKeyboardVisible`
---- `UserInputService/OnScreenKeyboardSize`
---
---[1]: /assets/bltd883fb9830c26628/ClientKeyboard.png
---
UserInputService.OnScreenKeyboardPosition = nil;
---This property describes the size of the on-screen keyboard in pixels. The
---keyboard's size is `DataType/Vector2|Vector2.new(0, 0)` when it is not
---`UserInputService/OnScreenKeyboardVisible|visible`.
---
---The code snippet below prints the size of the keyboard.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---print(userInputService.OnScreenKeyboardSize)
---```
---
---As `UserInputService` is client-side only, this property can only be used
---in a `LocalScript`.
---
---![On screen keyboard][1]
---
---See also:
---
---- `UserInputService/OnScreenKeyboardVisible`
---- `UserInputService/OnScreenKeyboardPosition`
---
---[1]: /assets/bltd883fb9830c26628/Screenshot_(6).png
---
UserInputService.OnScreenKeyboardSize = nil;
---This property describes whether an on-screen keyboard is currently visible
---on the user's screen.
---
---The code snippet below prints whether the keyboard is visible.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---local keyboardIsVisible = userInputService.OnScreenKeyboardIsVisible
---if (keyboardIsVisible) then
---	print("On-screen keyboard is visible!")
---else
---	print("On-screen keyboard is not visible!")
---end
---```
---
---As `UserInputService` is client-side only, this property can only be used
---in a `LocalScript`.
---
---![On screen keyboard][1]
---
---See also:
---
---- `UserInputService/OnScreenKeyboardSize`
---- `UserInputService/OnScreenKeyboardPosition`
---
---[1]: /assets/bltd883fb9830c26628/ClientKeyboard.png
---
UserInputService.OnScreenKeyboardVisible = nil;
---
UserInputService.OverrideMouseIconBehavior = nil;
---
UserInputService.RightBarSize = nil;
---
UserInputService.StatusBarSize = nil;
---This property describes whether the user's current device has a touch
---screen available.
---
---The property is used to determine if the user's device has a touch screen,
---and therefore if touch events will fire. If TouchEnabled is true, you can
---use UserInputService events such as `UserInputService/TouchStarted` and
---`UserInputService/TouchEnded` to track when a user starts and stops
---touching the screen of their device.
---
---The code snippet below prints whether the user's device has a touch
---screen.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---if userInputService.TouchEnabled then
---	print("The user's device has a touchscreen!")
---else
---	print("The user's device does not have a touchscreen!")
---end
---```
---
---See [this][1] page for articles on cross-platform development.
---
---[1]: /learn-roblox/cross-platform
---
---See also:
---
---- `UserInputService/TouchTap`
---- `UserInputService/TouchLongPress`
---- `UserInputService/TouchMoved`
---- `UserInputService/TouchPan`
---- `UserInputService/TouchPinch`
---- `UserInputService/TouchRotate`
---- `UserInputService/TouchSwipe`
---- `UserInputService/TouchStarted`
---- `UserInputService/TouchEnded`
---
UserInputService.TouchEnabled = nil;
---The UserHeadCFrame used to describe the orientation and position of a
---user's head, if they are actively using a virtual reality headset.
---
---Deprecated in favor of `UserInputService/GetUserCFrame|GetUserCFrame`.
---
UserInputService.UserHeadCFrame = nil;
---This property describes whether the user is using a virtual reality (VR)
---device.
---
---If a VR device is enabled, you can interact with its location and movement
---through functions such as
---` UserInputService/GetUserCFrame``. You can also react to VR device movement using the  `UserInputService/UserCFrameChanged`
---event.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---local isUsingVR = userInputService.VREnabled
---if (isUsingVR) then
---    print("User is using a VR headset!")
---else
---    print("User is not using a VR headset!")
---end
---```
---
---As `UserInputService` isclient-side only, this property can only be used
---in a `LocalScript`.
---
---See [this][1] article for VR best practices.
---
---See also:
---
---- `VRService`
---- `Camera/HeadLocked`
---- `UserInputService/GetUserCFrame`
---- `UserInputService/UserCFrameChanged`
---
---[1]: https://developer.roblox.com/articles/Virtual-Reality-Best-Practices
---
UserInputService.VREnabled = nil;
---@return InputObject
---This function returns an `InputObject` describing the device's current
---gravity vector.
---
---The gravity vector is determined by the device's orientation relative to
---the real-world force of gravity. For instance, if a device is perfectly
---upright (portrait), the gravity vector is
---`DataType/Vector3|Vector3.new(0, 0, -9.18)`. If the left side of the
---device is pointing down, the vector is Vector3.new(9.81, 0, 0). Finally,
---if the back of the device is pointing down, the vector is Vector3.new(0,
----9.81, 0).
---
---This function might be used to enable the user's device to impact or
---control gravity within the game or move in-game objects such as a ball.
---
---Gravity is only tracked for players using a device with an enabled
---gyroscope - such as a mobile device.
---
---To check if a user's device has an enabled gyroscope, check the value of
---`UserInputService/GyroscopeEnabled`. If the device has an enabled
---gyroscope, you can also use the `UserInputService/DeviceGravityChanged`
---event to track when force of gravity on the user's device changes.
---
---As `UserInputService` is client-side only, this function can only be used
---in a `LocalScript`.
---
UserInputService.GetDeviceGravity = function(self) end;
---@return Tuple
---This function returns an `InputObject` and a `DataType/CFrame` describing
---the device's current rotation vector.
---
---This is fired with an InputObject. The _Position_ property of the input
---object is a `Enum/InputType|Enum.InputType.Gyroscope` that tracks the
---total rotation in each local device axis.
---
---Device rotation can only be tracked on devices with a
---`UserInputService/GyroscopeEnabled|gyroscope`.
---
---As this function fires locally, it can only be used in a `LocalScript`.
---
UserInputService.GetDeviceRotation = function(self) end;
---@param keyCode KeyCode
---@return bool
---This function returns whether the user is holding down the key associated
---with the given `Enum/KeyCode`. It returns _true_ if the specified key is
---pressed or _false_ if it is not pressed.
---
---This can be used to check if a specific key, such as the space bar, is
---being pressed. For example:
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---local spaceHeld = UserInputService:IsKeyDown(Enum.KeyCode.Space)
---```
---
---To retrieve a list of all keys pressed by the user, use the
---`UserInputService/GetKeysPressed` function.
---
---Since `UserInputService` is client-side only, this function can only be
---used in a `LocalScript`.
---
---See also:
---
---- `UserInputType/IsGamepadButtonDown` - A similar event with a different
---  use: To check if a given `Enum/KeyCode|button` on a
---  `Enum/UserInputType|gamepad` is pressed.
---
UserInputService.IsKeyDown = function(self, keyCode) end;
---@return Vector2
---This function returns a `DataType/Vector2` representing the current screen
---location of the player's `Mouse` in pixels relative to the top left
---corner. This does not account for the `GuiObject|GUI` inset.
---
---If the location of the mouse pointer is offscreen or the players device
---does not have a mouse, the value returned will be undetermined instead of
---Vector2.
---
---As `UserInputService` is client-side only, this function can only be used
---in a `LocalScript`.
---
UserInputService.GetMouseLocation = function(self) end;
---@param gamepadEnum UserInputType
---@param enabled bool
---@return void
---The SetNavigationGamepad function sets whether the specified
---`Enum/UserInputType` gamepad can move the GUI navigator. A gamepad that is
---allowed to move the GUI navigator is considered a _navigation gamepad_.
---
---If the _enabled_ argument is passed as _true_, the Gamepad can move the
---GUI navigator. If the argument is _false_, the Gamepad can not move the
---GUI navigator.
---
---If you want to check if a specified Gamepad is a set to be a navigation
---gamepad, you can use the `UserInputService/IsNavigationGamepad` function.
---You can also use the `UserInputService/GetNavigationGamepads` to retrieve
---a list of all navigation gamepads.
---
---Since `UserInputService` is client-side only, this function can only be
---used in a `LocalScript`.
---
---See [this][1] page for articles on cross-platform development.
---
---See also:
---
---- `UserInputService/GamepadConnected`
---- `UserInputService/GamepadDisconnected`
---- `UserInputService/GetConnectedGamepads`
---- `UserInputService/GetNavigationGamepads`
---- `UserInputService/IsNavigationGamepad`
---- `UserInputService/IsGamepadButtonDown`
---- `UserInputService/GetSupportedGamepadKeyCodes`
---- `UserInputService/GetGamepadState`
---- `UserInputService/GetGamepadConnected`
---- `UserInputService/GamepadSupports`
---- `UserInputService/GamepadEnabled`
---
---[1]: /learn-roblox/cross-platform
---
UserInputService.SetNavigationGamepad = function(self, gamepadEnum, enabled) end;
---@return DeviceType
UserInputService.GetDeviceType = function(self) end;
---@return Array
---This function returns an array of gamepad
---`Enum/UserInputType|UserInputTypes` that are connected and enabled for GUI
---navigation. This list is in descending order of priority, meaning it can
---be iterated over to determine which gamepad should have navigation
---control.
---
---Whether a connected gamepad is a navigation gamepad only determines which
---gamepad(s) control the navigation GUIs. This does not influence navigation
---controls.
---
---Since `UserInputService` is client-side only, this function can only be
---used in a `LocalScript`.
---
---See also:
---
---- `UserInputService/SetNavigationGamepad`, to enable or disable a gamepad
---  for GUI navigation
---- `UserInputService/IsNavigationGamepad`, to verify if a gamepad is
---  enabled for GUI navigation
---- `UserInputService/GetConnectedGamepads`, to return all gamepads
---  connected regardless of GUI navigational control
---
UserInputService.GetNavigationGamepads = function(self) end;
---@return Platform
UserInputService.GetPlatform = function(self) end;
---@param gamepadEnum UserInputType
---@return bool
---This function returns _true_ if the specified `Enum/UserInputType` Gamepad
---is allowed to control Navigation and Selection `GuiObject|GUIs`.
---
---If you want to set a navigation gamepad, you can use
---`UserInputService/SetNavigationGamepad`. You can also use
---`UserInputService/GetNavigationGamepads` to get a list of all navigation
---gamepads.
---
---For example, the code below checks if the gamepad1 is as a navigation
---gamepad:
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---if (userInputService:IsNavigationGamepad(UserInputType.Gamepad1) then
---	print("Gamepad is a navigation gamepad!")
---else
---	print("Gamepad is not a navigation gamepad!")
---end
---```
---
---A list of all connected gamepads, regardless of navigation can be
---retrieved using`UserInput/GetConnectedGamepads.
---
---Since `UserInputService` is client-side only, this function can only be
---used in a `LocalScript`.
---
---See [this][1] page for articles on cross-platform development.
---
---See also:
---
---- `UserInputService/GamepadConnected`
---- `UserInputService/GamepadDisconnected`
---- `UserInputService/GetConnectedGamepads`
---- `UserInputService/GetNavigationGamepads`
---- `UserInputService/SetNavigationGamepad`
---- `UserInputService/IsGamepadButtonDown`
---- `UserInputService/GetSupportedGamepadKeyCodes`
---- `UserInputService/GetGamepadState`
---- `UserInputService/GetGamepadConnected`
---- `UserInputService/GamepadSupports`
---- `UserInputService/GamepadEnabled`
---
---[1]: /learn-roblox/cross-platform
---
UserInputService.IsNavigationGamepad = function(self, gamepadEnum) end;
---@param gamepadNum UserInputType
---@return bool
---This function returns whether a gamepad with the given
---`Enum/UserInputType` is connected to the client.
---
---This can be used to check if a specific gamepad, such as _'Gamepad1'_ is
---connected to the client's device.
---
---To retrieve a list of all connected gamepads, use
---`UserInputService/GetConnectedGamepads`.
---
---As `UserInputService` is client-side only, this function can only be used
---in a `LocalScript`.
---
---Check out this [article][2] to learn more about adding support for gamepad
---input into your game and [this][1] page for articles on cross-platform
---development.
---
---See also:
---
---- `UserInputService/GamepadConnected`
---- `UserInputService/GamepadDisconnected`
---- `UserInputService/GetConnectedGamepads`
---- `UserInputService/GetNavigationGamepads`
---- `UserInputService/SetNavigationGamepad`
---- `UserInputService/IsNavigationGamepad`
---- `UserInputService/IsGamepadButtonDown`
---- `UserInputService/GetSupportedGamepadKeyCodes`
---- `UserInputService/GetGamepadState`
---- `UserInputService/GamepadSupports`
---- `UserInputService/GamepadEnabled`
---
---[1]: /learn-roblox/cross-platform
---[2]: https://developer.roblox.com/articles/Gamepad-Haptic-Feedback
---
UserInputService.GetGamepadConnected = function(self, gamepadNum) end;
---@param gamepadNum UserInputType
---@param gamepadKeyCode KeyCode
---@return bool
---This function returns whether the given `Enum/UserInputType` gamepad
---supports a button corresponding with the given `Enum//KeyCode`. This
---function is used to determine valid gamepad inputs.
---
---To determine which `Enum/UserInputType` gamepads are connected, use
---`UserInputService/GetConnectedGamepads`.
---
---As `UserInputService` is client-side only, this function can only be used
---in a `LocalScript`.
---
---See [this][1] page for articles on cross-platform development.
---
---See also:
---
---- `UserInputService/GamepadConnected`
---- `UserInputService/GamepadDisconnected`
---- `UserInputService/GetConnectedGamepads`
---- `UserInputService/GetNavigationGamepads`
---- `UserInputService/SetNavigationGamepad`
---- `UserInputService/IsNavigationGamepad`
---- `UserInputService/IsGamepadButtonDown`
---- `UserInputService/GetSupportedGamepadKeyCodes`
---- `UserInputService/GetGamepadState`
---- `UserInputService/GetGamepadConnected`
---- `UserInputService/GamepadEnabled`
---
---[1]: /learn-roblox/cross-platform
---
UserInputService.GamepadSupports = function(self, gamepadNum, gamepadKeyCode) end;
---@param type UserCFrame
---@return CFrame
---The GetUserCFrame function returns a `DataType/CFrame` describing the
---position and orientation of a specified `Enum/UserCFrame` virtual reality
---(VR) device. If the specified device is not connected, the function
---returns `DataType/CFrame|CFrame.new()`.
---
---For example, the code snippet below prints the CFrame of the user's VR
---headset.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---local cframe = userInputService:GetUserCFrame(Enum.UserCFrame.Head)
---
---print(cframe)
---```
---
---By using the function, players can implement features such as
---re-positioning the user's in-game character corresponding to the location
---of a connected VR device. This can be done by changing the _CFrame_ of the
---user's in-game body parts to match the _CFrame_ of the specified VR device
---using `Enum/UserCFrame` and `DataType/CFrame` value arguments passed by
---the event.
---
---See also:
---
---- `UserInputService/UserCFrameChanged`, an event which fires when the
---  `DataType/CFrame` of a VR device changes
---- `VRService`, a service used to implement VR support
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
UserInputService.GetUserCFrame = function(self, type) end;
---@param gamepadNum UserInputType
---@return Array
---This function returns an array of `InputObject|InputObjects` for all
---available inputs on the given `Enum/UserInputType` gamepad, representing
---each input's last input state.
---
---To find the `Enum/UserInputType|UserInputTypes` of connected gamepads, use
---`UserInputService/GetConnectedGamepads`.
---
---As this function only fires locally, it can only be used in a
---`LocalScript`.
---
---See [this][1] page for articles on cross-platform development.
---
---See also:
---
---- `UserInputService/GamepadConnected`
---- `UserInputService/GamepadDisconnected`
---- `UserInputService/GetConnectedGamepads`
---- `UserInputService/GetNavigationGamepads`
---- `UserInputService/SetNavigationGamepad`
---- `UserInputService/IsNavigationGamepad`
---- `UserInputService/IsGamepadButtonDown`
---- `UserInputService/GetSupportedGamepadKeyCodes`
---- `UserInputService/GetGamepadConnected`
---- `UserInputService/GamepadSupports`
---- `UserInputService/GamepadEnabled`
---
---[1]: /learn-roblox/cross-platform
---
UserInputService.GetGamepadState = function(self, gamepadNum) end;
---@return void
---This function recenters the `DataType/CFrame` of the VR headset to the
---current orientation of the headset worn by the user. This means that the
---headset's current orientation is set to `CFrame.new()`.
---
---Use this function to to move the headset CFrame to the center of the play
---area if it seems to be at a weird offset.
---
---This behaves identically to the `VRService` function,
---`VRService/RecenterUserHeadCFrame`.
---
---Since `UserInputService` is client-side only, this function can only be
---used in a `LocalScript`.
---
UserInputService.RecenterUserHeadCFrame = function(self) end;
---@param mouseButton UserInputType
---@return bool
---This function takes a mouse button `Enum/UserInputType` and returns a bool
---that indicates whether it is currently pressed.
---
---The mouse button checked depends on the `Enum/UserInputType` value passed
---to the function as an argument. For example:
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---local pressed = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
---```
---
---Since `UserInputService` is client-side only, this function can only be
---used in a `LocalScript`."
---
UserInputService.IsMouseButtonPressed = function(self, mouseButton) end;
---@return Array
---This function returns an array of `InputObject|InputObjects` associated
---with the keys currently being pressed down.
---
---This array can be iterated through to determine which keys are currently
---being pressed, using the `InputObject/KeyCode` values.
---
---To check if a specific key is being pressed, use
---`UserInputService/IsKeyDown`.
---
---As `UserInputService` is client-side only, this function can only be used
---in a `LocalScript`.
---
UserInputService.GetKeysPressed = function(self) end;
---@param gamepadNum UserInputType
---@param gamepadKeyCode KeyCode
---@return bool
---This functions allows a developer to quickly check if a particular button
---is pressed on a particular gamepad. It returns true if the
---`Enum/UserInputType|gamepad` has the specified `Enum/KeyCode|button`
---pressed down, otherwise it returns false.
---
---#### Valid UserInputTypes
---
---The specified gamepad should be one of the following UserInputType enum
---values:
---
---<table>
---	<thead>
---		<tr>
---			<th>Name</th>
---		</tr>
---	</thead>
---	<tr>
---  <td>Enum.UserInputType.Gamepad1-8</td>
---  </tr>
---</table>
---
---#### Valid KeyCodes
---
---The specified button should be one of the following KeyCodes enum values:
---
---<table>
---	<thead>
---		<tr>
---			<th>Name</th>
---		</tr>
---	</thead>
---	<tr>
---  <td>Enum.KeyCode.ButtonX</td>
---  </tr>
---  <tr>
---  <td>Enum.KeyCode.ButtonY</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.ButtonA</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.ButtonB</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.ButtonR1</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.ButtonL1</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.ButtonR3</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.ButtonL3</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.ButtonStart</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.ButtonSelect</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.DPadLeft</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.DPadRight</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.DPadUp</td>
---  </tr>
---	<tr>
---  <td>Enum.KeyCode.DPadDown</td>
---  </tr>
---</table>
---
---This can be used to check whether a specific button, such as A, is being
---held down. For example:
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---local button = Enum.KeyCode.ButtonA
---local gamepad = Enum.UserInputType.Gamepad1
---
---local isButtonHeld = UserInputService:IsGamepadButtonDown(gamepad, button)
---```
---
---Since `UserInputService` is client-side only, this function can only be
---used in a `LocalScript`.
---
---See [this][1] page for articles on cross-platform development.
---
---See also:
---
---- `UserInputService/GamepadConnected`
---- `UserInputService/GamepadDisconnected`
---- `UserInputService/GetConnectedGamepads`
---- `UserInputService/GetNavigationGamepads`
---- `UserInputService/SetNavigationGamepad`
---- `UserInputService/IsNavigationGamepad`
---- `UserInputService/GetSupportedGamepadKeyCodes`
---- `UserInputService/GetGamepadState`
---- `UserInputService/GetGamepadConnected`
---- `UserInputService/GamepadSupports`
---- `UserInputService/GamepadEnabled`
---- `UserInputType/IsKeyDown` - A similar event with a different use: To
---  check if a given `Enum/KeyCode|key` on a `Enum/UserInputType|keyboard`
---  is pressed.
---
---[1]: /learn-roblox/cross-platform
---
UserInputService.IsGamepadButtonDown = function(self, gamepadNum, gamepadKeyCode) end;
---@param statusBarSize Vector2
---@param navBarSize Vector2
---@param bottomBarSize Vector2
---@param rightBarSize Vector2
---@return void
UserInputService.SendAppUISizes = function(self, statusBarSize, navBarSize, bottomBarSize, rightBarSize) end;
---@return Array
---This function returns an array of `Enum/UserInputType` gamepads currently
---connected. If no gamepads are connected, this array will be empty.
---Additionally, it only returns UserInputType objects that are gamepads. For
---instance, this event will return a connected Gamepad1 object but not a
---Keyboard object.
---
---For example, the following code snippet retrieves the connected gamepads
---and stores them in a variable named _connectedGamepads_.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---local connectedGamepads = userInputService:GetConnectedGamepads()
---```
---
---To check if a specific gamepad is connected, use
---`UserInputService/GetGamepadConnected`.
---
---As `UserInputService` is client-side only, this function can only be used
---in a `LocalScript`.
---
---See [this][1] page for articles on cross-platform development.
---
---See also:
---
---- `UserInputService/GamepadConnected`
---- `UserInputService/GamepadDisconnected`
---- `UserInputService/GetConnectedGamepads`
---- `UserInputService/GetNavigationGamepads`
---- `UserInputService/SetNavigationGamepad`
---- `UserInputService/IsNavigationGamepad`
---- `UserInputService/IsGamepadButtonDown`
---- `UserInputService/GetSupportedGamepadKeyCodes`
---- `UserInputService/GetGamepadState`
---- `UserInputService/GetGamepadConnected`
---- `UserInputService/GamepadSupports`
---- `UserInputService/GamepadEnabled`
---
---[1]: /learn-roblox/cross-platform
---
UserInputService.GetConnectedGamepads = function(self) end;
---@param gamepadNum UserInputType
---@return Array
---This function returns an array of `Enum/KeyCode|KeyCodes` that the gamepad
---associated with the given `Enum/UserInputType` supports.
---
---This function can be used to determine which KeyCodes are supported and
---not supported by a connected gamepad. To determine if a specific KeyCode
---is supported, use `UserInputService/GamepadSupports`.
---
---If called on a non existent, or non connected, gamepad, this function will
---return an empty array.
---
---As `UserInputService` is client-side only, this function can only be used
---in a `LocalScript`.
---
---Check out this [article][2] to learn more about adding support for gamepad
---input into your game and [this][1] page for articles on cross-platform
---development.
---
---See also:
---
---- `UserInputService/GamepadConnected`
---- `UserInputService/GamepadDisconnected`
---- `UserInputService/GetConnectedGamepads`
---- `UserInputService/GetNavigationGamepads`
---- `UserInputService/SetNavigationGamepad`
---- `UserInputService/IsNavigationGamepad`
---- `UserInputService/IsGamepadButtonDown`
---- `UserInputService/GetGamepadState`
---- `UserInputService/GetGamepadConnected`
---- `UserInputService/GamepadSupports`
---- `UserInputService/GamepadEnabled`
---
---[1]: /learn-roblox/cross-platform
---[2]: https://developer.roblox.com/articles/Gamepad-Haptic-Feedback
---
UserInputService.GetSupportedGamepadKeyCodes = function(self, gamepadNum) end;
---@param keyCode KeyCode
---@return string
---**GetStringForKeyCode** returns a string representing a key the user
---should press in order to input a given KeyCode, keeping in mind their
---keyboard layout. For KeyCodes that require some modifier to be held, this
---function returns the key to be pressed in addition to the modifier. See
---the examples below for further explanation.
---
---When using Roblox with a non-QWERTY keyboard layout, key codes are mapped
---to equivalent QWERTY positions. For example, pressing <kbd>A</kbd> on an
---AZERTY keyboard results in `Enum.KeyCode.Q`. This mapping can lead to
---mismatched information on game help menus. For example, "Press
---<kbd>M</kbd> to open Map" is inaccurate on an AZERTY keyboard; it would
---need to be "Press <kbd>?</kbd> to open Map", which is in the same position
---as M on QWERTY. This function solves this issue by providing the actual
---key to be pressed while using non-QWERTY keyboard layouts.
---
---#### Usage
---
---```
---local UserInputService = game:GetService("UserInputService")
---local textLabel = script.Parent
---local mapKey = Enum.KeyCode.M
---textLabel.Text = "Press " .. UserInputService:GetStringForKeyCode(mapKey) .. " to open the map!"
---```
---
---#### Examples on QWERTY Keyboard
---
---<table>
---<tr>
---  <td>KeyCode</td>
---  <td>Return Value</td>
---  </tr>
---<tr>
---  <td>
---
---`Enum.KeyCode.Q`
---
---</td>
---  <td>
---
---`Q`
---
---</td>
---  </tr>
---<tr>
---  <td>
---
---`Enum.KeyCode.W`
---
---</td>
---  <td>
---
---`W`
---
---</td>
---  </tr>
---<tr>
---  <td>
---
---`Enum.KeyCode.Equals`
---
---</td>
---  <td>
---
---`=`
---
---</td>
---  </tr>
---<tr>
---  <td>
---
---`Enum.KeyCode.At`
---
---</td>
---  <td>
---
---`2`, because `@` is typed with <kbd>Shift</kbd>+<kbd>2</kbd>
---
---</td>
---  </tr>
---</table>
---
---#### Examples on [AZERTY Keyboard](https://upload.wikimedia.org/wikipedia/commons/b/b9/KB_France.svg)
---
---<table>
---<tr>
---  <td>KeyCode</td>
---  <td>Return Value</td>
---  </tr>
---<tr>
---  <td>
---
---`Enum.KeyCode.Q`
---
---</td>
---  <td>
---
---`A`
---
---</td>
---  </tr>
---<tr>
---  <td>
---
---`Enum.KeyCode.W`
---
---</td>
---  <td>
---
---`Z`
---
---</td>
---  </tr>
---<tr>
---  <td>
---
---`Enum.KeyCode.Equals`
---
---</td>
---  <td>
---
---`=`
---
---</td>
---  </tr>
---<tr>
---  <td>
---
---`Enum.KeyCode.At`
---
---</td>
---  <td>
---
---`É`, see keyboard layout for comparison
---
---</td>
---  </tr>
---</table>
---
UserInputService.GetStringForKeyCode = function(self, keyCode) end;
---@return InputObject
---The GetDeviceAcceleration function determines the current acceleration of
---the user's device. It returns an `InputObject` that describes the device's
---current acceleration.
---
---In order for this to work, the user's device must have an enabled
---accelerometer. To check if a user's device has an enabled accelerometer,
---you can check the `UserInputService/AccelerometerEnabled` property.
---
---If you want to track when the user's device's acceleration changes
---instead, you can use the `UserInputService/DeviceAccelerationChanged`
---event.
---
---Since it only fires locally, it can only be used in a `LocalScript`.
---
UserInputService.GetDeviceAcceleration = function(self) end;
---@return Array
---This function returns an array of `InputObject|InputObjects` corresponding
---to the mouse buttons currently being pressed down.
---
---Mouse buttons that are tracked by this function include:
---
---<table>
---	<thead>
---	<tr>
---		<td>Name </td>
---		<td>Description</td>
---	</tr>
---	</thead>
---	<tr>
---		<td>MouseButton1</td>
---		<td>The left mouse button.</td>
---	</tr>
---	<tr>
---		<td>MouseButton2</td>
---		<td>The right mouse button.</td>
---	</tr>
---	<tr>
---		<td>MouseButton3</td>
---		<td>The middle mouse button.</td>
---	</tr>
---</table>
---
---If the user is not pressing any mouse button down when the function is
---called, it will return an empty array.
---
---As `UserInputService` is client-side only, this function can only be used
---in a `LocalScript`.
---
UserInputService.GetMouseButtonsPressed = function(self) end;
---@return UserInputType
---This function returns 'Enum/UserInputType` associated with the user's most
---recent input.
---
---For example, if the user's previous input had been pressing the spacebar,
---the `Enum/UserInputType` returned would be _'Keyboard'_.
---
---The `UserInputService/LastInputTypeChanged` event can be used to track
---when the last `Enum/UserInputType` used by the user changes.
---
---As `UserInputService` is client-side only, this function can only be used
---in a `LocalScript`.
---
UserInputService.GetLastInputType = function(self) end;
---@return TextBox
---This function returns the `TextBox` the client is currently focused on. A
---TextBox can be manually selected by the user, or selection can be forced
---using the `TextBox/CaptureFocus` function. If no TextBox is selected, this
---function will return _nil_.
---
---As `UserInputService` is client-side only, this function can only be used
---in a `LocalScript`.
---
---See also:
---
---- `UserInputService/TextBoxFocused`
---- `UserInputService/TextBoxFocusReleased`
---- `TextBox/CaptureFocus`
---- `TextBox/IsFocused`
---- `TextBox/ReleaseFocus`
---
UserInputService.GetFocusedTextBox = function(self) end;
---@return Vector2
---This function returns the change, in pixels, of the position of the
---player's `Mouse` in the last rendered frame as a `DataType/Vector2`. This
---function only works if the mouse has been locked using the
---`UserInputService.MouseBehavior` property. If the mouse has not been
---locked, the returned `DataType/Vector2` values will be zero.
---
---The sensitivity of the mouse, determined in the client's settings and
---`UserInputService/MouseDeltaSensitivity`, will influence the result.
---
---As `UserInputService` is client-side only, this function can only be used
---in a `LocalScript`.
---
UserInputService.GetMouseDelta = function(self) end;
---@class RBXScriptSignal.DeviceAccelerationChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.DeviceAccelerationChanged, callback: fun(acceleration: InputObject)): RBXScriptConnection
---The DeviceAccelerationChanged event fires when a user moves a device that
---has an accelerometer.
---
---An accelerometer is a component found in most mobile devices that measures
---acceleration (change in speed).
---
---To determine whether a user's device has an accelerometer enabled,
---see`UserInputService/AccelerometerEnabled`.
---
---This event can be used to track the movement of a device that has an
---accelerometer. A sample usage includes moving the player character when a
---mobile device accelerates.
---
---Additionally, this event can be used along with
---`UserInputService/GetDeviceAcceleration` to determine the current movement
---of a user's device if the device has an accelerometer.
---
---This event only fires locally - which means that only the player whose
---device moves can use the event and it will only work in a `LocalScript`.
---
UserInputService.DeviceAccelerationChanged = nil;
---@class RBXScriptSignal.DeviceGravityChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.DeviceGravityChanged, callback: fun(gravity: InputObject)): RBXScriptConnection
---The DeviceGravityChanged event fires when the device's gravity
---`DataType/Vector3/vector` changes on a device that has an accelerometer.
---
---A device's gravity vector represent the force of gravity on each of the
---device's X, Y, and Z axes. While gravity never changes, the force it
---exerts on each axis changes when the device rotates and changes
---orientation. The force value exerted on each axis is a unit vector ranging
---from -1 to 1.
---
---An accelerometer is a component found in most mobile devices that measures
---acceleration (change in speed).
---
---This event can be used to determine the real-world direction of the force
---of gravity on a user's device. This even can then be used to simulate the
---force of gravity on a user's device within the game, such as on in-game
---objects (see example below).
---
---To check if a user's device has an enabled accelerometer, see
---`UserInputService/AccelerometerEnabled`. If the device has an enabled
---accelerometer, you can use the `UserInputService/GetDeviceGravity`
---function to get the current force of gravity on the user's device.
---
UserInputService.DeviceGravityChanged = nil;
---@class RBXScriptSignal.DeviceRotationChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.DeviceRotationChanged, callback: fun(rotation: InputObject, cframe: CFrame)): RBXScriptConnection
---The DeviceRotationChanged event fires when a user rotates a device that
---has a gyroscope.
---
---A gyroscope is an component found in most mobile devices that detects
---orientation and rotational speed.
---
---The event is useful when tracking the orientation of the device and how
---changes as the user rotates their device. To determine the current device
---rotation, you can use the `UserInputService/GetDeviceRotation` function.
---
---To check if a user's device has an enabled gyroscope, and that this event
---will fire, see `UserInputService/GyroscopeEnabled`.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
UserInputService.DeviceRotationChanged = nil;
---@class RBXScriptSignal.GamepadConnected : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.GamepadConnected, callback: fun(gamepadNum: UserInputType)): RBXScriptConnection
---The GamepadConnected event fires when a gamepad is connected to the
---client.
---
---Since a Roblox game supports multiple controllers, this event is useful
---when paired with the `UserInputService/GamepadDisconnected` event to track
---which controllers/gamepads are active. You can also use
---`UserInputService/GetNavigationGamepads` and
---`UserInputService/GetConnectedGamepads` to find the correct gamepad to
---use.
---
---The following example demonstrates a usage example of a tracking when a
---gamepad is connected to the client.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---local function GamepadConnected(gamepad)
---	print("Player has plugged controller: " .. tostring(gamepad))
---end)
---
---userInputService.GamepadConnected:Connect(GamepadDisconnected)
---```
---
---If you want to see which devices are connected, you can use the
---`UserInputService/GetConnectedGamepads` function.
---
---As this event fires locally, it can only be used in a `LocalScript`. See
---[this][1] page for articles on cross-platform development.
---
---See also:
---
---- `UserInputService/GamepadDisconnected`
---- `UserInputService/GetConnectedGamepads`
---- `UserInputService/GetNavigationGamepads`
---- `UserInputService/SetNavigationGamepad`
---- `UserInputService/IsNavigationGamepad`
---- `UserInputService/IsGamepadButtonDown`
---- `UserInputService/GetSupportedGamepadKeyCodes`
---- `UserInputService/GetGamepadState`
---- `UserInputService/GetGamepadConnected`
---- `UserInputService/GamepadSupports`
---- `UserInputService/GamepadEnabled`
---
---[1]: /learn-roblox/cross-platform
---
UserInputService.GamepadConnected = nil;
---@class RBXScriptSignal.GamepadDisconnected : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.GamepadDisconnected, callback: fun(gamepadNum: UserInputType)): RBXScriptConnection
---The GamepadDisconnected event fires when a gamepad is disconnected.
---
---Since a Roblox game supports multiple controllers, this event is useful
---when paired with the `UserInputService/GamepadConnected` event to track
---which controllers/gamepads are active. You can also use
---`UserInputService/GetNavigationGamepads` and
---`UserInputService/GetConnectedGamepads` to find the correct gamepad to
---use.
---
---The following example demonstrates a usage example of a tracking when a
---gamepad is disconnected from the client.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---local function GamepadDisconnected(gamepad)
---	print("Player has unplugged controller: " .. tostring(gamepad))
---end)
---
---userInputService.GamepadDisconnected:Connect(GamepadDisconnected)
---```
---
---As this event fires locally, it can only be used in a `LocalScript`.
---
---See [this][1] page for articles on cross-platform development.
---
---See also:
---
---- `UserInputService/GamepadConnected`
---- `UserInputService/GetConnectedGamepads`
---- `UserInputService/GetNavigationGamepads`
---- `UserInputService/SetNavigationGamepad`
---- `UserInputService/IsNavigationGamepad`
---- `UserInputService/IsGamepadButtonDown`
---- `UserInputService/GetSupportedGamepadKeyCodes`
---- `UserInputService/GetGamepadState`
---- `UserInputService/GetGamepadConnected`
---- `UserInputService/GamepadSupports`
---- `UserInputService/GamepadEnabled`
---
---[1]: /learn-roblox/cross-platform
---
UserInputService.GamepadDisconnected = nil;
---@class RBXScriptSignal.InputBegan : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.InputBegan, callback: fun(input: InputObject, gameProcessedEvent: bool)): RBXScriptConnection
---The InputBegan event fires when a user begins interacting via a
---Human-Computer Interface device (mouse button down, touch begin, keyboard
---button down, etc.).
---
---It can be used to track the beginning of user interaction, such as when a
---user first interacts with a GUI element, a gamepad, etc. It does not
---capture mouse wheel movements.
---
---This event can be used along with `UserInputService/InputChanged` and
---`UserInputService/InputEnded` to track when user input begins, changes,
---and ends.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
UserInputService.InputBegan = nil;
---@class RBXScriptSignal.InputChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.InputChanged, callback: fun(input: InputObject, gameProcessedEvent: bool)): RBXScriptConnection
---The InputChanged event fires when a user changes how they're interacting
---via a Human-Computer Interface device (Mouse button down, touch begin,
---keyboard button down, etc).
---
---To ignore events that are automatically handled by Roblox, like scrolling
---in a `ScrollingFrame`, check the _gameProcessedEvent_ argument is false.
---This event can be used along with `UserInputService/InputBegan` and
---`UserInputService/InputEnded` to track when user input begins, changes,
---and ends.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
UserInputService.InputChanged = nil;
---@class RBXScriptSignal.InputEnded : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.InputEnded, callback: fun(input: InputObject, gameProcessedEvent: bool)): RBXScriptConnection
---The InputEnded event fires when a user stops interacting via a
---Human-Computer Interface device (Mouse button down, touch begin, keyboard
---button down, etc). This is useful when tracking when a user releases a
---keyboard key, mouse button, touchscreen input, etc.
---
---This event can be used along with `UserInputService/InputBegan` and
---`UserInputService/InputChanged` to track when user input begins, changes,
---and ends.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
UserInputService.InputEnded = nil;
---@class RBXScriptSignal.JumpRequest : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.JumpRequest, callback: fun()): RBXScriptConnection
---The `UserInputService` JumpRequest event fires when there is a jump
---request from the client (i.e. when the client pressed the spacebar or
---[jump GUI button][2] on mobile).
---
---This event fires whenever the user tries to make their `Player/Character`
---jump. Default behavior responds to a jump request by setting the player's
---`Humanoid/Jump` property to true, which makes the player's character jump.
---
---The event can be used to track every time a player wants to jump. Instead
---of using it to make a player jump, this should be used to change default
---jump behavior - such as disabling jumping.
---
---For example, the code below prints "Jump" every time the player sends a
---jump request.
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---function onJumpRequest()
---    print("Jump!")
---end
---
---UserInputService.JumpRequest:Connect(onJumpRequest)
---```
---
---Since this event fires multiple times for a single jump request, using a
---[debounce][1] is suggested.
---
---If you would like to connect keys or buttons to other actions, consider
---using events such as `UserInputService/GetKeysPressed` and
---`UserInputService/InputBegan` or the `ContextActionService`.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
---[1]: https://developer.roblox.com/articles/Debounce
---[2]: https://developer.roblox.com/articles/Mobile-Controls
---
UserInputService.JumpRequest = nil;
---@class RBXScriptSignal.LastInputTypeChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.LastInputTypeChanged, callback: fun(lastInputType: UserInputType)): RBXScriptConnection
---The LastInputTypeChanged event fires whenever the client changes how they
---are interacting via a Human-Computer Interface device. (i.e. from
---MouseMovement to MouseWheel or from Thumbstick1 to Thumbstick2).
---
---To get the value of LastInputType, regardless of whether it has changed,
---you can use the `UserInputService/GetLastInputType` function.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
UserInputService.LastInputTypeChanged = nil;
---@class RBXScriptSignal.PointerAction : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.PointerAction, callback: fun(wheel: float, pan: Vector2, pinch: float, gameProcessedEvent: bool)): RBXScriptConnection
---**PointerAction** fires when the user performs a specific pointer action.
---In particular, scrolling the mouse wheel.
---
UserInputService.PointerAction = nil;
---@class RBXScriptSignal.StatusBarTapped : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.StatusBarTapped, callback: fun(position: Vector2)): RBXScriptConnection
---
UserInputService.StatusBarTapped = nil;
---@class RBXScriptSignal.TextBoxFocusReleased : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TextBoxFocusReleased, callback: fun(textboxReleased: TextBox)): RBXScriptConnection
---The TextBoxFocusReleased event fires when a client loses focus on a
---TextBox - typically when a client stops text entry into a TextBox by
---pressing return or clicking/touching elsewhere on the screen.
---
---For example, the code below prints the the name of the TextBox losing
---focus when the event fires.
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---function TextBoxFocusReleased(textbox)
---	print(textbox.Name)
---end
---
---UserInputService.TextBoxFocusReleased:Connect(TextBoxFocusReleased)
---```
---
---It can be used alongside `UserInputService/TextBoxFocused` to track when a
---TextBox gains and loses focus.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
---See also:
---
---- `UserInputService/GetFocusedTextBox`
---- `TextBox/Focused`
---- `TextBox/FocusLost`
---
UserInputService.TextBoxFocusReleased = nil;
---@class RBXScriptSignal.TextBoxFocused : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TextBoxFocused, callback: fun(textboxFocused: TextBox)): RBXScriptConnection
---The TextBoxFocused event fires when a gains focus on a `TextBox` -
---typically when a client clicks/taps on a text box to begin inputting text.
---This also fires if a text box focus is focused using
---`TextBox/CaptureFocus`.
---
---For example, the code below prints the the name of the TextBox focused
---when the event fires.
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---function TextBoxFocused(textbox)
---	print(textbox.Name)
---end)
---
---UserInputService.TextBoxFocused:Connect(TextBoxFocused)
---```
---
---It can be used alongside `UserInputService/FocusReleased` to track when a
---text box gains and loses focus.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
---See also:
---
---- `UserInputService/GetFocusedTextBox`
---- `TextBox/Focused`
---- `TextBox/FocusLost`
---
UserInputService.TextBoxFocused = nil;
---@class RBXScriptSignal.TouchEnded : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TouchEnded, callback: fun(touch: InputObject, gameProcessedEvent: bool)): RBXScriptConnection
---The TouchEnded event fires when a user released their finger from the
---screen of a TouchEnabled device, ending touch input with the device.
---
---This event can be used to determine when a user stops touching the screen
---of their device. It can be paired with `UserInputService/TouchStarted` to
---determine when a user starts and stops touching the screen.
---
---For example, the code below prints the screen position where the user
---stops touching the screen.
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---function TouchEnded(touch, gameProcessedEvent)
---	print("Touch ended at "..tostring(touch.Position))
---end
---
---UserInputService.TouchEnded:Connect(TouchEnded)
---```
---
---The touch input object is the same input object throughout the lifetime of
---the touch. So comparing `InputObject|InputObjects` when they are touch
---objects is valid to determine if it is the same finger.
---
---To check if a user's device is TouchEnabled, and that touch events will
---fire, see `UserInputService/TouchEnabled`.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
---See also:
---
---- `UserInputService/TouchTap`
---- `UserInputService/TouchTapInWorld`
---- `UserInputService/TouchLongPress`
---- `UserInputService/TouchMoved`
---- `UserInputService/TouchPan`
---- `UserInputService/TouchPinch`
---- `UserInputService/TouchRotate`
---- `UserInputService/TouchSwipe`
---- `UserInputService/TouchStarted`
---
UserInputService.TouchEnded = nil;
---@class RBXScriptSignal.TouchLongPress : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TouchLongPress, callback: fun(touchPositions: Array, state: UserInputState, gameProcessedEvent: bool)): RBXScriptConnection
---Fired when a user holds at least one finger for a short amount of time on
---the same screen position of a TouchEnabled device.
---
---This event can be used to determine when a user holds their finger down on
---an an-game `GuiObject|GUI` or element.
---
---The example below prints the `Enum/UserInputState|state` of the long press
---when the user user holds at least one finger for a short amount of time on
---the same screen position. Possible states include: _Begin_, _Change_,
---_End_, _Cancel_, and _None_.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---function TouchLongPress(TouchPositions, state, gameProcessedEvent)
---	print("Long press event fired. State of press: "..tostring(state))
---end
---
---userInputService.TouchLongPress:Connect(TouchLongPress)
---```
---
---To check if a user's device is TouchEnabled, and that touch events will
---fire, see`UserInputService/TouchEnabled`.
---
---It can be paired with `UserInputService/TouchStarted` and
---`UserInputService/TouchEnded` to determine when a user starts and stops
---touching the screen.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
---See also:
---
---- `UserInputService/TouchTap`
---- `UserInputService/TouchTapInWorld`
---- `UserInputService/TouchMoved`
---- `UserInputService/TouchPan`
---- `UserInputService/TouchPinch`
---- `UserInputService/TouchRotate`
---- `UserInputService/TouchSwipe`
---- `UserInputService/TouchStarted`
---- `UserInputService/TouchEnded`
---
UserInputService.TouchLongPress = nil;
---@class RBXScriptSignal.TouchMoved : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TouchMoved, callback: fun(touch: InputObject, gameProcessedEvent: bool)): RBXScriptConnection
---The TouchMoved event fires when a user moves their finger on a
---TouchEnabled device.
---
---This event can be used to determine when a user moves their finger while
---touching the screen of a TouchEnabled device. It can be useful to track
---whether a user is moving their finger on the screen, as well as where the
---user is moving their finger.
---
---The code below prints "Touch moved from" the previous Vector2 position "to
---" the new Vector2 position of the user's touch on a TouchEnabled device.
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---function onTouchMoved(touch, gameProcessedEvent)
---	local oldPosition = touch.Position - touch.Delta
---	print("Touch moved from " .. tostring(oldPosition) .. "to " .. tostring(touch.Position))
---end
---
---UserInputService.TouchMoved:Connect(onTouchMoved)
---```
---
---It can be paired with `UserInputService/TouchStarted` and
---`UserInputService/TouchEnded` to determine when a user starts touching the
---screen, how their finger moves while touching it, and when the they stop
---touching the screen.
---
---To check if a user's device is TouchEnabled, and that touch events will
---fire, see `UserInputService/TouchEnabled`.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
---See also:
---
---- `UserInputService/TouchTap`
---- `UserInputService/TouchTapInWorld`
---- `UserInputService/TouchLongPress`
---- `UserInputService/TouchPan`
---- `UserInputService/TouchPinch`
---- `UserInputService/TouchRotate`
---- `UserInputService/TouchSwipe`
---- `UserInputService/TouchStarted`
---- `UserInputService/TouchEnded`
---
UserInputService.TouchMoved = nil;
---@class RBXScriptSignal.TouchPan : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TouchPan, callback: fun(touchPositions: Array, totalTranslation: Vector2, velocity: Vector2, state: UserInputState, gameProcessedEvent: bool)): RBXScriptConnection
---The TouchPan event fires when a user drags at least one finger on a
---`UserInputService/TouchEnabled|TouchEnabled` device.
---
---This event can be used to determine when a user pans their finger along
---screen of a TouchEnabled device - such as to rotate the `Camera` in a
---custom camera script.
---
---The snippet below prints "Speed of touch drag" followed by the velocity of
---the user's touch when the user drags their finger on the screen.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---userInputService.TouchPan:Connect(function(touchPositions, totalTranslation, velocity, state, gameProcessedEvent)
---	print("Speed of touch drag: "..tostring(velocity))
---end)
---```
---
---Take a look at another useful `UserInputService` function here
---`UserInputService/TouchRotate`.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
---See also:
---
---- `UserInputService/TouchTap`
---- `UserInputService/TouchTapInWorld`
---- `UserInputService/TouchLongPress`
---- `UserInputService/TouchMoved`
---- `UserInputService/TouchPinch`
---- `UserInputService/TouchRotate`
---- `UserInputService/TouchSwipe`
---- `UserInputService/TouchStarted`
---- `UserInputService/TouchEnded`
---
UserInputService.TouchPan = nil;
---@class RBXScriptSignal.TouchPinch : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TouchPinch, callback: fun(touchPositions: Array, scale: float, velocity: float, state: UserInputState, gameProcessedEvent: bool)): RBXScriptConnection
---Fired when a user places and moves two fingers on the screen of a
---`UserInputService/TouchEnabled|TouchEnabled` device.
---
---For instance, the snippet below prints how much the camera zoom scale has
---changed since the beginning of the touch pinch,
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---UserInputService.TouchPinch:Connect(function(touchPositions, scale, velocity, state, gameProcessedEvent)
---	print("Scale difference since beginning of pinch: "..tostring(scale))
---end)
---```
---
---To check if a user's device is TouchEnabled, and that touch events will
---fire, see `UserInputService/TouchEnabled`.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
---`CoreScript|Core scripts` use similar logic to zoom the user's camera when
---a user pinches their fingers on a mobile device. For more info on these
---scripts, see [here][1]. Best practice for this event is to use it when
---creating a mobile camera system to override the default core script.
---
---See also:
---
---- `UserInputService/TouchTap`
---- `UserInputService/TouchTapInWorld`
---- `UserInputService/TouchMoved`
---- `UserInputService/TouchLongPress`
---- `UserInputService/TouchPan`
---- `UserInputService/TouchRotate`
---- `UserInputService/TouchSwipe`
---- `UserInputService/TouchStarted`
---- `UserInputService/TouchEnded`
---
---[1]:
---  https://www.robloxdev.comhttps://developer.roblox.com/articles/Movement-and-camera-controls
---
UserInputService.TouchPinch = nil;
---@class RBXScriptSignal.TouchRotate : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TouchRotate, callback: fun(touchPositions: Array, rotation: float, velocity: float, state: UserInputState, gameProcessedEvent: bool)): RBXScriptConnection
---The TouchRotate event fires when a user rotates two fingers on a
---`UserInputService/TouchEnabled|TouchEnabled` device.
---
---For example, the following code prints how much the camera has rotated
---since the beginning of the touch rotation.
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---UserInputService.TouchRotate:Connect(function(touchPositions, rotation, velocity, state, gameProcessedEvent)
---	print("Camera has rotated "..tostring(rotation).." degrees!")
---end)
---```
---
---To check if a user's device is TouchEnabled, and that touch events will
---fire, see `UserInputService/TouchEnabled`.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
---The core scripts that control the user's camera on a mobile device use
---code that functions similarly to this event. For more info on these
---scripts, see [here][1]. Best practice for this event is to use it when
---creating a mobile camera system to override the default core scripts.
---
---See also:
---
---- `UserInputService/TouchTap`
---- `UserInputService/TouchTapInWorld`
---- `UserInputService/TouchMoved`
---- `UserInputService/TouchLongPress`
---- `UserInputService/TouchPan`
---- `UserInputService/TouchPinch`
---- `UserInputService/TouchSwipe`
---- `UserInputService/TouchStarted`
---- `UserInputService/TouchEnded`
---
---[1]: https://developer.roblox.com/articles/Movement-and-camera-controls
---
UserInputService.TouchRotate = nil;
---@class RBXScriptSignal.TouchStarted : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TouchStarted, callback: fun(touch: InputObject, gameProcessedEvent: bool)): RBXScriptConnection
---The TouchStarted event fires when a user places their finger on a
---`UserInputService/TouchEnabled|TouchEnabled` device, beginning touch input
---with the device.
---
---This event can be used to determine when a user starts touching the screen
---of their device. It can be paired with `UserInputService/TouchEnded` to
---determine when a user starts and stops touching the screen.
---
---The touch input object is the same input object throughout the lifetime of
---the touch. So comparing `InputObject|InputObjects` when they are touch
---objects is valid to determine if it is the same finger.
---
---To check if a user's device is TouchEnabled, and that touch events will
---fire, see `UserInputService/TouchEnabled`.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
---See also:
---
---- `UserInputService/TouchTap`
---- `UserInputService/TouchTapInWorld`
---- `UserInputService/TouchLongPress`
---- `UserInputService/TouchMoved`
---- `UserInputService/TouchPan`
---- `UserInputService/TouchPinch`
---- `UserInputService/TouchRotate`
---- `UserInputService/TouchSwipe`
---- `UserInputService/TouchEnded`
---
UserInputService.TouchStarted = nil;
---@class RBXScriptSignal.TouchSwipe : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TouchSwipe, callback: fun(swipeDirection: SwipeDirection, numberOfTouches: int, gameProcessedEvent: bool)): RBXScriptConnection
---The TouchSwipe event fires when a user swipes their fingers on a
---`UserInputService/TouchEnabled|TouchEnabled` device.
---
---This event can be used to determine when a user swipes their fingers on
---the screen of their device and the direction that the user swiped.
---
---For more precise tracking of touch input movement, use using
---`UserInputService/TouchMoved`
---
---To check if a user's device is TouchEnabled, and that touch events will
---fire, see `UserInputService/TouchEnabled`.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
---See also:
---
---- `UserInputService/TouchTap`
---- `UserInputService/TouchTapInWorld`
---- `UserInputService/TouchLongPress`
---- `UserInputService/TouchMoved`
---- `UserInputService/TouchPan`
---- `UserInputService/TouchPinch`
---- `UserInputService/TouchRotate`
---- `UserInputService/TouchStarted`
---- `UserInputService/TouchEnded`
---
UserInputService.TouchSwipe = nil;
---@class RBXScriptSignal.TouchTap : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TouchTap, callback: fun(touchPositions: Array, gameProcessedEvent: bool)): RBXScriptConnection
---The TouchTap event fires when the user touches/taps their finger on the
---screen on a `UserInputService/TouchEnabled|TouchEnabled` device.
---
---This event will fire regardless of whether the user touches/taps the game
---world or a `GuiObject|GUI` element. If you are looking for an event that
---only fires when the user touches/taps the game world, use
---`UserInputService/TouchTapInWorld`.
---
---To check if a user's device is TouchEnabled, and that touch events will
---fire, see `UserInputService/TouchEnabled`.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
UserInputService.TouchTap = nil;
---@class RBXScriptSignal.TouchTapInWorld : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TouchTapInWorld, callback: fun(position: Vector2, processedByUI: bool)): RBXScriptConnection
---The TouchTapInWorld event fires when the user touches/taps their finger on
---the screen on a `UserInputService/TouchEnabled|TouchEnabled` device. It is
---fired when the user taps in the game world.
---
---This event can be used to determine when a user taps the screen and does
---not tap a `GuiObject|GUI` element. If the user taps a GUI element,
---`UserInputService/TouchTap` will fire instead of TouchTapInWorld.
---
---To check if a user's device is TouchEnabled, and that touch events will
---fire, see `UserInputService/TouchEnabled`.
---
---This event only fires when the Roblox client window is in focus. For
---example, inputs will not be captured when the window is minimized.
---
---As it only fires locally, it can only be used in a `LocalScript`.
---
---See also:
---
---- `UserInputService/TouchTap`
---- `UserInputService/TouchLongPress`
---- `UserInputService/TouchMoved`
---- `UserInputService/TouchPan`
---- `UserInputService/TouchPinch`
---- `UserInputService/TouchRotate`
---- `UserInputService/TouchSwipe`
---- `UserInputService/TouchStarted`
---- `UserInputService/TouchEnded`
---
UserInputService.TouchTapInWorld = nil;
---@class RBXScriptSignal.UserCFrameChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.UserCFrameChanged, callback: fun(type: UserCFrame, value: CFrame)): RBXScriptConnection
---The UserCFrameChanged event fires when the `DataType/CFrame` of a VR
---device changes.
---
---This event can be used to track the movement of a connected VR device.
---
---Using the event, you can implement features such as moving the user's
---in-game character limbs as the user moves their VR device. This can be
---done by changing the CFrame of the user's in-game limbs to match the
---CFrame changes of the VR device using the `Enum/UserCFrame` enum and
---_CFrame_ value arguments passed by the event.
---
---To retrieve the `DataType/CFrame` of a connected VR device, use
---`UserInputService/GetUserCFrame`.
---
---As the event fires locally, it can only be used in a `LocalScript`.
---
---See also:
---
---- `VRService`, used to implement support, including an identical event
---  `VRService/UserHeadCFrameChanged`
---- `Camera/HeadLocked`, when this property is _true_ the `Camera` will
---  automatically track the head motion of a player using a VR device
---- `Camera/GetRenderCFrame`, a function which retrieves the
---  `DataType/CFrame` the `Camera` is being orientated at, including the
---  impact of VR devices
---
UserInputService.UserCFrameChanged = nil;
---@class RBXScriptSignal.WindowFocusReleased : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.WindowFocusReleased, callback: fun()): RBXScriptConnection
---The `UserInputService` WindowFocusReleased event fires when the window of
---the Roblox client loses focus - typically when the Roblox client is
---minimized by the user.
---
---For example, the code below prints _"Window focus released"_ whenever the
---Roblox client loses focus.
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---UserInputService.WindowFocusReleased:Connect(function()
---	print("Window focus released")
---end)
---```
---
---This event can be used alongside `UserInputService/WindowFocused` to track
---whether the Roblox client is actively focused on a user's screen.
---
---Since it only fires locally, it can only be used in a `LocalScript`.
---
UserInputService.WindowFocusReleased = nil;
---@class RBXScriptSignal.WindowFocused : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.WindowFocused, callback: fun()): RBXScriptConnection
---The `UserInputService` WindowFocused event fires when the window of the
---Roblox client gains focus - typically when the Roblox client is
---maximized/actively open on the user's screen.
---
---For example, the code below prints _"Window focused"_ whenever the Roblox
---client gains focus.
---
---```lua
---local UserInputService = game:GetService("UserInputService")
---
---UserInputService.WindowFocused:Connect(function()
---	print("Window focused")
---end)
---```
---
---This event can be used alongside `UserInputService/WindowFocusReleased` to
---track whether the Roblox client is actively focused on a user's screen.
---
---As this event only fires locally, it can only be used in a `LocalScript`.
---
UserInputService.WindowFocused = nil;
---@class UserService : Instance
---A service that handles queries regarding users on the Roblox platform.
---
local UserService;
---@param userIds Array
---@return Array
---This function enables developers to request information about users
---outside of the current [DataModel](/reference/engine/classes/DataModel) in
---bulk, which is why both the input and output values are arrays.
---
---- The order of the `UserInfosResponse` objects in the return value's array
---  may not match the order of the `UserIds` sent in the input parameter's
---  array. Use the `Id` field of the `UserInfosResponse` object to identify
---  your input array with the output array.
---- It's possible to receive less `UserInfoResponse` objects than requested
---  if one or more of the `userIds` in the request array are invalid, such
---  as negative numbers or user ID's that don't have accounts associated
---  with them. It's possible to receive a response with zero results if all
---  userIds are invalid.
---- If a Roblox user does not have a display name associated with their
---  account, the function will return instead the same string as the user's
---  username in the `DisplayName` field. See
---  [Player.DisplayName](/reference/engine/classes/Player#DisplayName).
---  While a user's UserId will never change, a user may change their
---  username or display name. The same input `UserIds` may return a
---  different string for these fields from one day to another.
---- Since `GetUserInfosByUserIdsAsync()` makes an external web request, it
---  will yield and may fail if the backend service is experiencing
---  interruptions. Ensure you can handle downtime appropriately by wrapping
---  the method with a pcall.
---
UserService.GetUserInfosByUserIdsAsync = function(self, userIds) end;
---@class UserSettings : GenericSettings, ServiceProvider, Instance
---UserSettings is a singleton object that is used to house basic user settings,
---which persist across all games. Currently, it only stores the
---`UserGameSettings` object.
---
---You can retrieve a reference to this object via the `UserSettings()` function,
---which returns it.
---
local UserSettings;
---@param name string
---@return bool
---Returns true if the specified user feature is enabled. This will throw an
---error if the user feature does not exist.
---
---This function checks against a list of FFlags, whose name starts with
---"User". The function is intended to be used by Roblox-created scripts, and
---functions similarly to `GlobalSettings/GetFFlag`.
---
UserSettings.IsUserFeatureEnabled = function(self, name) end;
---@return void
---Erases the saved state of the UserSettings, and restores its values back
---to default. This function will fail to run correctly from a LocalScript,
---as it does not have permission to restore all of the properties in the
---`UserGameSettings` class.
---
UserSettings.Reset = function(self) end;
---@class UserStorageService : LocalStorageService, Instance
local UserStorageService;
---@class VRService : Instance
---@field public DidPointerHit bool
---@field public GuiInputUserCFrame UserCFrame
---@field public PointerHitCFrame CFrame
---@field public VRDeviceAvailable bool
---@field public VRDeviceName string
---@field public VREnabled bool
---@field public NavigationRequested RBXScriptSignal.NavigationRequested
---@field public TouchpadModeChanged RBXScriptSignal.TouchpadModeChanged
---@field public UserCFrameChanged RBXScriptSignal.UserCFrameChanged
---@field public UserCFrameEnabled RBXScriptSignal.UserCFrameEnabled
---The VRService is a service that is responsible for handling interactions
---between Roblox and Virtual Reality (VR). If you're interested in incorporating
---VR compatibility into your game, this is the service for you!
---
---The primary purpose of this service is to allow for games to communication and
---cooperate with virtual reality decisions - such as VR headsets and
---controllers. It allows a LocalScript to perform different actions depending on
---the device, and in turn, helps developers provide the best experience for the
---end user seeking to experience Roblox using VR devices.
---
---Some usages of this service include detecting whether a user has any connected
---VR devices, tracking when those devices move, and determining how those
---devices interact with the user's in-game controls. In order to detect user
---input, the service must look for a service event. For example, the service can
---detect VR device movement via events such as `VRService/UserCFrameChanged`.
---
---## Notes
---
---1.  The `UserInputService` also contains several events and functions useful
---    for enhancing a player's VR experience in your game.
---2.  Since this service is client-side only, it will only work when used in a
---    `LocalScript`. It will not work when used within a `Script`. Client-side
---    only means that users in the game can only detect their own input - and
---    not the input of other users.
---
local VRService;
---
VRService.DidPointerHit = nil;
---The GuiInputUserCFrame property describes what `Enum/UserCFrame` is
---responsible for input in VR. For instance, if a VR headset is responsible,
---the value of this property will be UserCFrame.Head.
---
---To check if Roblox detects any VR devices, which would be responsible for
---input in VR, you can check the `VRService/VREnabled` property.
---
---Since `VRService` only runs client-side, this property will only work when
---used in a `LocalScript`.
---
VRService.GuiInputUserCFrame = nil;
---
VRService.PointerHitCFrame = nil;
---
VRService.VRDeviceAvailable = nil;
---
VRService.VRDeviceName = nil;
---This property describes whether the user is using a virtual reality (VR)
---device.
---
---If a VR device is enabled, you can interact with its location and movement
---through functions such as
---` UserInputService/GetUserCFrame``. You can also react to VR device movement using the  `UserInputService/UserCFrameChanged`
---event.
---
---```lua
---local userInputService = game:GetService("UserInputService")
---
---local isUsingVR = userInputService.VREnabled
---if (isUsingVR) then
---    print("User is using a VR headset!")
---else
---    print("User is not using a VR headset!")
---end
---```
---
---As `UserInputService` isclient-side only, this property can only be used
---in a `LocalScript`.
---
---See [this][1] article for VR best practices.
---
---See also:
---
---- `VRService`
---- `Camera/HeadLocked`
---- `UserInputService/GetUserCFrame`
---- `UserInputService/UserCFrameChanged`
---
---[1]: https://developer.roblox.com/articles/Virtual-Reality-Best-Practices
---
VRService.VREnabled = nil;
---@param pad VRTouchpad
---@param mode VRTouchpadMode
---@return void
---The SetTouchpadMode function sets the mode of the specified
---`Enum/VRTouchpad` to the specified `Enum/VRTouchpadMode`.
---
---This can be used to change the user's virtual reality (VR) touchpad mode
---so that the user interacts with the game different using the touchpad. For
---more information about the different types of modes, see the
---`Enum/VRTouchpadMode` page.
---
---This can also be used alongside the several `UserInputService` VR
---functions and events.
---
---Since `VRService` only runs client-side, this function will only work when
---used in a `LocalScript`.
---
VRService.SetTouchpadMode = function(self, pad, mode) end;
---@param type UserCFrame
---@return bool
---The GetUserCFrameEnabled function returns true if the specified
---`Enum/UserCFrame` virtual reality device (VR) is available to be listened
---to.
---
---This can be used to determine whether a specified VR device, _(e.g.
---UserCFrame.Head)_, is connected to the user's game. If the specified VR
---device is connected, is it enabled (_true_). Otherwise, it is disabled
---(_false_).
---
---This can also be used alongside the several `UserInputService` VR
---functions and events.
---
---Since `VRService` only runs client-side, this function will only work when
---used in a `LocalScript`.
---
VRService.GetUserCFrameEnabled = function(self, type) end;
---@param type UserCFrame
---@return CFrame
---The GetUserCFrame function returns a `DataType/CFrame` describing the
---position &amp; orientation of a specified virtual reality (VR) device.
---
---This function should be used when implementing VR compatibility into a
---game to obtain and track the movement of a connected VR device.
---
---By using the function, players can implement features such as
---re-positioning the user's in-game character corresponding to the location
---of a connected VR device. This can be done by changing the _CFrame_ of the
---user's in-game character to match the _CFrame_ of the specified VR device
---using the UserCFrame enum and _CFrame_ value arguments passed by the
---event.
---
---The `VRService` service also provides an event
---`VRService/UserCFrameChanged` that automatically fires when the _CFrame_
---of connected VR device changes - so long it is used in a LocalScript.
---
---This can also be used alongside the several `UserInputService` VR
---functions and events.
---
---Since `VRService` only runs client-side, this function will only work when
---used in a `LocalScript`.
---
VRService.GetUserCFrame = function(self, type) end;
---@param pad VRTouchpad
---@return VRTouchpadMode
---The GetTouchpadMode function returns the `Enum/VRTouchpadMode` indicating
---the mode of a specified `Enum/VRTouchpad`.
---
---The returned mode indicates how the user interacts with their touchpad to
---play the game. For more information about the different types of modes,
---see the `Enum/VRTouchpadMode` page.
---
---This can also be used alongside the several `UserInputService` VR
---functions and events.
---
---Since `VRService` only runs client-side, this function will only work when
---used in a `LocalScript`.
---
VRService.GetTouchpadMode = function(self, pad) end;
---@param cframe CFrame
---@param inputUserCFrame UserCFrame
---@return void
---The RequestNavigation function requests navigation to the specified
---`DataType/CFrame`, using the specified `Enum/UserCFrame` as the origin for
---the visualizer parabola.
---
---This can be used to incorporate virtual reality (VR) into your game by
---providing a means to visualize a navigation path from the user's VR device
---to a destination.
---
---The `VRService` has a similar event, `VRService/NavigationRequested`, used
---to detect such requests. This can also be used alongside the several
---`UserInputService` VR functions and events.
---
---Since VRService only runs client-side, this function will only work when
---used in a `LocalScript`.
---
VRService.RequestNavigation = function(self, cframe, inputUserCFrame) end;
---@return void
---The RecentUserHeadCFrame function recenters the `DataType/CFrame` of the
---user's head to the current location of the VR headset being worn by the
---user.
---
---This function can be used to ensure that the user's in-game head is
---positioned according to the location of the user's VR headset.
---
---This is similar to the `UserInputService` function,
---`UserInputService/RecenterUserHeadCFrame`.
---
---Since `VRServiceService` only runs client-side, this function will only
---work when used in a `LocalScript`.
---
VRService.RecenterUserHeadCFrame = function(self) end;
---@class RBXScriptSignal.NavigationRequested : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.NavigationRequested, callback: fun(cframe: CFrame, inputUserCFrame: UserCFrame)): RBXScriptConnection
---The NavigationRequested event fires when navigation is requested from the
---VRService for a specified `Enum/UserCFrame` VR device.
---
---This is fired with a `DataType/CFrame` coordinate and specified UserCFrame
---indicating the device requesting the navigation.
---
---This `VRService` event can be used alongside `UserInputService` service
---events and functions.
---
---Since the event fires locally, it can only be used in a `LocalScript`.
---
VRService.NavigationRequested = nil;
---@class RBXScriptSignal.TouchpadModeChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.TouchpadModeChanged, callback: fun(pad: VRTouchpad, mode: VRTouchpadMode)): RBXScriptConnection
---The TouchpadModeChanged event fires if the `Enum/VRTouchpadMode` of a
---`Enum/VRTouchpad` is changed. This event indicates the VRTouchpad that
---changes, and its new state.
---
---You can use this event to track the states of VRTouchpads connected via
---the user's client.
---
---This `VRService` event can be used alongside `UserInputService` service
---events and functions.
---
---Since the event fires locally, it can only be used in a `LocalScript`.
---
VRService.TouchpadModeChanged = nil;
---@class RBXScriptSignal.UserCFrameChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.UserCFrameChanged, callback: fun(type: UserCFrame, value: CFrame)): RBXScriptConnection
---The UserCFrameChanged even fires when a `Enum/UserCFrame` is changed. For
---instance, this event fires when the user moves a connected VR device.
---
---This can be used alongside `VRService\GetUserCFrame` to track the
---`DataType/CFrame` coordinates of a VR devices, and when it changes/moves.
---It can also be used alongside `UserInputService` service events and
---functions.
---
---Since the event fires locally, it can only be used in a `LocalScript`.
---
VRService.UserCFrameChanged = nil;
---@class RBXScriptSignal.UserCFrameEnabled : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.UserCFrameEnabled, callback: fun(type: UserCFrame, enabled: bool)): RBXScriptConnection
---The UserCFrameEnabled event fires when a `Enum/UserCFrame` gets enabled or
---disabled.
---
---This can be used alongside `VRService\GetUserCFrameEnabled` to track
---whether a specified UserCFrame is enabled, and when its state changes. It
---can also be used alongside `UserInputService` service events and
---functions.
---
---Since the event fires locally, it can only be used in a `LocalScript`.
---
VRService.UserCFrameEnabled = nil;
---@class ValueBase : Instance
---Base class of all 'Value Instance' objects.
---
local ValueBase;
---@class Vector3Curve : Instance
---Represents a 3D vector curve containing 3 `FloatCurve|FloatCurves`, stored as
---3 FloatCurve children instances. Each FloatCurve can be accessed via
---`Vector3Curve/X`, `Vector3Curve/Y`, `Vector3Curve/Z` methods. The 3 axes can
---be sampled simultaneously via the method `Vector3Curve/GetValueAtTime`.
---
local Vector3Curve;
---@param time float
---@return Array
---Samples the 3 FloatCurves (X, Y, Z) at the time passed as argument.
---Returns the 3 samples as a tuple of 3 numbers. If a channel curve is
---missing or no key is found in the curve the channel is evaluated as nil.
---
Vector3Curve.GetValueAtTime = function(self, time) end;
---@return FloatCurve
---Returns the FloatCurve controlling the X channel. It is the first child
---instance of type FloatCurve named `X`. If none is found an empty
---FloatCurve is created.
---
Vector3Curve.X = function(self) end;
---@return FloatCurve
---Returns the FloatCurve controlling the Y channel. It is the first child
---instance of type FloatCurve named `Y`. If none is found an empty
---FloatCurve is created.
---
Vector3Curve.Y = function(self) end;
---@return FloatCurve
---Returns the FloatCurve controlling the Z channel. It is the first child
---instance of type FloatCurve named `Z`. If none is found an empty
---FloatCurve is created.
---
Vector3Curve.Z = function(self) end;
---@class Vector3Value : ValueBase, Instance
---@field public Value Vector3
---@field public Changed RBXScriptSignal.Changed
---@field public changed RBXScriptSignal.changed
---A Vector3Value simply holds a Vector3 as a value. This value can be used for
---scripts to communicate, for objects to move to a preset location, etc.
---
local Vector3Value;
---The stored <a href="/reference/engine/datatypes/Vector3">Vector3</a>.
---
Vector3Value.Value = nil;
---@class RBXScriptSignal.Changed : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.Changed, callback: fun(value: Vector3)): RBXScriptConnection
---Fired whenever the `Vector3Value/Value` of the `Vector3Value` is changed.
---It will run with the new value being stored in the argument object,
---instead of a string representing the property being changed.
---
---This event, like other changed events, can be used to track when an
---Vector3Value changes and to track the different values that it may change
---to.
---
---For instance, this may be useful in games that rely on Vector3Values to
---track positions in the game world.
---
---Equivalent changed events exist for similar objects, such as `NumberValue`
---and `StringValue`, depending on what object type best suits the need.
---
Vector3Value.Changed = nil;
---@class RBXScriptSignal.changed : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.changed, callback: fun(value: Vector3)): RBXScriptConnection
---
Vector3Value.changed = nil;
---@class VectorForce : Constraint, Instance
---@field public ApplyAtCenterOfMass bool
---@field public Force Vector3
---@field public RelativeTo ActuatorRelativeTo
---A VectorForce is used to apply a force to a part or assembly of parts. The
---direction and strength of the force is determined by a `DataType/Vector3` and
---can be relative to an attachment on the part, another attachment, or the world
---coordinate system.
---
---The following image demonstrates how VectorForce applies a force on a part
---relative to an Attachment.
---
---![VectorForce RelativeTo][1]
---
---The following image demonstrates how VectorForce applies a force on a part
---relative to the part's center of mass.
---
---![VectorForce CenterOfMass][2]
---
---## Location of force
---
---A VectorForce will apply its force on the Parent of its
---`Constraint/Attachment0|Attachment0`, but the location where the force is
---applied is determined by the `VectorForce/ApplyAtCenterOfMass` property.
---
---When `VectorForce/ApplyAtCenterOfMass` is false, which it is by default, the
---force will be applied to the part at the Attachement0's location. This means
---that if the attachment is not at the center of the part, it can create a
---torque on the part.
---
---When ApplyAtCenterOfMass is set to true, the force will check if any other
---parts are rigidly connected to the parent part of its Attachment0. If there
---are, then the force will apply at the center of mass of all of the connected
---parts. If there are no rigid connections to other parts, the force will simply
---be applied at the center of mass of the part.
---
---## Direction of force
---
---The direction of the force is determined by the Vector3 defined by force, but
---it will also be affected by the `VectorForce/RelativeTo` property.
---
---By default, `VectorForce/RelativeTo` is set to
---`Enum/ActuatorRelativeTo|Enum.ActuatorRelativeTo.Attachment0`, meaning the
---force will be applied in the space local to the attachment. Remember that when
---visualizing an attachment, the yellow arrow shows the direction of positive X,
---and the orange bar shows the direction of positive Y. If the part the
---attachment is connected to rotates, the force will change direction to make
---sure it is still in the context of the attachment.
---
---RelativeTo can also be set to
---`Enum/ActuatorRelativeTo|Enum.ActuatorRelativeTo.Attachment1`. In this case,
---the force will be applied in the space local to
---`Constraint/Attachment1|Attachment1`, regardless of the orientation of
---Attachment0 or its connected part. If Attachment1 rotates, then the force will
---change to stay oriented correctly.
---
---Lastly, RelativeTo can also be set to
---`Enum/ActuatorRelativeTo|Enum.ActuatorRelativeTo.World`. In this mode, the
---force is applied in world coordinates, regardless of the orientation of
---Attachment0 or its part.
---
---See also:
---
---- [Body Movers Example.rbxl][3], a sample place showcasing body movers in
---  various configurations.
---- [Attachments and Constraints][4], an article outlining how to create and use
---  attachments and constraints
---
---[1]: /assets/bltacb3e3255384a7b4/VectorForceRelativeTo3.gif
---[2]: /assets/bltcdb637c5a4b55ef3/VectorForceCenterOfMass.gif
---[3]:
---  https://doy2mn9upadnk.cloudfront.net/uploads/default/original/3X/e/1/e17a844750802035b24f68ddcbd83f6312b8f1d6.rbxl
---[4]: https://developer.roblox.com/articles/Constraints
---
local VectorForce;
---This property indicates whether the force is applied at the center of mass
---of `VectorForce/Attachment0|Attachment0's` parent `Part`.
---
---When true, the force is applied at the center of mass. When false, the
---force is applied at Attachment0.
---
---![Force applied at the Part's center of mass][1]
---
---[1]: /assets/bltcdb637c5a4b55ef3/VectorForceCenterOfMass.gif
---
VectorForce.ApplyAtCenterOfMass = nil;
---The strength and direction of the force.
---
VectorForce.Force = nil;
---This property determines the `DataType/CFrame` in which the force is
---expressed.
---
---![VectorForce RelativeTo Demo][1]
---
---[1]:
---  https://images.contentstack.io/v3/assets/bltc2ad39afa86662c8/bltacb3e3255384a7b4/5ff7c7eeb08361084bffdcb1/VectorForceRelativeTo3.gif
---
VectorForce.RelativeTo = nil;
---@class VehicleController : Controller, Instance
---A VehicleController is an object responsible for translating
---<a href="/reference/engine/enums/PlayerActions">PlayerActions</a> to movements
---with a `VehicleSeat`.
---
local VehicleController;
---@class VehicleSeat : BasePart, PVInstance, Instance
---@field public AreHingesDetected int
---@field public Disabled bool
---@field public HeadsUpDisplay bool
---@field public MaxSpeed float
---@field public Occupant Humanoid
---@field public Steer int
---@field public SteerFloat float
---@field public Throttle int
---@field public ThrottleFloat float
---@field public Torque float
---@field public TurnSpeed float
---The VehicleSeat objects welds a player to the seat when the player touches the
---seat. It then forwards the movement keys to any connected motor joints,
---allowing control of a vehicle.
---
---While VehicleSeats are great for making simple vehicles they do have some
---limitations. Movement control will only detect motors connected directly to
---the vehicle seat, or through another rigid connection. This means that if you
---have a wheel connected to a beam which is then welded to the seat it will work
---fine, however if you have the wheel connected to a part, which is connected by
---a hinge to the rest of the car, it will not work.
---
local VehicleSeat;
---Displays how many hinges are detected by the VehicleSeat. Useful for
---debugging vehicle designs.
---
VehicleSeat.AreHingesDetected = nil;
---Toggles whether the `VehicleSeat` is active or not. If the seat is
---disabled then it will not automatically weld a character to it on
---collision and will not allow a character to control the connected vehicle.
---
VehicleSeat.Disabled = nil;
---If true, a fancy speed bar will be displayed speed on screen that tells
---you what speed the Vehicle is moving at.
---
VehicleSeat.HeadsUpDisplay = nil;
---The maximum speed that can be attained.
---
VehicleSeat.MaxSpeed = nil;
---The humanoid that is sitting in the seat
---
VehicleSeat.Occupant = nil;
---The direction of movement, tied to the keys A and D. Must be one of 1
---(right), 0 (straight), or -1 (left). Will refresh back to 0 unless
---constantly set.
---
VehicleSeat.Steer = nil;
---Functions identically to `VehicleSeat/Steer`, but the value is not an
---integer.
---
VehicleSeat.SteerFloat = nil;
---The direction of movement, tied to the keys W and S. Must be an integer 1
---(forward) 0 (null) or -1 (reverse). Will refresh back to 0 unless
---constantly set.
---
VehicleSeat.Throttle = nil;
---Functions identically to `VehicleSeat/Throttle`, but the value is not an
---integer.
---
VehicleSeat.ThrottleFloat = nil;
---How fast the vehicles will be able to attain `VehicleSeat/MaxSpeed`. The
---greater the number, the faster it will reach the maximum speed.
---
VehicleSeat.Torque = nil;
---The speed at which the vehicle will turn. Higher numbers can cause
---problems and are not necessarily better.
---
VehicleSeat.TurnSpeed = nil;
---@param humanoid Instance
---@return void
---Forces the character with the specified
---<a href="/reference/engine/classes/Humanoid">Humanoid</a> to sit in the
---VehicleSeat.
---
VehicleSeat.Sit = function(self, humanoid) end;
---@class VelocityMotor : JointInstance, Instance
---@field public CurrentAngle float
---@field public DesiredAngle float
---@field public Hole Hole
---@field public MaxVelocity float
---The VelocityMotor is a special type of joint that works similarly to a
---`Motor`, but it uses a `MotorFeature` and a `Hole` to create the connection.
---In order for this object to work correctly:
---
---- The VelocityMotor must be parented inside of a `MotorFeature`
---- The `MotorFeature` needs to be parented inside of a `BasePart`
---- A `Hole` needs to be parented inside of another `BasePart`
---- The VelocityMotor's `VelocityMotor/Hole` property should be assigned to the
---  hole you parented inside of the other part.
---
local VelocityMotor;
---Displays the angle that the motor is at in radians.
---
VelocityMotor.CurrentAngle = nil;
---The desired angle to be reached. The motor will attempt to reach this
---angle.
---
VelocityMotor.DesiredAngle = nil;
---The `Hole` linked to this VelocityMotor.
---
VelocityMotor.Hole = nil;
---The maximum amount of velocity able to be reached.
---
VelocityMotor.MaxVelocity = nil;
---@class VersionControlService : Instance
---@field public ScriptCollabEnabled bool
local VersionControlService;
---
VersionControlService.ScriptCollabEnabled = nil;
---@class VideoFrame : GuiObject, GuiBase2d, GuiBase, Instance
---@field public IsLoaded bool
---@field public Looped bool
---@field public Playing bool
---@field public Resolution Vector2
---@field public TimeLength double
---@field public TimePosition double
---@field public Video Content
---@field public Volume float
---@field public DidLoop RBXScriptSignal.DidLoop
---@field public Ended RBXScriptSignal.Ended
---@field public Loaded RBXScriptSignal.Loaded
---@field public Paused RBXScriptSignal.Paused
---@field public Played RBXScriptSignal.Played
---A VideoFrame renders a rectangle, like a `Frame` does, with a moving video
---image. The video must be from a file uploaded to the Roblox website.
---
---The video is scaled to fit the entirety of the rectangle, but looks best when
---displayed at its native resolution.
---
---## 2D and 3D Sound
---
---A VideoFrame placed underneath `SurfaceGui` on a `BasePart` will emit its
---sound from that part's `BasePart/Position`.
---
---A VideoFrame exhibits the Doppler effect, meaning its frequency and pitch
---varies with the relative motion of whatever part it is attached to.
---
---The volume of the VideoFrame will be determined by the distance between the
---client's sound listener (by default the `Camera` position) and the position of
---the VideoFrame's part.
---
---A VideoFrame is considered **"global"** if it is not placed underneath
---SurfaceGui on a BasePart. In this case, the sound will play at the same volume
---throughout the entire place.
---
local VideoFrame;
---This property will be true when the `VideoFrame/Video` has loaded from
---Roblox servers and is ready to play.
---
VideoFrame.IsLoaded = nil;
---This property sets whether or not the `VideoFrame/Video` repeats once it
---has finished when it is playing.
---
VideoFrame.Looped = nil;
---This property indicates whether the `VideoFrame/Video` is currently
---playing. It can be set to start or pause playback as an alternative to the
---`VideoFrame/Play` and `VideoFrame/Pause` functions.
---
VideoFrame.Playing = nil;
---This property gets the original source resolution of the
---`VideoFrame/Video` file.
---
VideoFrame.Resolution = nil;
---This property indicates the length of the `VideoFrame/Video` in seconds.
---If the video is not loaded, this value will be 0.
---
VideoFrame.TimeLength = nil;
---This property indicates the progress in seconds of the `VideoFrame/Video`.
---It can be changed to move the playback position of the video both before
---and during playback.
---
VideoFrame.TimePosition = nil;
---The content ID of the video file a `VideoFrame` object is associated with.
---
VideoFrame.Video = nil;
---This property determines how loud the `VideoFrame/Video` plays back. It
---can be set to a number between 0 and 100.
---
VideoFrame.Volume = nil;
---@return void
---Sets `VideoFrame/Playing` to true, This plays the `VideoFrame/Video`,
---continuing from the current `VideoFrame/TimePosition`.
---
VideoFrame.Play = function(self) end;
---@return void
---Sets `VideoFrame/Playing` to false, pausing playback if the
---`VideoFrame/Video` is playing.
---
---As `VideoFrame/TimePosition` is not reset, when the video is resumed it
---will continue from its previous position.
---
VideoFrame.Pause = function(self) end;
---@class RBXScriptSignal.DidLoop : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.DidLoop, callback: fun(video: string)): RBXScriptConnection
---An event that fires whenever the `VideoFrame/Video` loops. Returns the
---content ID of the video.
---
VideoFrame.DidLoop = nil;
---@class RBXScriptSignal.Ended : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.Ended, callback: fun(video: string)): RBXScriptConnection
---This event fires when the `VideoFrame/Video` has completed playback and
---stopped.
---
VideoFrame.Ended = nil;
---@class RBXScriptSignal.Loaded : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.Loaded, callback: fun(video: string)): RBXScriptConnection
---This event fires when the `VideoFrame/Video` is loaded.
---
VideoFrame.Loaded = nil;
---@class RBXScriptSignal.Paused : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.Paused, callback: fun(video: string)): RBXScriptConnection
---This event fires whenever the `VideoFrame/Video` is paused using
---`VideoFrame/Pause` or by setting `VideoFrame/Playing` to false.
---
VideoFrame.Paused = nil;
---@class RBXScriptSignal.Played : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.Played, callback: fun(video: string)): RBXScriptConnection
---This event fires whenever the `VideoFrame/Video` is played using the
---`VideoFrame/Play` function or by setting `VideoFrame/Playing` to true.
---
VideoFrame.Played = nil;
---@class ViewportFrame : GuiObject, GuiBase2d, GuiBase, Instance
---@field public Ambient Color3
---@field public CurrentCamera Camera
---@field public ImageColor3 Color3
---@field public ImageTransparency float
---@field public LightColor Color3
---@field public LightDirection Vector3
---A **ViewportFrame** is a type of `GuiObject|GUI` that can render 3D objects
---inside its bounds. This is a great way to display 3D objects/models in a 2D
---GUI space like a `ScreenGui`. At the moment, no shadow or post effects are
---available. Neon and Glass `Enum/Material|materials` will be rendered on lowest
---quality.
---
---For a step-by-step walkthrough, see the
---[Frames](/building-and-visuals/ui/frames).
---
local ViewportFrame;
---This property determines the lighting hue applied to the area within the
---`ViewportFrame`. This property defaults to 200, 200, 200 (ghost grey).
---
ViewportFrame.Ambient = nil;
---This property is a `Camera` instance that is used to render children
---objects. Defaults to _nil_.
---
---The `Camera` object will not replicate so the
---`ViewportFrame/CurrentCamera` won't replicate either. If you save a Camera
---in the server, it will not appear in the client. When you set this
---property, `Camera/CFrame` and `Camera/FieldOfView` will be saved and
---replicate with `ViewportFrame` internally so the client can render
---ViewportFrame without a Camera object. If you want to change the client's
---Camera, you have to create a new Camera using a `LocalScript` at runtime.
---
ViewportFrame.CurrentCamera = nil;
---This property determines how a rendered image will be colorized. It allows
---you to change the image color without directly modifying the rendered
---object.The default colorization value is
---`DataType/Color3|Color3.new(1,1,1) (white). When set to white no
---colorization occurs.
---
---It functions similarly to `ImageLabel/ImageColor3` and
---`Decal/Color3`except that it is applied to the rendered image.
---
---The image below demonstrates the same ViewportFrame with two different
---colorizations. The first image has the default (white) colorization and
---the second image has a `Color3.new(255, 255, 102)` (yellow) colorization.
---![ViewportFrame with the default white colorization][1]
---![ViewportFrame with a yellow colorization][2]
---
---See also:
---
---- `ViewportFrame/ImageTransparency`, determines the transparency of the
---  rendered image
---- `ViewportFrame/CurrentCamera`, the `Camera` that is used to render
---  children objects
---
---[1]: /assets/blt5926492ac1373d11/Screen_Shot_2019-02-09_at_8.03.48_PM.png
---[2]: /assets/bltaca53dbfce931b31/Screen_Shot_2019-02-09_at_8.08.58_PM.png
---
ViewportFrame.ImageColor3 = nil;
---This property determines the transparency of the rendered image. It allows
---you to change the image transparency without directly modifying the
---rendered object. A value of 0 is completely opaque, and a value of 1 is
---completely transparent (invisible). The default transparency is 0.
---
---This property behaves similarly to `GuiObject/BackgroundTransparency` or
---`BasePart/Transparency` except that it is applied to the rendered image.
---
---The image below demonstrates the same ViewportFrame with two different
---transparency. The first image has a transparency of 0 and the second image
---has a transparency of 0.5.
---
---![ViewportFrame with default 0 transparency][1]
---![ViewportFrame with 0.5 transparencu][2]
---
---See also:
---
---- `ViewportFrame/ImageColor3`, determines how a rendered image will be
---  colorized
---- `ViewportFrame/CurrentCamera`, the `Camera` that is used to render
---  children objects
---
---[1]: /assets/blt5926492ac1373d11/Screen_Shot_2019-02-09_at_8.03.48_PM.png
---[2]: /assets/bltdfca66b7936eee42/Screen_Shot_2019-02-09_at_8.23.38_PM.png
---
ViewportFrame.ImageTransparency = nil;
---The color of the emitted light. This property defaults to 140, 140, 140
---(silver flip/flop).
---
ViewportFrame.LightColor = nil;
---A `DataType/Vector3` representing the direction of the light source from
---the position 0, 0, 0. This property defaults to -1, -1, -1.
---
ViewportFrame.LightDirection = nil;
---@class VirtualInputManager : Instance
---@field public AdditionalLuaState string
---@field public PlaybackCompleted RBXScriptSignal.PlaybackCompleted
---@field public RecordingCompleted RBXScriptSignal.RecordingCompleted
---VirtualInputManager is an internal service used by Roblox to record inputs and
---play them back during performance benchmarking tests. This service's API can
---only be used by `CoreScript`.
---
local VirtualInputManager;
---
VirtualInputManager.AdditionalLuaState = nil;
---@param x float
---@param y float
---@param z float
---@return void
VirtualInputManager.SendGravityEvent = function(self, x, y, z) end;
---@return void
VirtualInputManager.StopRecording = function(self) end;
---@param quatX float
---@param quatY float
---@param quatZ float
---@param quatW float
---@return void
VirtualInputManager.SendGyroscopeEvent = function(self, quatX, quatY, quatZ, quatW) end;
---@param namespace string
---@param detail string
---@param detailType string
---@return void
VirtualInputManager.sendRobloxEvent = function(self, namespace, detail, detailType) end;
---@param inputTypesToIgnore Variant
---@return void
VirtualInputManager.SetInputTypesToIgnore = function(self, inputTypesToIgnore) end;
---@param x float
---@param y float
---@param layerCollector Instance
---@return void
VirtualInputManager.SendMouseMoveEvent = function(self, x, y, layerCollector) end;
---@param deviceId int
---@param keyCode KeyCode
---@param buttonState int
---@return void
VirtualInputManager.HandleGamepadButtonInput = function(self, deviceId, keyCode, buttonState) end;
---@param fileName string
---@return void
VirtualInputManager.StartPlaying = function(self, fileName) end;
---@param x float
---@param y float
---@param isForwardScroll bool
---@param layerCollector Instance
---@return void
VirtualInputManager.SendMouseWheelEvent = function(self, x, y, isForwardScroll, layerCollector) end;
---@param isPressed bool
---@param keyCode KeyCode
---@param isRepeatedKey bool
---@param layerCollector Instance
---@return void
VirtualInputManager.SendKeyEvent = function(self, isPressed, keyCode, isRepeatedKey, layerCollector) end;
---@return void
VirtualInputManager.WaitForInputEventsProcessed = function(self) end;
---@param deviceId int
---@return void
VirtualInputManager.HandleGamepadConnect = function(self, deviceId) end;
---@param themeName string
---@return void
VirtualInputManager.sendThemeChangeEvent = function(self, themeName) end;
---@param str string
---@param layerCollector Instance
---@return void
VirtualInputManager.SendTextInputCharacterEvent = function(self, str, layerCollector) end;
---@param string string
---@return void
VirtualInputManager.StartPlayingJSON = function(self, string) end;
---@return void
VirtualInputManager.Dump = function(self) end;
---@param deviceId int
---@return void
VirtualInputManager.HandleGamepadDisconnect = function(self, deviceId) end;
---@return void
VirtualInputManager.StartRecording = function(self) end;
---@param x int
---@param y int
---@param mouseButton int
---@param isDown bool
---@param layerCollector Instance
---@param repeatCount int
---@return void
VirtualInputManager.SendMouseButtonEvent = function(self, x, y, mouseButton, isDown, layerCollector, repeatCount) end;
---@param objectId int
---@param keyCode KeyCode
---@param x float
---@param y float
---@param z float
---@return void
VirtualInputManager.HandleGamepadAxisInput = function(self, objectId, keyCode, x, y, z) end;
---@param touchId int64
---@param state int
---@param x float
---@param y float
---@return void
VirtualInputManager.SendTouchEvent = function(self, touchId, state, x, y) end;
---@return void
VirtualInputManager.StopPlaying = function(self) end;
---@param x float
---@param y float
---@param z float
---@return void
VirtualInputManager.SendAccelerometerEvent = function(self, x, y, z) end;
---@class RBXScriptSignal.PlaybackCompleted : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.PlaybackCompleted, callback: fun(additionalLuaState: string)): RBXScriptConnection
---
VirtualInputManager.PlaybackCompleted = nil;
---@class RBXScriptSignal.RecordingCompleted : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.RecordingCompleted, callback: fun(result: string)): RBXScriptConnection
---
VirtualInputManager.RecordingCompleted = nil;
---@class VirtualUser : Instance
---VirtualUser is a service that allows you to record the inputs of a user, and
---then play it back to a limited extent. This service hasn't been maintained in
---several years, so it doesn't work very well anymore.
---
local VirtualUser;
---@param position Vector2
---@param camera CFrame
---@return void
---Simulates the user releasing the left mouse button.
---
VirtualUser.Button1Up = function(self, position, camera) end;
---@param position Vector2
---@param camera CFrame
---@return void
---Simulates the user moving the mouse cursor to a specific position.
---
VirtualUser.MoveMouse = function(self, position, camera) end;
---@param position Vector2
---@param camera CFrame
---@return void
---Simulates the user holding the right mouse button down.
---
VirtualUser.Button2Down = function(self, position, camera) end;
---@param key string
---@return void
---Simulates the user typing a key.
---
VirtualUser.TypeKey = function(self, key) end;
---@param key string
---@return void
---Simulates the user holding a key down.
---
VirtualUser.SetKeyDown = function(self, key) end;
---@param position Vector2
---@param camera CFrame
---@return void
---Simulates the user releasing the right mouse button.
---
VirtualUser.Button2Up = function(self, position, camera) end;
---@param position Vector2
---@param camera CFrame
---@return void
---Simulates the user holding the left mouse button down.
---
VirtualUser.Button1Down = function(self, position, camera) end;
---@return void
---Attempts to gain priority over the hardware controller's input, in favor
---of the VirtualUser's simulated input.
---
VirtualUser.CaptureController = function(self) end;
---@return string
---Stops recording the user's input. Returns a Lua script as a string, that
---allows you to playback the inputs that were recorded.
---
VirtualUser.StopRecording = function(self) end;
---@param position Vector2
---@param camera CFrame
---@return void
---Simulates the user clicking the left mouse button.
---
VirtualUser.ClickButton1 = function(self, position, camera) end;
---@param key string
---@return void
---Simulates the user releasing a key.
---
VirtualUser.SetKeyUp = function(self, key) end;
---@return void
---Starts recording the user's input.
---
VirtualUser.StartRecording = function(self) end;
---@param position Vector2
---@param camera CFrame
---@return void
---Simulates the user clicking the right mouse button.
---
VirtualUser.ClickButton2 = function(self, position, camera) end;
---@class VisibilityService : Instance
local VisibilityService;
---@class Visit : Instance
---The Visit service is a backend service used by Roblox. Its functions are not
---accessible to developers in any form.
---
local Visit;
---@class VoiceChannel : Instance
local VoiceChannel;
---@param userId int64
---@return Tuple
VoiceChannel.AddUserAsync = function(self, userId) end;
---@class VoiceChatInternal : Instance
---@field public VoiceChatState VoiceChatState
---@field public ParticipantsStateChanged RBXScriptSignal.ParticipantsStateChanged
---@field public PlayerMicActivitySignalChange RBXScriptSignal.PlayerMicActivitySignalChange
---@field public StateChanged RBXScriptSignal.StateChanged
local VoiceChatInternal;
---
VoiceChatInternal.VoiceChatState = nil;
---@return bool
VoiceChatInternal.IsContextVoiceEnabled = function(self) end;
---@param groupId string
---@param isMicMuted bool
---@return bool
VoiceChatInternal.JoinByGroupIdToken = function(self, groupId, isMicMuted) end;
---@return bool
VoiceChatInternal.IsPublishPaused = function(self) end;
---@return string
VoiceChatInternal.GetAndClearCallFailureMessage = function(self) end;
---@param paused bool
---@return bool
VoiceChatInternal.PublishPause = function(self, paused) end;
---@param paused bool
---@return bool
VoiceChatInternal.SubscribePauseAll = function(self, paused) end;
---@return string
VoiceChatInternal.GetGroupId = function(self) end;
---@param userId int64
---@return bool
VoiceChatInternal.SubscribeRetry = function(self, userId) end;
---@return Tuple
VoiceChatInternal.GetMicDevices = function(self) end;
---@param micDeviceName string
---@param micDeviceGuid string
---@return void
VoiceChatInternal.SetMicDevice = function(self, micDeviceName, micDeviceGuid) end;
---@return Array
VoiceChatInternal.GetParticipants = function(self) end;
---@param userId int64
---@return bool
VoiceChatInternal.IsVoiceEnabledForUserIdAsync = function(self, userId) end;
---@param userId int64
---@return bool
VoiceChatInternal.SubscribeUnblock = function(self, userId) end;
---@return Tuple
VoiceChatInternal.GetSpeakerDevices = function(self) end;
---@param userId int64
---@param paused bool
---@return bool
VoiceChatInternal.SubscribePause = function(self, userId, paused) end;
---@param userId int64
---@return bool
VoiceChatInternal.SubscribeBlock = function(self, userId) end;
---@param groupId string
---@param isMicMuted bool
---@return bool
VoiceChatInternal.JoinByGroupId = function(self, groupId, isMicMuted) end;
---@param speakerDeviceName string
---@param speakerDeviceGuid string
---@return void
VoiceChatInternal.SetSpeakerDevice = function(self, speakerDeviceName, speakerDeviceGuid) end;
---@return int
VoiceChatInternal.GetVoiceChatApiVersion = function(self) end;
---@param userId int64
---@return bool
VoiceChatInternal.IsSubscribePaused = function(self, userId) end;
---@return int
VoiceChatInternal.GetVoiceChatAvailable = function(self) end;
---@return Tuple
VoiceChatInternal.GetAudioProcessingSettings = function(self) end;
---@return void
VoiceChatInternal.Leave = function(self) end;
---@class RBXScriptSignal.ParticipantsStateChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.ParticipantsStateChanged, callback: fun(participantsLeft: Array, participantsJoined: Array, updatedStates: Array)): RBXScriptConnection
---
VoiceChatInternal.ParticipantsStateChanged = nil;
---@class RBXScriptSignal.PlayerMicActivitySignalChange : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.PlayerMicActivitySignalChange, callback: fun(activityInfo: Dictionary)): RBXScriptConnection
---
VoiceChatInternal.PlayerMicActivitySignalChange = nil;
---@class RBXScriptSignal.StateChanged : RBXScriptSignal
---@field public Connect fun(self: RBXScriptSignal.StateChanged, callback: fun(old: VoiceChatState, new: VoiceChatState)): RBXScriptConnection
---
VoiceChatInternal.StateChanged = nil;
---@class VoiceChatService : Instance
---@field public EnableDefaultVoice bool
---@field public VoiceChatEnabledForPlaceOnRcc bool
---@field public VoiceChatEnabledForUniverseOnRcc bool
local VoiceChatService;
---Indicates whether or not the place uses the default voice manager. This is
---on by default.
---
---When enabled, the default voice manager adds all voice eligible users to
---the spatial voice chat as they join the place.
---
---When disabled, the place doesn't use the default voice manager, and users
---are not added to the spatial voice chat when they join the place.
---
VoiceChatService.EnableDefaultVoice = nil;
---
VoiceChatService.VoiceChatEnabledForPlaceOnRcc = nil;
---
VoiceChatService.VoiceChatEnabledForUniverseOnRcc = nil;
---@param userId int64
---@return bool
---Returns whether or not the given user has voice enabled. On the
---client-side, this can only be used to check the voice status of the local
---player.
---
---This function is not yet implemented server-side.
---
---This function can throw an error if the HTTP call fails.
---
---The following code sample enables a UI layer only for voice enabled
---players.
---
---```lua
---local Players = game:GetService(“Players”)
---local VoiceChatService = game:GetService(“VoiceChatService”)
---
---local localPlayer = Players.LocalPlayer
---local success, enabled = pcall(function()
---    return VoiceChatService:IsVoiceEnabledForUserIdAsync(localPlayer.UserId)
---end)
---if success and enabled then
---    localPlayer.PlayerGui.MyVoiceGui.Enabled = true
---end
---
---```
---
VoiceChatService.IsVoiceEnabledForUserIdAsync = function(self, userId) end;
---@class VoiceSource : Instance
---@field public UserId int64
local VoiceSource;
---
VoiceSource.UserId = nil;
---@class WedgePart : FormFactorPart, BasePart, PVInstance, Instance
---WedgeParts are great for building slopes because of their slanted surface.
---They can even be rotated onto their slant so that they can be used at an angle
---to make a triangular ramp. Due to their collision, WedgeParts can be good for
---quickly rotating bricks to a certain angle within Roblox Studio, making them a
---quick solution to using scripting methods such as CFrame to perform the same
---function. WedgeParts can be adjusted to any size a regular brick can so that
---they can be aligned with the rest of your building work. WedgeParts, when used
---next to each other at different angles, can also make great curved ramps
---without the need for CFrame too
---
local WedgePart;
---@class Weld : JointInstance, Instance
---An object used to hold two objects together in a relative position, regardless
---of whether they're touching. This object is placed inside of a `BasePart` and
---the `JointInstance/Part1|Part1` property determines which other part should be
---welded to the original part. Two `datatype/CFrame|CFrames`,
---`JointInstance/C0|C0` and `JointInstance/C1|C1`, then determine how the parts
---should be placed.
---
---See also `WeldConstraint` for a newer alternative using the constraints system
---that does not require `JointInstance/C0|C0` or `JointInstance/C1|C1`
---properties to be manually set.
---
---While the weld is `JointInstance/Active|Active`, it maintains the part
---positions such that: `part1.CFrame * C1 == Part0.CFrame * C0`
---
---## Root part
---
---Every Assembly has a root part, see `BasePart/GetRootPart`. When a Weld's
---`JointInstance/C0|C0`/`JointInstance/C1|C1` is modified the root part will
---stay where it was.
---
---## Directionality
---
---Welds do not have any directionality. `JointInstance/Part0|Part0` or
---`JointInstance/Part1|Part1`, doesn't matter. You can imagine rigid joints
---forming a tree branching down from the root part. All the parts down the tree
---from root will move, and their welded “children” in this tree will move with
---them.
---
local Weld;
---@class WeldConstraint : Instance
---@field public Active bool
---@field public Enabled bool
---@field public Part0 BasePart
---@field public Part1 BasePart
---**WeldConstraints** are used to attach two `BasePart|parts` together. The
---constraint makes sure that the parts stay in the same relative position and
---orientation to one another, meaning that if one part moves, the other will
---move the same amount. Even if the two parts are not touching one another, they
---can be welded together with a weld constraint.
---
---The most common way to create a weld constraint is through the Studio
---**Create** menu in the **Model** tab (select **Weld**). This tool will act
---differently based on how many parts are selected when the tool is activated:
---
---- If no parts are selected when the **Weld** tool is clicked, the next two
---  parts that are clicked on will be welded together. If the same part is
---  clicked twice, no weld will be created.
---- If one part is selected when the **Weld** tool is clicked, the next part
---  that is clicked on will be welded to the selected part.
---- If several parts are selected when the **Weld** tool is clicked, any parts
---  in that selection that are touching or overlapping will be welded together.
---
---## Repositioning Welded Parts
---
---Roblox handles moving a welded part differently depending on whether the part
---was moved using its `BasePart/Position|Position` or with its
---`datatype/CFrame|CFrame`.
---
---If a welded part's `BasePart/Position|Position` is updated, the part will move
---but none of the connected parts will move with it. The weld will recalculate
---the offset from the other part based on the part's new position.
---
---```lua
----- Create two parts and position them at the same height
---local partA = Instance.new("Part")
---local partB = Instance.new("Part")
---partA.Position = Vector3.new(0, 10, 0)
---partB.Position = Vector3.new(0, 10, 10)
---partA.Parent = workspace
---partB.Parent = workspace
---
----- Weld the two parts together
---local weld = Instance.new("WeldConstraint")
---weld.Parent = workspace
---weld.Part0 = partA
---weld.Part1 = partB
---
----- Update the position of the first part; the first part will move but the second will stay where it started
---partA.Position = Vector3.new(0, 20, 0)
---```
---
---In contrast, if a part's `datatype/CFrame|CFrame` is updated, that part will
---move and any part welded to that part will also move. These other parts will
---be moved to make sure they maintain the same offset as when the weld was
---created.
---
---```lua
----- Create two parts and position them at the same height
---local partA = Instance.new("Part")
---local partB = Instance.new("Part")
---partA.Position = Vector3.new(0, 10, 0)
---partB.Position = Vector3.new(0, 10, 10)
---partA.Parent = workspace
---partB.Parent = workspace
---
----- Weld the two parts together
---local weld = Instance.new("WeldConstraint")
---weld.Parent = workspace
---weld.Part0 = partA
---weld.Part1 = partB
---
----- Update the CFrame of the first part; the second part will also move to maintain the offset of the weld
---partA.CFrame = CFrame.new(0, 20, 0)
---```
---
local WeldConstraint;
---True if the WeldConstraint is currently active in the world.
---
---If the WeldConstraint or one of its parts is not in `Workspace` the weld
---will be inactive.
---
---Rigid joints like `Weld`, `Snap`, `WeldConstraint`, `Motor`, or `Motor6D`
---may also be disabled due to conflicts with other rigid joints, such as
---joints between the same two parts or indirect cycles in the weld graph.
---Joints disabled this way may be re-enabled later when another joint or
---part is added or removed.
---
---Duplicate WeldConstraints do not conflict because WeldConstraints derive
---their internal CFrames from the relative positions of their parts when
---they are enabled and all update when `BasePart/Position` or
---`BasePart/Orientation` is set on a part. The spanning tree may still
---disable them if they are redundant or form a cycle.
---
WeldConstraint.Active = nil;
---The **Enabled** property of a `WeldConstraint` sets whether the constraint
---is active or not. When this property is set to true, if the constraint's
---`WeldConstraint/Part0` and `WeldConstraint/Part1` properties are set, then
---the constraint will ensure that its two connected parts will be locked
---together.
---
WeldConstraint.Enabled = nil;
---The **Part0** and `WeldConstraint/Part1` properties of a `WeldConstraint`
---set which two `BasePart` the weld connects. As soon as both properties are
---set and the weld is `WeldConstraint/Enabled`, the weld will lock the two
---parts together.
---
---If Part0 or Part1 are ever set to new parts, then the WeldConstraint will
---instantly link the new part. The old part will no longer be constrained.
---
---```lua
---local partA = Instance.new("Part")
---local partB = Instance.new("Part")
---
---partA.Position = Vector3.new(0, 10, 0)
---partA.Parent = game.Workspace
---
---partB.Position = Vector3.new(0, 10, 10)
---partB.Parent = game.Workspace
---
---local weld = Instance.new("WeldConstraint")
---weld.Parent = partA
---weld.Part0 = partAweld.Part1 = partB
---```
---
WeldConstraint.Part0 = nil;
---The `WeldConstraint/Part0` and **Part1** properties of a `WeldConstraint`
---set which two `BasePart` the weld connects. As soon as both properties are
---set and the weld is `WeldConstraint/Enabled`, the weld will lock the two
---parts together.
---
---If Part0 or Part1 are ever set to new parts, then the WeldConstraint will
---instantly link the new part. The old part will no longer be constrained.
---
---```lua
---local partA = Instance.new("Part")
---local partB = Instance.new("Part")
---
---partA.Position = Vector3.new(0, 10, 0)
---partA.Parent = game.Workspace
---
---partB.Position = Vector3.new(0, 10, 10)
---partB.Parent = game.Workspace
---
---local weld = Instance.new("WeldConstraint")
---weld.Parent = partA
---weld.Part0 = partA
---weld.Part1 = partB
---```
---
WeldConstraint.Part1 = nil;
---@class Workspace : WorldRoot, Model, PVInstance, Instance
---@field public AllowThirdPartySales bool
---@field public AnimationWeightedBlendFix NewAnimationRuntimeSetting
---@field public ClientAnimatorThrottling ClientAnimatorThrottlingMode
---@field public CurrentCamera Camera
---@field public DistributedGameTime double
---@field public FallenPartsDestroyHeight float
---@field public FilteringEnabled bool
---@field public GlobalWind Vector3
---@field public Gravity float
---@field public HumanoidOnlySetCollisionsOnStateChange HumanoidOnlySetCollisionsOnStateChange
---@field public InterpolationThrottling InterpolationThrottlingMode
---@field public MeshPartHeadsAndAccessories MeshPartHeadsAndAccessories
---@field public PhysicsSimulationRate PhysicsSimulationRate
---@field public PhysicsSteppingMethod PhysicsSteppingMethod
---@field public ReplicateInstanceDestroySetting ReplicateInstanceDestroySetting
---@field public Retargeting AnimatorRetargetingMode
---@field public SignalBehavior SignalBehavior
---@field public StreamOutBehavior StreamOutBehavior
---@field public StreamingEnabled bool
---@field public StreamingMinRadius int
---@field public StreamingPauseMode StreamingPauseMode
---@field public StreamingTargetRadius int
---@field public Terrain Terrain
---@field public TouchesUseCollisionGroups bool
---The Workspace is the service in which any objects that are to be rendered in
---the 3D world exist. Objects not descending from Workspace will not be rendered
---or physically interact with the world.
---
---## What does the Workspace do?
---
---The core job of the Workspace is to hold objects that exist in the 3D world,
---`BasePart|BaseParts` and `Attachment|Attachments`. Whilst such objects are
---descendant of Workspace, they will be active. For BaseParts this means they
---will be rendered, and physically interact with other parts and the world. For
---`Attachment`s this means objects adorned to them, such as
---`ParticleEmitter|ParticleEmitters`, `Beam|Beams` and
---`BillboardGui|BillboardGuis` will render.
---
---Understanding this behavior is important, as it means objects can be removed
---from the Workspace when they are not needed. For example, map `Model|Models`
---can be removed from the `Workspace` when a different map is being played on.
---Objects that are not immediately needed in the Workspace are generally stored
---in `ReplicatedStorage` or `ServerStorage`.
---
---In its role as the holder of active 3D objects, Workspace includes a number of
---useful functions related to parts, their positions and joints between them.
---
---## Accessing the Workspace
---
---The Workspace can be accessed several ways, all of which are valid.
---
---```
---workspace -- a global variable
---game.Workspace -- a property of the DataModel
---game:GetService("Workspace") -- Workspace is a service
---```
---
---Note:
---
---- Objects that require adornment, such as `ParticleEmitter`s and
---  `BillboardGui`s will be adorned to the _0, 0, 0_ position when adorned to
---  the Workspace (parented to it without an adornee otherwise being set)
---- The `Model/MakeJoints` and `Model/BreakJoints` functions inherited from the
---  `Model` class are overridden by the Workspace's own `Workspace/MakeJoints`
---  and `Workspace/BreakJoints` functions, which can only be used in plugins
---- It is impossible to delete the Workspace
---- The Workspace will also clean up `BasePart`s that fall beneath
---  `Workspace/FallenPartsDestroyHeight`
---- A client's current `Camera` object can be accessed using the
---  `Workspace/CurrentCamera` property
---- The `Terrain` object can be accessed using the `Workspace/Terrain` property
---
local Workspace;
---This `Workspace` property determines whether assets created by other uses
---can be sold in the game.
---
---#### What are third party sales?
---
---When this value is false, as it is by default, only assets created by the
---place creator (be it a player or a group) and Roblox can be sold using
---`MarketplaceService`.
---
---In most cases, games do not need to sell third party assets. However, some
---games such as trade hangouts require this feature and therefore it exists
---as an opt-in option.
---
---#### What third party products can I sell?
---
---Note, [developer products](/production/monetization/developer-products can
---only be sold in the game they are associated with, regardless of what
---AllowThirdPartySales is set to. This property affects
---[Game Passes](/production/monetization/game-passes) and
---[clothing](/avatar/accessories/classic-clothing).
---
Workspace.AllowThirdPartySales = nil;
---
Workspace.AnimationWeightedBlendFix = nil;
---Specifies the `Enum.ClientAnimatorThrottlingMode` to use for the local
---client.
---
---When enabled, animations on remotely-simulated `Model` instances will
---begin to throttle. The throttler calculates throttling intensity using:
---
---- Visibility of a `Model` in relation to the `Camera`
---- In-game FPS
---- Number of active animations
---
Workspace.ClientAnimatorThrottling = nil;
---The `Camera` object being used by the local player.
---
---#### How to use CurrentCamera
---
---This property can be set. When it is set, all other `Camera` objects in
---the `Workspace` are destroyed, including the previous CurrentCamera. If
---this property is set to nil, or the CurrentCamera is otherwise destroyed,
---a new `Camera` will be created and assigned. Developers should avoid
---setting this property to nil or destroying the CurrentCamera however as it
---can have unintended consequences.
---
---When looking for a client's `Camera` object, developers should use this
---property rather than looking for a child of `Workspace` named 'Camera'.
---
---#### What can be done with CurrentCamera
---
---Accessing a client's current `Camera` object brings a range of uses.
---
---- Manipulating the viewport using the `Camera` functions
---- Objects parented to the `Camera` will not replicate to the server,
---  regardless of what `Workspace/FilteringEnabled` is set to. Prior to
---  `Workspace/FilteringEnabled`, this was the main way to render
---  `BasePart`s on one client only.
---
---Below is an example of how this property can be used to access the
---`Camera` object and increase its `Camera/FieldOfView`.
---
---```
---workspace.CurrentCamera.FieldOfView = 100
---```
---
Workspace.CurrentCamera = nil;
---The amount of time, in seconds, that the game has been running.
---
---Despite the title, this value is currently not 'Distributed' across the
---client and the server. Instead, on the server it represents how long the
---server has been running. On the client, it represents how long the client
---has been connected to the server.
---
---Developers should not rely on the above behavior, and it is possible this
---property will be synchronized across clients and the server in the future.
---
---Those looking for the time since the program started running should use
---the 'time' function instead. See below for a comparison between
---DistributedGameTime and its alternatives.
---
---```
---print(workspace.DistributedGameTime) --&gt; Time the game started running
---print(os.time()) --&gt; Time since epoch (1 January 1970, 00:00:00) UTC
---print(tick()) --&gt; Time since epoch (1 January 1970, 00:00:00) system time
---print(time()) --&gt; Time the game started running
---print(elapsedTime()) --&gt; Time since Roblox started running
---```
---
Workspace.DistributedGameTime = nil;
---This property determines the height at which falling `BasePart|BaseParts`
---(and their ancestor `Model|Models`) are removed from Workspace.
---
---![Parts being removed at the FallenPartsDestroyHeight][1]
---
---#### What happens to falling parts?
---
---For performance reasons, Roblox automatically parents parts that fall
---below this value to `nil`. This is to prevent parts that have fallen off
---the map from continuing to fall forever.
---
---If a part removed due to this behavior is the last part in a `Model`, then
---that model will also be removed. This applies to all model ancestors of
---the part.
---
---This property can be read by scripts, but can only be set by plugins, the
---command bar, or the properties window in Studio.
---
---This property is clamped between -50,000 and 50,000. This is because
---`BasePart`s do not simulate or render properly at a great distance from
---the origin due to floating point inaccuracies.
---
---[1]: /assets/blt3ab195d142a5f6ee/FallenPartsDestroyHeight.gif
---
Workspace.FallenPartsDestroyHeight = nil;
---**Warning:** Experimental Mode has been discontinued, meaning this
---property will no longer take effect.
---
---Determines whether changes made from the client will replicate to the
---server or not. When this property is disabled, the game is in
---'Experimental Mode'.
---
---This property is not replicated, meaning it cannot be changed once the
---game has started. For this reason, developers should only set this
---property in Roblox Studio.
---
---#### What does FilteringEnabled do?
---
---When FilteringEnabled is disabled, the place is in 'Experimental Mode'. In
---'Experimental Mode', changes made to the game on the client replicate back
---to the server. For some, this makes games simpler to make, but means
---exploiters can change nearly anything in the game (such as deleting the
---baseplate).
---
---When FilteringEnabled is enabled, everything continues to replicate from
---the server to the client (with a few exceptions such as `ServerStorage`
---and `ServerScriptStorage`). However, actions made by the client will no
---longer freely replicate to the server. Instead, `RemoteEvent`s and
---`RemoteFunction`s need to be used by the client to 'request' the server
---preforms certain actions on its behalf.
---
---#### What are the exceptions to FilteringEnabled?
---
---Whilst FilteringEnabled prevents almost everything from replicating from
---the client to the server, there are some exceptions.
---
---- Some properties on the local `Humanoid`
---- `Sound` playback, when `SoundService/RespectFilteringEnabled` is set to
---  false
---- `ClickDetector` input events
---- `AnimationTrack` playback
---- Physics simulated on `BasePart`s which the client has network ownership.
---
---#### Is FilteringEnabled more secure?
---
---Enabling FilteringEnabled is the best way of restricting exploiters from
---ruining your games. When it is enabled, with a few exceptions, changes
---made by clients will not replicate to the server (and therefore will not
---replicate to other clients). This means, if your game is properly
---designed, exploiters will find it much harder to operate in your game.
---
---Enabling FilteringEnabled however, has implications on a game's design
---that developers must consider. Before using it, it is highly recommended
---developers familiarize themselves on the following topics:
---
---- [Converting Experimental Mode games][4] Converting a game to use
---  FilteringEnabled
---- [Game Security][5] How to use FilteringEnabled to improve the security
---  of your game
---
---[1]: https://developer.roblox.com/articles/Network-Ownership
---[2]: https://developer.roblox.com/articles/Experimental-Mode
---[3]:
---  https://developer.roblox.com/articles/Building-Games-with-Experimental-Mode-Off
---[4]:
---  https://developer.roblox.com/articles/Converting-From-Experimental-Mode
---[5]: https://developer.roblox.com/articles/Game-Security
---
Workspace.FilteringEnabled = nil;
---
Workspace.GlobalWind = nil;
---Determines the acceleration due to gravity applied to falling
---`BasePart|BaseParts`. This value is measured in studs per second squared
---and by default is set to 196.2 studs/second<sup>2</sup>. By changing this
---value, developers can simulate the effects of lower or higher gravity in
---game.
---
Workspace.Gravity = nil;
---Sets the behavior of all Humanoids for setting part collisions. See
---Enum.HumanoidOnlySetCollisionOnStateChange for description of each option.
---
Workspace.HumanoidOnlySetCollisionsOnStateChange = nil;
---
Workspace.InterpolationThrottling = nil;
---Sets whether character Heads and Accessories should be downloaded as
---`MeshPart`s. The "Default" value is the same as "Enabled". If this feature
---is enabled, built-in avatars will use `MeshPart`s for the character's Head
---and Accessories.
---
Workspace.MeshPartHeadsAndAccessories = nil;
---
Workspace.PhysicsSimulationRate = nil;
---Sets how the solver will advance the physics simulation forward in time.
---This option is not scriptable and must be set from the
---**PhysicsSteppingMethod** property of **Workspace** within Studio. See
---<a href="https://developer.roblox.com/articles/adaptive-timestepping">Adaptive
---Timestepping</a> for more details.
---
---<table>
---    <thead>
---        <tr>
---            <th>Option</th>
---            <th>Description</th>
---        </tr>
---    </thead>
---    <tbody>
---        <tr>
---            <td><b>Adaptive</b></td>
---            <td>The engine attempts to assign optimal simulation rates for individual assemblies of either 240 Hz, 120 Hz, or 60 Hz. This setting is optimized for performance.</td>
---        </tr>
---        <tr>
---            <td><b>Fixed</b></td>
---            <td>All simulated assemblies inside the workspace will advance forward at 240 Hz. This option is best for optimal stability and simulation accuracy.</td>
---        </tr>
---        <tr>
---            <td><b>Default</b></td>
---            <td>The current default is <b>Fixed</b>.</td>
---        </tr>
---    </tbody>
---</table>
---
---Note that when assemblies of different simulation rates become connected
---via `Constraint|Constraints` or collisions, the combined mechanism will
---default to the highest simulation rate for stability.
---
Workspace.PhysicsSteppingMethod = nil;
---
Workspace.ReplicateInstanceDestroySetting = nil;
---
Workspace.Retargeting = nil;
---
Workspace.SignalBehavior = nil;
---The **StreamOutBehavior** controls where content will be unloaded from the
---`Player/ReplicationFocus|ReplicationFocus` based on device Memory
---Conditions, or based on Streaming Radius.
---
---See also:
---
---- `Workspace/StreamingEnabled` which controls whether content streaming is
---  enabled
---- `Workspace/StreamingMinRadius`
---- `Workspace/StreamingTargetRadius`
---- `Workspace/StreamingPauseMode`
---
Workspace.StreamOutBehavior = nil;
---The **StreamingEnabled** property determines whether game content
---streaming is enabled for the place. This property is not scriptable and
---therefore must be set on the **Workspace** object in Studio.
---
---See also:
---
---- `Workspace/StreamingMinRadius`
---- `Workspace/StreamingTargetRadius`
---- `Workspace/StreamingPauseMode`
---
Workspace.StreamingEnabled = nil;
---The **StreamingMinRadius** property indicates the radius around the
---player's character or the current
---`Player/ReplicationFocus|ReplicationFocus` in which content will be
---streamed in at the highest priority. Defaults to 64 studs.
---
---Care should be taken when increasing the default minimum radius since
---doing so will require more memory and more server bandwidth at the expense
---of other components.
---
---See also:
---
---- `Workspace/StreamingEnabled` which controls whether content streaming is
---  enabled
---- `Workspace/StreamingTargetRadius`
---- `Workspace/StreamingPauseMode`
---
Workspace.StreamingMinRadius = nil;
---If `Workspace/StreamingEnabled` is activated, a game may behave in
---unintended ways if a player somehow moves into a region of the world that
---hasn't been streamed to them. The **streaming pause** feature helps manage
---this by pausing the local physical simulation and normal character
---movement if content within
---`Workspace/StreamingMinRadius|StreamingMinRadius` is not yet streamed in.
---Non-physical systems will continue to run (scripts will continue
---executing, for example) and gameplay will resume after the engine has
---loaded enough content to minimize further pauses.
---
---To determine the pause status, you can utilize the `Player/GameplayPaused`
---property.
---
---<img src="/assets/blt8ecbb827d16e40b5/Streaming-Pause-Screen.jpg" />
---
---See also:
---
---- `Workspace/StreamingEnabled` which controls whether content streaming is
---  enabled
---- `Workspace/StreamingMinRadius`
---- `Workspace/StreamingTargetRadius`
---
Workspace.StreamingPauseMode = nil;
---The **StreamingTargetRadius** property controls the maximum distance away
---from the player's character or the current
---`Player/ReplicationFocus|ReplicationFocus` in which content will be
---streamed in. Defaults to 1024 studs.
---
---Note that the engine is allowed to retain previously loaded content beyond
---the target radius, memory permitting.
---
---See also:
---
---- `Workspace/StreamingEnabled` which controls whether content streaming is
---  enabled
---- `Workspace/StreamingMinRadius`
---- `Workspace/StreamingPauseMode`
---
Workspace.StreamingTargetRadius = nil;
---This property is a reference to the `Terrain` object parented to the
---`Workspace`.
---
---![An example of Roblox terrain][1]
---
---This property, like `Workspace/CurrentCamera`, ensures that developers to
---not inadvertently index a descendant of `Workspace` named 'Terrain' when
---looking for a game's `Terrain` object. Without this property, developers
---would need to use the `Instance/FindFirstChildOfClass` function.
---
---```lua
---workspace.Terrain.WaterColor = Color3.new(0, 1, 0) -- make the water green
---```
---
---[1]: /assets/blt53fef90aa44799da/Terrain.png
---
Workspace.Terrain = nil;
---This property determines whether `BasePart|parts` in different groups set
---to not collide will ignore collisions and touch events. By default, the
---value of this property is set to `false`.
---
---When this property is enabled, parts in different groups et to not collide
---will also ignore the `BasePart/CanTouch|CanTouch` property, similar to how
---`BasePart/CanCollide` is ignored. For more information on the behavior of
---CanTouch, please visit its property page.
---
Workspace.TouchesUseCollisionGroups = nil;
---@return void
---Positions and zooms the `Workspace/CurrentCamera` to show the extent of
---`BasePart`s currently in the `Workspace`.
---
---This function was used in the, now removed, 'Zoom To Extents' button in
---Roblox Studio. It exhibits similar behavior to the 'Zoom To' (F shortcut)
---feature, however it shows the extents of the `Workspace` rather than the
---currently selected object.
---
---This function cannot be used in scripts but will function in the command
---bar or plugins.
---
Workspace.ZoomToExtents = function(self) end;
---@param objects Objects
---@return void
---Breaks all joints between the specified `BasePart`s and other `BasePart`s.
---
---This function requires an array of `BasePart`s. Note, joints will not be
---broken between these `BasePart`s (each other), only between these
---`BasePart`s and other `BasePart`s not in the array.
---
---This function is used by the Roblox Studio Move tool when the user starts
---moving a selection. In conjunction with `Plugin/GetJoinMode` and
---`Workspace/JoinToOutsiders` it can be used to retain join functionality
---when developing custom studio build tools. See the snippets below for an
---example.
---
---```
----- finished moving a selection, make joints
---local function finishedMovingParts(parts)
---	local joinMode = Plugin:GetJoinMode()
---	workspace:JoinToOutsiders(parts, joinMode)
---end
---```
---
---```
----- started moving a selection, break joints
---local function startMovingParts(parts)
---	workspace:UnjoinFromOutsiders(parts)
---end
---```
---
---Developers interested in seeing how this function is used in the Roblox
---Studio should see the [Studio Tools GitHub repository][1].
---
---[1]: https://github.com/Roblox/Studio-Tools
---
Workspace.UnjoinFromOutsiders = function(self, objects) end;
---@return double
---**GetServerTimeNow** returns the epoch time on the server with microsecond
---precision. The time is adjusted for drift and smoothed monotonically (it
---is guaranteed to be non-decreasing). The server clock progresses no faster
---than 1.006&times; speed and no slower than 0.994&times; speed.
---
---This function is useful for creating synchronized experiences, as it has
---three properties necessary for doing so: it is a real-world time clock, is
---monotonic and has decent precision. Essentially, it is the client's best
---guess of what `os.clock` would return on the server.
---
---This function relies on the server, so calling it from a core script on a
---client that isn't connected will throw an error.
---
---See also:
---
---- `Workspace/DistributedGameTime|DistributedGameTime`, a game-time clock
---- [`os.clock`](/reference/engine/libraries/os)
---- `datatype/DateTime`
---
Workspace.GetServerTimeNow = function(self) end;
---@param objects Objects
---@return void
---Goes through all `BasePart`s given, breaking any joints connected to these
---parts.
---
---This function will break any of the following types of joints:
---
---- `JointInstance`s such as `Connectors`, `Welds` and `Snaps`
---- `WeldConstraint`s
---
---Unlike `Break/MakeJoints`, this function requires an array of `BasePart`s
---as a parameter. This array is given as follows:
---
---```
---workspace:BreakJoints({part1, part2, part3})
---```
---
---Note, this function cannot be used by scripts and will only function in
---plugins.
---
Workspace.BreakJoints = function(self, objects) end;
---@param objects Objects
---@return void
---**Deprecated**
---
---SurfaceType based joining is deprecated, do not use MakeJoints for new
---projects. `WeldConstraint|WeldConstraints` and
---`HingeConstraint|HingeConstraints` should be used instead.
---
---Goes through all `BasePart|Parts` given. If any part's side has a
---`Enum/SurfaceType` that can make a joint it will create a joint with any
---adjacent parts.
---
---Joints will be created between the specified Parts and any planar touching
---surfaces, depending on the parts' surfaces.
---
---- Smooth surfaces will not create joints
---- Glue surfaces will create a `Glue` joint
---- Weld will create a `Weld` joint with any surface except for Unjoinable
---- Studs, Inlet, or Universal will each create a `Snap` joint with either
---  of other the other two surfaces (e.g. Studs with Inlet and Universal)
---- Hinge and Motor surfaces create `Rotate` and `RotateV` joint instances
---
---Unlike `Model/MakeJoints`, this function requires an array of parts as a
---parameter. This array is given as follows:
---
---```
---workspace:MakeJoints({part1, part2, part3})
---```
---
---Joints are broken if enough force is applied to them due to an
---`Explosion`, unless a `ForceField` object is parented to the `BasePart` or
---ancestor `Model`. For this reason, they are often used to make simple
---destructible buildings and other models.
---
Workspace.MakeJoints = function(self, objects) end;
---@param objects Objects
---@param jointType JointCreationMode
---@return void
---This function creates joints between the specified `BasePart|Parts` and
---any touching parts depending on the parts' surfaces and the specified
---joint creation mode.
---
---This function creates joints between the specified Parts and any planar
---touching surfaces, depending on the parts' surfaces and the specified
---joint creation mode.
---
---- Glue, Studs, Inlets, Universal, Weld, and Smooth surfaces will all
---  create Weld instances.
---- Spheres will not surface-weld to anything. The rounded sides of
---  cylinders will not surface-weld, but the flat end sides will.
---- Hinge and Motor surfaces will still create `Rotate` and `RotateP` joint
---  instances, regardless of part shape.
---
---The first parameter is an array of `BasePart|BaseParts`. Joints will only
---be created between the parts in the array and not in the array. Joints
---will not be created between the parts in the array.
---
---The second parameter is a `Enum/JointCreationMode` that determines how
---joints will be created. Passing in either enum value,
---`enum/JointCreationMode|Enum.JointCreationMode.All` or
---`enum/JointCreationMode|Enum.JointCreationMode.Surface`, has the same
---behavior which equates to Join Always
---
---This function is used by the Roblox Studio Move tool when the user
---finishes moving a selection. In conjunction with `Plugin/GetJoinMode` and
---`Workspace/UnjoinFromOutsiders` it can be used to retain join
---functionality when developing custom studio build tools. See the snippets
---below for an example.
---
---```lua
----- finished moving a selection, make joints
---local function finishedMovingParts(parts)
---	local joinMode = Plugin:GetJoinMode()
---	workspace:JoinToOutsiders(parts, joinMode)
---end
---```
---
---```lua
----- started moving a selection, break joints
---local function startMovingParts(parts)
---	workspace:UnjoinFromOutsiders(parts)
---end
---```
---
---Developers interested in seeing how this function is used in the Roblox
---Studio should see the [Studio Tools GitHub repository][1].
---
---[1]: https://github.com/Roblox/Studio-Tools
---
Workspace.JoinToOutsiders = function(self, objects, jointType) end;
---@param value MeshPartHeadsAndAccessories
---@return void
Workspace.SetMeshPartHeadsAndAccessories = function(self, value) end;
---@return int
---Returns the number of `BasePart`s that are deemed physically active, due
---to being recently under the influence of physics.
---
---This function provides a measure of how many `BasePart`s are being
---influenced by, or recently under the influence of, physical forces.
---
---```
---print(workspace:GetNumAwakeParts()) -- prints the number of 'awake' parts
---```
---
---#### Sleeping vs Awake Parts
---
---In order to ensure good performance, Roblox sets `BaseParts` in which
---physics are not being applied to a 'sleeping' state. `BasePart`s with
---`BasePart/Anchored` set to true, for example, will always be sleeping as
---physics does not apply to them. When a force is applied to an non anchored
---`BasePart`, an 'awake' state will be applied. Whilst a `BasePart` is awake
---the Roblox physics engine will perform continuous calculations to ensure
---physical forces interact correctly with the part. Once the `BasePart` is
---no longer subject to physical forces, it will revert to a 'sleeping'
---state.
---
Workspace.GetNumAwakeParts = function(self) end;
---@return int
---Returns an integer, between 0 and 100, representing the percentage of
---real-time that physics simulation is currently being throttled to.
---
---This function can be used to determine whether, and to what degree,
---physics throttling is occurring.
---
---#### What is physics throttling?
---
---Physics throttling occurs when the physics engine detects it cannot keep
---up with the game in realtime. When physics is being throttled, it will
---update less frequently causing `BasePart`s to appear to move slower.
---
---Without throttling, the physics simulation would fall further behind out
---of sync with the game. This can lead to lower frame rates and other
---undesirable behavior.
---
---Objects associated with `Humanoid`s are exempt from physics throttling.
---
---See also `Workspace/SetPhysicsThrottleEnabled`.
---
---#### Demonstrating physics throttling
---
---Developers should always avoid creating places that overload the physics
---engine, as it leads to sub-par experience for players. Those wishing to
---simulate physics throttling for research purposes however, need only
---create a lot of `Part`s very quickly.
---
---```
---local i = 0
---while true do
---	i = i + 1
---	if i % 5 == 0 then
---		wait()
---	end
---	local part = Instance.new("Part", workspace)
---end
---```
---
Workspace.GetPhysicsThrottling = function(self) end;
---@param value bool
---@return void
---This property determines whether physics throttling is enabled.
---
---Historically this function could be used by plugins. However, for security
---reasons this has been changed and now it can only be used by developers in
---the command bar.
---
---Note, currently physics throttling will always stay enabled regardless if
---this function is used or not.
---
---#### What is physics throttling?
---
---Physics throttling occurs when the physics engine detects it cannot keep
---up with the game in realtime. When physics is being throttled, it will
---update less frequently causing `BasePart|BaseParts` to appear to move
---slower.
---
---Without throttling, the physics simulation would fall further behind out
---of sync with the game. Without physics throttling, users experience lower
---frame rates.
---
---Objects associated with `Humanoid|Humanoids` are exempt from physics
---throttling.
---
---Developers can use `Workspace/GetPhysicsThrottling` to determine the
---degree to which physics are being throttled.
---
---#### Demonstrating physics throttling
---
---Developers should always avoid creating places that overload the physics
---engine, as it leads to sub-par experience for players. Those wishing to
---simulate physics throttling for research purposes however, need only
---create a lot of `Part`s very quickly.
---
---```
---local i = 0
---while true do
---	i = i + 1
---	if i % 5 == 0 then
---		wait()
---	end
---	local part = Instance.new("Part", workspace)
---end
---```
---
Workspace.SetPhysicsThrottleEnabled = function(self, value) end;
---@param gravity float
---@param jumpPower float
---@return float
Workspace.CalculateJumpHeight = function(self, gravity, jumpPower) end;
---@param gravity float
---@param jumpPower float
---@param walkSpeed float
---@return float
Workspace.CalculateJumpDistance = function(self, gravity, jumpPower, walkSpeed) end;
---@param gravity float
---@param jumpHeight float
---@return float
Workspace.CalculateJumpPower = function(self, gravity, jumpHeight) end;
---@return bool
---Returns true if the game has the PGS Physics solver enabled.
---
---The PGS Physics solver was previously called the 'Experimental' solver,
---before becoming Roblox's default server. This function returns the same
---result as `Workspace:PGSIsEnabled`.
---
---```
---print(workspace:PGSIsEnabled() == workspace:ExperimentalSolverIsEnabled()) -- true
---```
---
---This function can only be used by plugins and the command bar.
---
---#### What is the PGS Solver?
---
---The PGS Solver is Roblox's state of the art physics solver which offers a
---range of simulation capabilities not available in Roblox's legacy solver.
---
---Note, the PGS solver is currently the default physics solver used by
---Roblox. Developers should expect the legacy physics solver to be
---deprecated or removed at some point in the future.
---
---For more information on the PGS Solver, please see [this article][1].
---
---[1]: https://developer.roblox.com/articles/Building-with-PGS
---
Workspace.ExperimentalSolverIsEnabled = function(self) end;
---@return double
---Returns the number of frames per second that physics is currently being
---simulated at.
---
---#### Using GetRealPhysicsFPS to combat exploiters
---
---A common use of this function is to detect if exploiters are increasing
---their local physics frame rate to move faster. This is generally done by
---comparing the result returned by a client's GetRealPhysicsFPS to a maximum
---that will not be breached in normal circumstances (usually 65 or 70). If
---this limit is breached, developers can use the `Player/Kick` function to
---remove that `Player` from the game. It is important to remember that,
---although this practice may be effective sometimes, client-side
---anti-exploiter measures are never 100% reliable.
---
Workspace.GetRealPhysicsFPS = function(self) end;
---@return bool
---Returns true if the game has the PGS Physics solver enabled.
---
---As `Workspace/PGSPhysicsSolverEnabled` cannot be accessed by scripts, the
---PGSIsEnabled function allows developers to tell which physics solver the
---game is using.
---
---```
---print(workspace:PGSIsEnabled()) -- true = PGS solver enabled
---print(workspace:PGSIsEnabled()) -- false = Legacy solver enabled
---```
---
---#### What is the PGS Solver?
---
---The PGS Solver is Roblox's state of the art physics solver which offers a
---range of simulation capabilities not available in Roblox's legacy solver.
---
---Note, the PGS solver is currently the default physics solver used by
---Roblox. Developers should expect the legacy physics solver to be
---deprecated or removed at some point in the future.
---
---For more information on the PGS Solver, please see [this article][1].
---
---[1]: https://developer.roblox.com/articles/Building-with-PGS
---
Workspace.PGSIsEnabled = function(self) end;
---@class WorldModel : WorldRoot, Model, PVInstance, Instance
---The WorldModel provides some physics features to a `ViewportFrame`.
---
---More specifically, you can make a WorldModel a child of a ViewportFrame, and
---then parent geometry to the WorldModel. This will then allow you to use
---raycasts in the ViewportFrame through the WorldModel. Furthermore you can put
---`Humanoid` characters in the WorldModel and their joints will be set-up
---correctly, and you can animate them.
---
local WorldModel;
---@class WorldRoot : Model, PVInstance, Instance
local WorldRoot;
---@param position Vector3
---@param radius float
---@param overlapParams OverlapParams
---@return Objects
---**GetPartBoundsInRadius** returns an array of parts whose _bounding boxes_
---overlap a sphere whose volume is described using the given center
---(Vector3) and radius (number).
---
---Beware that this spatial query function efficiently considers the volume
---of parts' bounding boxes rather than their actual occupied volume. This
---may be important when considering cylinders, spheres, unions, and
---`MeshPart`, which have non-block shapes. For cases where accuracy
---particularly matters, use `WorldRoot/GetPartsInPart|GetPartsInPart`
---instead or further filter the results of this function yourself.
---
---This function uses an `datatype/OverlapParams` object to describe reusable
---portions of the spatial query, such as an instance whitelist/blacklist,
---the maximum number of parts to query, and what
---[collision group](/building-and-visuals/physics/collision-filtering) to
---use. When making repeated spatial queries using functions like this, you
---should construct just one of these objects and reuse it.
---
---This and other spatial query functions do not consider parts'
---`BasePart/CanCollide|CanCollide` or `BasePart/CanTouch|CanTouch`
---properties. However, it will consider parts' collision group if specified
---by the given OverlapParams.
---
WorldRoot.GetPartBoundsInRadius = function(self, position, radius, overlapParams) end;
---@param region Region3
---@param ignoreDescendentsTable Objects
---@return bool
---**IsRegion3EmptyWithIgnoreList** returns a bool indicating whether there
---are no `BasePart`s within in the given `DataType/Region3`, ignoring any
---`BasePart`s that are descendants of the objects within the given ignore
---list.
---
---For example, the following code snippet will check to see if the Region is
---empty, ignoring the descendants of a `Model` named 'Scenery'.
---
---```
---local region3 = Region3.new(Vector3.new(0, 0, 0), Vector3.new(10, 10, 10))
---local scenery = workspace:FindFirstChild("Scenery")
---local ignoreList = {scenery}
---local isEmpty = workspace:IsRegion3EmptyWithIgnoreList(region3, ignoreList)
---```
---
---This function only returns if a region is empty or not. Developers looking
---to find `BasePart`s in a region should use
---`Workspace/FindPartsInRegion3WithIgnoreList`.
---
---This function is a variant of `Workspace/IsRegion3Empty` with the addition
---of an ignore list. In cases where a white list is required instead,
---developers should check to see if any parts are returned by
---`Workspace/FindPartsinRegion3WithWhitelist`.
---
---#### How do Region3 checks work?
---
---Checking if a part overlaps a `DataType/Region3` is not a simple process.
---It actually is time consuming and complicated. Instead it checks if parts
---are roughly in the same area. When this function is called, it figures out
---which voxels contain the `DataType/Region3`. It then figures out which
---parts might be in those voxels. It does this by comparing the axis-aligned
---bounding box (sometimes called the AABB) of the part with the voxels. The
---axis-aligned bounding box can be seen in Roblox Studio when a part is
---selected.
---
---This means that the area that is inspected by the function may be larger
---than the `DataType/Region3`. For this reason it is recommended to make
---sure that the `DataType/Region3` is on the voxel grid. The best way to do
---this is by setting the coordinates of the `DataType/Region3` to multiples
---of 4 (since voxels are 4 x 4 x 4 studs).
---
---This method is a fairly quick and easy way to see if any parts are in a
---general area. If a game needs to know if parts are exactly in an area,
---then `BasePart/GetTouchingParts` should be used. There is a higher cost to
---using `BasePart/GetTouchingParts` since a part is needed in the
---`Workspace` and the function takes more time to run.
---
---Note:
---
---- If a nil value is given in the ignore list, instances after this value
---  will not be ignored
---
WorldRoot.IsRegion3EmptyWithIgnoreList = function(self, region, ignoreDescendentsTable) end;
---@param region Region3
---@param ignoreDescendantsInstance Instance
---@param maxParts int
---@return Objects
---Returns an array of `BasePart`s in the given `DataType/Region3`.
---
---This function takes an optional maxParts parameter (default 20) which
---limits the number of `BasePart`s that can be returned. Once this number
---has been reached, the search for `BasePart`s will stop. This means some
---`BasePart`s may not be returned even if they are within the
---`DataType/Region3`
---
---The optional ignoreDescendentsInstance parameter can be used to specify a
---specific instance for whom itself and all of its descendants should be
---ignored by this function. This can be useful when, for example, looking to
---see if any `BasePart`s are inside a `BasePart` other than the `BasePart`
---itself.
---
---```
---local min = part.Position - (0.5 * part.Size)
---local max = part.Position + (0.5 * part.Size)
---local region = Region3.new(min, max)
---local parts = workspace:FindPartsInRegion3(region, part) --  ignore part
---```
---
---Variants of this function exist with ignore-list and white-list
---functionality, `Workspace/FindPartsInRegion3WithIgnoreList` and
---`Workspace/FindPartsInRegion3WithWhiteList`.
---
---If no `BasePart`s are found, an empty array will be returned.
---
---#### How do Region3 checks work?
---
---Checking if a part overlaps a `DataType/Region3` is not a simple process.
---It actually is time consuming and complicated. Instead it checks if parts
---are roughly in the same area. When this function is called, it figures out
---which voxels contain the `DataType/Region3`. It then figures out which
---parts might be in those voxels. It does this by comparing the axis-aligned
---bounding box (sometimes called the AABB) of the part with the voxels. The
---axis-aligned bounding box can be seen in Roblox Studio when a part is
---selected.
---
---This means that the area that is inspected by the function may be larger
---than the `DataType/Region3`. For this reason it is recommended to make
---sure that the `DataType/Region3` is on the voxel grid. The best way to do
---this is by setting the coordinates of the `DataType/Region3` to multiples
---of 4 (since voxels are 4 x 4 x 4 studs).
---
---This method is a fairly quick and easy way to see if parts are in a
---general area. If a game needs to know if parts are exactly in an area,
---then `BasePart/GetTouchingParts` should be used. There is a higher cost to
---using `BasePart/GetTouchingParts` since a part is needed in the
---`Workspace` and the function takes more time to run.
---
WorldRoot.FindPartsInRegion3 = function(self, region, ignoreDescendantsInstance, maxParts) end;
---@param ray Ray
---@param ignoreDescendantsInstance Instance
---@param terrainCellsAreCubes bool
---@param ignoreWater bool
---@return Tuple
---**FindPartOnRay** uses [raycasting][1] to find the first `BasePart` or
---`Terrain` cell intersecting with a given `DataType/Ray`. This function
---returns the `BasePart` or terrain cell hit, the point of intersection, the
---surface normal at the point of intersection, and the associated
---`Enum/Material` hit.
---
---```
---local character = game.Players.LocalPlayer.Character
----- Get the head
---local head = character:FindFirstChild("Head")
----- Build a ray in the direction the head is facing
---local origin = head.Position
---local lookDirection = head.CFrame.LookVector
---local ray = Ray.new(origin, lookDirection * 500)
----- Raycast, ignoring the player's character
---local hitPart, hitPosition = workspace:FindPartOnRay(ray, character)
---if hitPart then
---	print("Hit part: " .. hitPart:GetFullName())
---else
---	print("Did not hit part")
---end
---```
---
---If the `ignoreDescendantsInstance` parameter is provided, the raycasting
---calculation will ignore the given object and all of its descendants. It
---behaves similar to the `Mouse/TargetFilter` property.
---
---The `terrainCellsAreCubes` and `ignoreWater` parameters determine whether
---`Terrain` cells should be treated as cubes or not, and whether water
---should be ignored or not.
---
---In order to whitelist or ignore multiple objects and their descendants,
---use the `WorldRoot/FindPartOnRayWithWhitelist` and
---`WorldRoot/FindPartOnRayWithIgnoreList` variants.
---
---Note:
---
---- Theoretically, a ray extends infinitely in one direction. However, the
---  max length of the direction vector on Roblox is 5000 studs.
---- The length (magnitude) of the directional vector is important, as parts
---  further away than its length will not be tested.
---- If the ray does not intersect anything, the return values will be `nil`
---  and the point at the end of the ray, respectively.
---- Parts that are in a
---  [collision group](/building-and-visuals/physics/collision-filtering)
---  that does not collide with the "Default" collision group are ignored
---  implicitly.
---
---For a demonstration of how raycasting works in Roblox, see the [Intro to
---Raycasting][1] article.
---
---[1]: https://developer.roblox.com/articles/Raycasting
---
WorldRoot.FindPartOnRay = function(self, ray, ignoreDescendantsInstance, terrainCellsAreCubes, ignoreWater) end;
---@param origin Vector3
---@param direction Vector3
---@param raycastParams RaycastParams
---@return RaycastResult
---Casts a ray using an origin, direction, and optional
---`datatype/RaycastParams`. If it finds an eligible `BasePart` or `Terrain`
---cell, a `datatype/RaycastResult` is returned containing the results of the
---operation. If no `datatype/RaycastParams` object is provided, the defaults
---are used (all parts are considered and `Terrain` water is not ignored).
---
---Note that the length (magnitude) of the directional vector is important,
---as objects/terrain further away than its length will not be tested. If
---you're using a `datatype/CFrame` to help create the ray components,
---consider using `CFrame.LookVector` as the directional vector and multiply
---it by the desired length as shown in the example below. The maximum length
---of the direction vector is 5,000 studs.
---
---This method does **not** use a `datatype/Ray` object, but its origin and
---direction components can be borrowed from `Ray.Origin` and
---`Ray.Direction`.
---
WorldRoot.Raycast = function(self, origin, direction, raycastParams) end;
---@param region Region3
---@param ignoreDescendantsTable Objects
---@param maxParts int
---@return Objects
---Returns an array of `BasePart`s in the given `DataType/Region3` that
---aren't in, or a descendant of an entry in, the given IgnoreList.
---
---This function takes an optional maxParts parameter (default 20) which
---limits the number of `BasePart`s that can be returned. Once this number
---has been reached, the search for `BasePart`s will stop. This means some
---`BasePart`s may not be returned even if they are within the
---`DataType/Region3`
---
---If no `BasePart`s are found, an empty array will be returned.
---
---This function is a variant of `Workspace/FindPartsInRegion3` with the
---addition of an ignore list. This allows the developer to exclude certain
---`BasePart`s or `Model`s, for example characters, from the search. Those
---looking to find `BasePart`s in a Region3 using a white list, should use
---`Workspace/FindPartsInRegion3WithWhitelist`.
---
---#### How do Region3 checks work?
---
---Checking if a part overlaps a `DataType/Region3` is not a simple process.
---It actually is time consuming and complicated. Instead it checks if parts
---are roughly in the same area. When this function is called, it figures out
---which voxels contain the `DataType/Region3`. It then figures out which
---parts might be in those voxels. It does this by comparing the axis-aligned
---bounding box (sometimes called the AABB) of the part with the voxels. The
---axis-aligned bounding box can be seen in Roblox Studio when a part is
---selected.
---
---This means that the area that is inspected by the function may be larger
---than the `DataType/Region3`. For this reason it is recommended to make
---sure that the `DataType/Region3` is on the voxel grid. The best way to do
---this is by setting the coordinates of the `DataType/Region3` to multiples
---of 4 (since voxels are 4 x 4 x 4 studs).
---
---This method is a fairly quick and easy way to see if parts are in a
---general area. If a game needs to know if parts are exactly in an area,
---then `BasePart/GetTouchingParts` should be used. There is a higher cost to
---using `BasePart/GetTouchingParts` since a part is needed in the
---`Workspace` and the function takes more time to run.
---
---Note:
---
---- If a nil value is given in the ignore list, instances after this value
---  will not be ignored
---
WorldRoot.FindPartsInRegion3WithIgnoreList = function(self, region, ignoreDescendantsTable, maxParts) end;
---@param part BasePart
---@param target CFrame
---@param translateStiffness float
---@param rotateStiffness float
---@param collisionsMode IKCollisionsMode
---@return void
---This function moves the specified part to the specified location via
---[inverse kinematics](https://en.wikipedia.org/wiki/Inverse_kinematics)
---rather than moving it there directly, to ensure any joints,
---`Constraint|constraints`, or collisions that part is participating in
---remain physically satisfied. Currently this function is only available in
---Studio to `Plugin|plugins`, as it currently conflicts with the physics of
---a running game.
---
---**Translate stiffness** is a number between 0 and 1 specifying how
---agressively to match the part's position to the position part of the
---target CFrame. **Rotate stiffness** is a number between 0 and 1 specifying
---how agresively to match the part's rotation to to the rotation part of the
---target CFrame.
---
---For example:
---
---- If translate stiffness and rotate stiffness are both equal to 1, then
---  the part will be moved exactly to the target CFrame regardless of what
---  physical constraints there are on it.
---- If translate stiffness and rotate stiffness are both equal to 0.5, then
---  the part will try to move to exactly the target CFrame, but may be
---  pushed out of the way by physical constraints on it.
---- If translate stiffness and rotate stiffness are both equal to 0, then
---  the target CFrame will be ignored and physical constraints will be
---  solved for the object at the position where it was.
---
WorldRoot.IKMoveTo = function(self, part, target, translateStiffness, rotateStiffness, collisionsMode) end;
---@param region Region3
---@param whitelistDescendantsTable Objects
---@param maxParts int
---@return Objects
---Returns an array of `BasePart`s in the given `DataType/Region3` that are
---in, or descendant of an object in, a given white list.
---
---This function takes an optional maxParts parameter (default 20) which
---limits the number of `BasePart`s that can be returned. Once this number
---has been reached, the search for `BasePart`s will stop. This means some
---`BasePart`s may not be returned even if they are within the
---`DataType/Region3`
---
---If no `BasePart`s are found, an empty array will be returned.
---
---This function is a variant of `Workspace/FindPartsInRegion3` with the
---addition of a white list. Those looking to find `BasePart`s in a Region3
---using an ignore list, should use
---`Workspace/FindPartsInRegion3WithIgnoreList`.
---
---#### How do Region3 checks work?
---
---Checking if a part overlaps a `DataType/Region3` is not a simple process.
---It actually is time consuming and complicated. Instead it checks if parts
---are roughly in the same area. When this function is called, it figures out
---which voxels contain the `DataType/Region3`. It then figures out which
---parts might be in those voxels. It does this by comparing the axis-aligned
---bounding box (sometimes called the AABB) of the part with the voxels. The
---axis-aligned bounding box can be seen in Roblox Studio when a part is
---selected.
---
---This means that the area that is inspected by the function may be larger
---than the `DataType/Region3`. For this reason it is recommended to make
---sure that the `DataType/Region3` is on the voxel grid. The best way to do
---this is by setting the coordinates of the `DataType/Region3` to multiples
---of 4 (since voxels are 4 x 4 x 4 studs).
---
---This method is a fairly quick and easy way to see if parts are in a
---general area. If a game needs to know if parts are exactly in an area,
---then `BasePart/GetTouchingParts` should be used. There is a higher cost to
---using `BasePart/GetTouchingParts` since a part is needed in the
---`Workspace` and the function takes more time to run.
---
---Note:
---
---- If a nil value is given in the white list, instances after this value
---  will be disregarded
---
WorldRoot.FindPartsInRegion3WithWhiteList = function(self, region, whitelistDescendantsTable, maxParts) end;
---@param partList Objects
---@param overlapIgnored float
---@return bool
---**ArePartsTouchingOthers** returns true if at least one of the given
---`BasePart` are touching any other parts. Two parts are considered
---"touching" if they are within the distance threshold, `overlapIgnored`.
---
---If no parts are provided, false is returned.
---
WorldRoot.ArePartsTouchingOthers = function(self, partList, overlapIgnored) end;
---@param point Vector3
---@param ignoreGrid bool
---@return void
WorldRoot.SetInsertPoint = function(self, point, ignoreGrid) end;
---@param cframe CFrame
---@param size Vector3
---@param overlapParams OverlapParams
---@return Objects
---**GetPartBoundsInBox** returns an array of parts whose _bounding boxes_
---overlap a box whose volume is described using the given center (CFrame)
---and size (Vector3).
---
---Beware that this spatial query function efficiently considers the volume
---of parts' bounding boxes rather than their actual occupied volume. This
---may be important when considering cylinders, spheres, unions, and
---`MeshPart`, which have non-block shapes. For cases where accuracy
---particularly matters, use `WorldRoot/GetPartsInPart|GetPartsInPart`
---instead or further filter the results of this function yourself.
---
---This function uses an `datatype/OverlapParams` object to describe reusable
---portions of the spatial query, such as an instance whitelist/blacklist,
---the maximum number of parts to query, and what
---[collision group](/building-and-visuals/physics/collision-filtering) to
---use. When making repeated spatial queries using functions like this, you
---should construct just one of these objects and reuse it.
---
---This and other spatial query functions do not consider parts'
---`BasePart/CanCollide|CanCollide` or `BasePart/CanTouch|CanTouch`
---properties. However, it will consider parts' collision group if specified
---by the given OverlapParams.
---
WorldRoot.GetPartBoundsInBox = function(self, cframe, size, overlapParams) end;
---@param region Region3
---@param ignoreDescendantsInstance Instance
---@param maxParts int
---@return Objects
WorldRoot.findPartsInRegion3 = function(self, region, ignoreDescendantsInstance, maxParts) end;
---@param region Region3
---@param ignoreDescendentsInstance Instance
---@return bool
---**IsRegion3Empty** returns a bool indicating whether there are no
---`BasePart`s within the given `DataType/Region3`.
---
---The optional ignoreDescendentsInstance parameter can be used to specify a
---specific instance for whom itself and all of its descendants should be
---ignored by this function. This can be useful when, for example, looking to
---see if any `BasePart`s are inside a `BasePart` other than the `BasePart`
---itself.
---
---```
---local min = part.Position - (0.5 * part.Size)
---local max = part.Position + (0.5 * part.Size)
---local region = Region3.new(min, max)
---local isPartEmpty = workspace:IsRegion3Empty(region, part) --  ignore part
---```
---
---If more than one object and its descendants need to be excluded from the
---search, developers should use `Workspace/IsRegion3EmptyWithIgnoreList`.
---
---This function only returns if a region is empty or not. Developers looking
---to find `BasePart`s in a region should use `Workspace/FindPartsInRegion3`.
---
---#### How do Region3 checks work?
---
---Checking if a part overlaps a `DataType/Region3` is not a simple process.
---It actually is time consuming and complicated. Instead it checks if parts
---are roughly in the same area. When this function is called, it figures out
---which voxels contain the `DataType/Region3`. It then figures out which
---parts might be in those voxels. It does this by comparing the axis-aligned
---bounding box (sometimes called the AABB) of the part with the voxels. The
---axis-aligned bounding box can be seen in Roblox Studio when a part is
---selected.
---
---This means that the area that is inspected by the function may be larger
---than the `DataType/Region3`. For this reason it is recommended to make
---sure that the `DataType/Region3` is on the voxel grid. The best way to do
---this is by setting the coordinates of the `DataType/Region3` to multiples
---of 4 (since voxels are 4 x 4 x 4 studs).
---
---This method is a fairly quick and easy way to see if any parts are in a
---general area. If a game needs to know if parts are exactly in an area,
---then `BasePart/GetTouchingParts` should be used. There is a higher cost to
---using `BasePart/GetTouchingParts` since a part is needed in the
---`Workspace` and the function takes more time to run.
---
WorldRoot.IsRegion3Empty = function(self, region, ignoreDescendentsInstance) end;
---@param ray Ray
---@param whitelistDescendantsTable Objects
---@param ignoreWater bool
---@return Tuple
---This function is a variant of `WorldRoot/FindPartOnRay` with the addition
---of a whitelist. This lets you detect only certain parts or `Model|Models`
---and is particularly useful when, for example, looking for points of
---intersection between a ray and a single part.
---
---```lua
---local function getIntersection(part, ray)
---	local whiteList = {part}
---	local _, position, normal = workspace:FindPartOnRayWithWhitelist(ray, whiteList)
---	return position, normal
---end
---```
---
---Those looking to utilize an ignore list instead should use
---`WorldRoot/FindPartOnRayWithIgnoreList`.
---
---Note:
---
---- If a `nil` value is given in the whitelist, instances after it will be
---  disregarded.
---- Theoretically, a ray extends infinitely in one direction. However, the
---  max length of the direction vector on Roblox is 5000 studs.
---- The length (magnitude) of the directional vector is important, as parts
---  further away than its length will not be tested.
---- If the ray does not intersect anything, the return values will be `nil`
---  and the point at the end of the ray, respectively.
---- Parts that are in a
---  [collision group](/building-and-visuals/physics/collision-filtering)
---  that does not collide with the "Default" collision group are ignored
---  implicitly.
---
WorldRoot.FindPartOnRayWithWhitelist = function(self, ray, whitelistDescendantsTable, ignoreWater) end;
---@param partList Objects
---@param cframeList Array
---@param eventMode BulkMoveMode
---@return void
---**Warning:** You should only use this function if you are sure that part
---movement is a bottleneck in your code, simply setting the CFrame property
---of the individual parts / welded models you want to move will be fast
---enough in the vast majority of cases.
---
---This function moves a table of parts to the location specified in a table
---of `DataType/CFrame|CFrames`. This makes it a very fast way to move large
---numbers of parts, as you don't have to pay the cost of separate property
---sets for each individual part.
---
---The third argument of BulkMoveTo allows you to further speed up movement
---of the parts by specifying the `BasePart/Position|Position` and
---`BasePart/Orientation|Orientation`. Changed events should not be fired on
---the parts. If you specify FireCFrameChanged as the BulkMoveMode then only
---CFrame .Changed will be fired, rather than changed firing for Position,
---Orientation, and CFrame like it normally does.
---
WorldRoot.BulkMoveTo = function(self, partList, cframeList, eventMode) end;
---@param ray Ray
---@param ignoreDescendantsInstance Instance
---@param terrainCellsAreCubes bool
---@param ignoreWater bool
---@return Tuple
WorldRoot.findPartOnRay = function(self, ray, ignoreDescendantsInstance, terrainCellsAreCubes, ignoreWater) end;
---@param part BasePart
---@param overlapParams OverlapParams
---@return Objects
---**GetPartsInPart** returns an array of parts whose occupied space is
---shared with the given part, which must exist in the same WorldRoot
---(`Workspace`) as the parts to be queried.
---
---Queried parts that are merely touching the given part are considered
---occupying the same space. This function can be used in place of
---`BasePart/GetTouchingParts`, and is generally a better choice in most
---cases.
---
---Beware that this spatial query function considers the exact volume
---occupied by the given part using a full geometric collision check. A
---concave/hollow part won't match queried parts within it unless they
---actually overlap/touch such a part. For simpler volumes, consider using
---`WorldRoot/GetPartBoundsInBox|GetPartBoundsInBox` or
---`WorldRoot/GetPartBoundsInRadius|GetPartBoundsInRadius` instead, as they
---are faster at the cost of being less accurate.
---
---This function uses an `datatype/OverlapParams` object to describe reusable
---portions of the spatial query, such as an instance whitelist/blacklist,
---the maximum number of parts to query, and what
---[collision group](/building-and-visuals/physics/collision-filtering) to
---use. When making repeated spatial queries using functions like this, you
---should construct just one of these objects and reuse it.
---
---This and other spatial query functions do not consider parts'
---`BasePart/CanCollide|CanCollide` or `BasePart/CanTouch|CanTouch`
---properties. However, it will consider parts' collision group if specified
---by the given OverlapParams.
---
WorldRoot.GetPartsInPart = function(self, part, overlapParams) end;
---@param ray Ray
---@param ignoreDescendantsTable Objects
---@param terrainCellsAreCubes bool
---@param ignoreWater bool
---@return Tuple
---This function is a variant of `WorldRoot/FindPartOnRay` with the addition
---of an ignore list. This lets you ignore certain parts or `Model|Models`.
---
---Those looking to utilize a whitelist instead should use
---`WorldRoot/FindPartOnRayWithWhitelist`.
---
---Note:
---
---- Theoretically, a ray extends infinitely in one direction. However, the
---  max length of the direction vector on Roblox is 5000 studs.
---- The length (magnitude) of the directional vector is important, as parts
---  further away than its length will not be tested.
---- If the ray does not intersect anything, the return values will be `nil`
---  and the point at the end of the ray, respectively.
---- Parts that are in a
---  [collision group](/building-and-visuals/physics/collision-filtering)
---  that does not collide with the "Default" collision group are ignored
---  implicitly.
---
WorldRoot.FindPartOnRayWithIgnoreList = function(self, ray, ignoreDescendantsTable, terrainCellsAreCubes, ignoreWater) end;
---@class WrapLayer : BaseWrap, Instance
---@field public AutoSkin WrapLayerAutoSkin
---@field public BindOffset CFrame
---@field public Color Color3
---@field public DebugMode WrapLayerDebugMode
---@field public Enabled bool
---@field public Order int
---@field public Puffiness float
---@field public ReferenceMeshId Content
---@field public ReferenceOrigin CFrame
---@field public ReferenceOriginWorld CFrame
---@field public ShrinkFactor float
---The WrapLayer object defines a 3D accessory's inner and outer surfaces and
---other properties related to layering accessories. These surfaces, or the Inner
---Cage and Outer Cage, are similar to collision boxes, and describe the surfaces
---of which other 3D accessories can be placed without clipping or breaking.
---
---Internally, WrapLayer also uses the UV layout of the Inner and Outer cages to
---match coordinates to another 3D object's cage. This powers the deformation of
---objects around differently shaped avatars and underlying accessories.
---
local WrapLayer;
---
WrapLayer.AutoSkin = nil;
---This property is intended for fine-tuning purposes and is highly optional.
---
---`datatype/CFrame` to adjust a binding point for a clothing item mesh.
---Allows for fine-tuning of clothing items (slight adjustment of
---position/rotation to get a unique look) in contexts such as community-made
---avatar editors.
---
WrapLayer.BindOffset = nil;
---Sets color used for the debug rendering. See `WrapTarget.DebugMode`
---
WrapLayer.Color = nil;
---Allows switching between different debugging visualization modes for cage
---meshes.
---
WrapLayer.DebugMode = nil;
---Allows for disabling of the `WrapLayer` object as if it does not exist.
---
WrapLayer.Enabled = nil;
---Controls the composition order for layered clothing. Clothing items with
---higher order will appear on top of clothing items with lower order. If two
---items have the same order, the deformer composition order is ambiguous and
---depends on serialization order. Default value is 1.
---
WrapLayer.Order = nil;
---Controls how much underlying clothing items inflate the current clothing
---item.
---
---Valid range is 0 to 1. A value of 0 makes the clothing item always fit the
---body regardless of how many clothing layers are under it (all underlying
---clothing layers will be compressed). A value of 1 (default) never
---compresses anything and infinitely inflates over underlying clothing
---items.
---
WrapLayer.Puffiness = nil;
---AssetID for reference mesh used to define Inner Cage of a 3D object
---
---Reference mesh is used to define standard topology and UV coordinates for
---index matching. It is expected that for all catalog avatars, this will
---point to one of 15 standard reference meshes provided by Roblox. But for
---some NPCs or a custom avatar system, this might point to other meshes.
---
---Note: this property is set up automatically by the FBX importer
---
WrapLayer.ReferenceMeshId = nil;
---Reference mesh offset relative to parent MeshPart (in the parent MeshPart
---space)
---
---Note: this property is set up automatically by the FBX importer
---
WrapLayer.ReferenceOrigin = nil;
---Reference mesh offset relative to parent MeshPart (in the world space)
---
---Note: this property is set up automatically by the FBX importer
---
WrapLayer.ReferenceOriginWorld = nil;
---This property is intended for fine-tuning purposes and is highly optional.
---
---Allows slight shrinking/expanding of the resulting render mesh, without
---affecting any other layers. This is useful in rare cases when the clothing
---mesh does not precisely fit the underlying clothing layers (the cage is
---usually slightly overestimated atop the real shape to avoid layer
---interpenetration). Even slight overestimation has the tendency to
---accumulate, especially when there are a lot of layers. While this is
---usually not critical, some items like backpacks may be problematic.
---
---Valid range is -1 to 1. A value of -1 will maximally expand while a value
---of 1 will maximally shrink. A value of 0 (default) has no effect.
---
WrapLayer.ShrinkFactor = nil;
---@class WrapTarget : BaseWrap, Instance
---@field public Color Color3
---@field public DebugMode WrapTargetDebugMode
---@field public Stiffness float
---The WrapTarget object defines a target. A target is the 3D body with only an
---outer surface, or an Outer Cage.
---
---This target, often an Avatar, is what 3D accessories (using WrapLayer) will be
---applied to, allowing multiple accessories items to naturally layer over the
---source target.
---
local WrapTarget;
---Sets color used for the debug rendering. See `WrapTarget.DebugMode`
---
WrapTarget.Color = nil;
---Allows switching between different debugging visualization modes for cage
---meshes.
---
WrapTarget.DebugMode = nil;
---Defines how much the body mesh can be compressed by clothing. Super tight
---clothing may lead to an intersection between the clothing mesh and body
---mesh. To solve this visual artifact, the deformer can compress the body
---mesh slightly to solve possible intersections.
---
---Valid range is 0 to 1. A value of 0 will compress the body mesh as much as
---necessary to ensure that the intersections are eliminated (visible body
---parts might look a little bit deformed). A value of 1 will prevent the
---body mesh from being compressed (may lead to visible intersections or
---Z-fighting). A value of 0.9 (default) is a reasonable default that solves
---most of the intersections without introducing any significant body
---deformation.
---
WrapTarget.Stiffness = nil;
---@class Axes
---@field public X bool
---@field public Y bool
---@field public Z bool
---@field public Top bool
---@field public Bottom bool
---@field public Left bool
---@field public Right bool
---@field public Back bool
---@field public Front bool
---The `Axes` datatype is for the `ArcHandles` class to control which rotation
---axes are currently enabled.
---
Axes = nil;
---Whether the X axis is enabled.
---
Axes.X = nil;
---Whether the Y axis is enabled.
---
Axes.Y = nil;
---Whether the Z axis is enabled.
---
Axes.Z = nil;
---Whether the top face is included.
---
Axes.Top = nil;
---Whether the bottom face is included.
---
Axes.Bottom = nil;
---Whether the left face is included.
---
Axes.Left = nil;
---Whether the right face is included.
---
Axes.Right = nil;
---Whether the back face is included.
---
Axes.Back = nil;
---Whether the front face is included.
---
Axes.Front = nil;
---@param axes Tuple
---Creates a new Axes using list of axes and/or faces. NormalIds (faces) are
---converted to the corresponding axes.
---@return Axes
Axes.new = function(axes) end;
---@class BrickColor
---@field public Number number
---@field public r number
---@field public g number
---@field public b number
---@field public Name string
---@field public Color Color3
---The `BrickColor` data type provides a predefined list of named colors, not to
---be confused with `Color3`, a more general data type that describes RGB colors.
---The following code shows how to use `BrickColor.new()` to declare the
---`BrickColor` property of a `Part`.
---
---```lua
----- By color name
---workspace.Part.BrickColor = BrickColor.new("Pastel Blue")
----- By numerical index
---workspace.Part.BrickColor = BrickColor.new(11)
----- By RGB values
---workspace.Part.BrickColor = BrickColor.new(128, 187, 219)
---```
---
---The following table is the list of available brick colors.
---
---<table>
---<thead>
---<tr>
---  <th scope="col">Color</th>
---  <th width="150">Name</th>
---  <th width="100">Number</th>
---  <th scope="col">RGB Value</th>
---</tr>
---</thead>
---<tbody>
---<tr>
---  <td style={{backgroundColor: "#F2F3F3"}}></td>
---  <td>White</td>
---  <td>1</td>
---  <td>[242, 243, 243]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#A1A5A2"}}></td>
---  <td>Grey</td>
---  <td>2</td>
---  <td>[161, 165, 162]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#F9E999"}}></td>
---  <td>Light yellow</td>
---  <td>3</td>
---  <td>[249, 233, 153]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#D7C59A"}}></td>
---  <td>Brick yellow</td>
---  <td>5</td>
---  <td>[215, 197, 154]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#C2DAB8"}}></td>
---  <td>Light green (Mint)</td>
---  <td>6</td>
---  <td>[194, 218, 184]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E8BAC8"}}></td>
---  <td>Light reddish violet</td>
---  <td>9</td>
---  <td>[232, 186, 200]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#80BBDB"}}></td>
---  <td>Pastel Blue</td>
---  <td>11</td>
---  <td>[128, 187, 219]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#CB8442"}}></td>
---  <td>Light orange brown</td>
---  <td>12</td>
---  <td>[203, 132, 66]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#CC8E69"}}></td>
---  <td>Nougat</td>
---  <td>18</td>
---  <td>[204, 142, 105]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#C4281C"}}></td>
---  <td>Bright red</td>
---  <td>21</td>
---  <td>[196, 40, 28]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#C470A0"}}></td>
---  <td>Med. reddish violet</td>
---  <td>22</td>
---  <td>[196, 112, 160]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#0D69AC"}}></td>
---  <td>Bright blue</td>
---  <td>23</td>
---  <td>[13, 105, 172]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#F5CD30"}}></td>
---  <td>Bright yellow</td>
---  <td>24</td>
---  <td>[245, 205, 48]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#624732"}}></td>
---  <td>Earth orange</td>
---  <td>25</td>
---  <td>[98, 71, 50]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#1B2A35"}}></td>
---  <td>Black</td>
---  <td>26</td>
---  <td>[27, 42, 53]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#6D6E6C"}}></td>
---  <td>Dark grey</td>
---  <td>27</td>
---  <td>[109, 110, 108]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#287F47"}}></td>
---  <td>Dark green</td>
---  <td>28</td>
---  <td>[40, 127, 71]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#A1C48C"}}></td>
---  <td>Medium green</td>
---  <td>29</td>
---  <td>[161, 196, 140]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#F3CF9B"}}></td>
---  <td>Lig. Yellowich orange</td>
---  <td>36</td>
---  <td>[243, 207, 155]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#4B974B"}}></td>
---  <td>Bright green</td>
---  <td>37</td>
---  <td>[75, 151, 75]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#A05F35"}}></td>
---  <td>Dark orange</td>
---  <td>38</td>
---  <td>[160, 95, 53]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#C1CADE"}}></td>
---  <td>Light bluish violet</td>
---  <td>39</td>
---  <td>[193, 202, 222]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#ECECEC"}}></td>
---  <td>Transparent</td>
---  <td>40</td>
---  <td>[236, 236, 236]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#CD544B"}}></td>
---  <td>Tr. Red</td>
---  <td>41</td>
---  <td>[205, 84, 75]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#C1DFF0"}}></td>
---  <td>Tr. Lg blue</td>
---  <td>42</td>
---  <td>[193, 223, 240]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#7BB6E8"}}></td>
---  <td>Tr. Blue</td>
---  <td>43</td>
---  <td>[123, 182, 232]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#F7F18D"}}></td>
---  <td>Tr. Yellow</td>
---  <td>44</td>
---  <td>[247, 241, 141]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#B4D2E4"}}></td>
---  <td>Light blue</td>
---  <td>45</td>
---  <td>[180, 210, 228]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#D9856C"}}></td>
---  <td>Tr. Flu. Reddish orange</td>
---  <td>47</td>
---  <td>[217, 133, 108]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#84B68D"}}></td>
---  <td>Tr. Green</td>
---  <td>48</td>
---  <td>[132, 182, 141]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#F8F184"}}></td>
---  <td>Tr. Flu. Green</td>
---  <td>49</td>
---  <td>[248, 241, 132]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#ECE8DE"}}></td>
---  <td>Phosph. White</td>
---  <td>50</td>
---  <td>[236, 232, 222]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#EEC4B6"}}></td>
---  <td>Light red</td>
---  <td>100</td>
---  <td>[238, 196, 182]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#DA867A"}}></td>
---  <td>Medium red</td>
---  <td>101</td>
---  <td>[218, 134, 122]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#6E99CA"}}></td>
---  <td>Medium blue</td>
---  <td>102</td>
---  <td>[110, 153, 202]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#C7C1B7"}}></td>
---  <td>Light grey</td>
---  <td>103</td>
---  <td>[199, 193, 183]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#6B327C"}}></td>
---  <td>Bright violet</td>
---  <td>104</td>
---  <td>[107, 50, 124]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E29B40"}}></td>
---  <td>Br. yellowish orange</td>
---  <td>105</td>
---  <td>[226, 155, 64]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#DA8541"}}></td>
---  <td>Bright orange</td>
---  <td>106</td>
---  <td>[218, 133, 65]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#008F9C"}}></td>
---  <td>Bright bluish green</td>
---  <td>107</td>
---  <td>[0, 143, 156]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#685C43"}}></td>
---  <td>Earth yellow</td>
---  <td>108</td>
---  <td>[104, 92, 67]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#435493"}}></td>
---  <td>Bright bluish violet</td>
---  <td>110</td>
---  <td>[67, 84, 147]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#BFB7B1"}}></td>
---  <td>Tr. Brown</td>
---  <td>111</td>
---  <td>[191, 183, 177]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#6874AC"}}></td>
---  <td>Medium bluish violet</td>
---  <td>112</td>
---  <td>[104, 116, 172]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E5ADC8"}}></td>
---  <td>Tr. Medi. reddish violet</td>
---  <td>113</td>
---  <td>[229, 173, 200]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#C7D23C"}}></td>
---  <td>Med. yellowish green</td>
---  <td>115</td>
---  <td>[199, 210, 60]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#55A5AF"}}></td>
---  <td>Med. bluish green</td>
---  <td>116</td>
---  <td>[85, 165, 175]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#B7D7D5"}}></td>
---  <td>Light bluish green</td>
---  <td>118</td>
---  <td>[183, 215, 213]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#A4BD47"}}></td>
---  <td>Br. yellowish green</td>
---  <td>119</td>
---  <td>[164, 189, 71]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#D9E4A7"}}></td>
---  <td>Lig. yellowish green</td>
---  <td>120</td>
---  <td>[217, 228, 167]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E7AC58"}}></td>
---  <td>Med. yellowish orange</td>
---  <td>121</td>
---  <td>[231, 172, 88]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#D36F4C"}}></td>
---  <td>Br. reddish orange</td>
---  <td>123</td>
---  <td>[211, 111, 76]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#923978"}}></td>
---  <td>Bright reddish violet</td>
---  <td>124</td>
---  <td>[146, 57, 120]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#EAB892"}}></td>
---  <td>Light orange</td>
---  <td>125</td>
---  <td>[234, 184, 146]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#A5A5CB"}}></td>
---  <td>Tr. Bright bluish violet</td>
---  <td>126</td>
---  <td>[165, 165, 203]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#DCBC81"}}></td>
---  <td>Gold</td>
---  <td>127</td>
---  <td>[220, 188, 129]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#AE7A59"}}></td>
---  <td>Dark nougat</td>
---  <td>128</td>
---  <td>[174, 122, 89]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#9CA3A8"}}></td>
---  <td>Silver</td>
---  <td>131</td>
---  <td>[156, 163, 168]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#D5733D"}}></td>
---  <td>Neon orange</td>
---  <td>133</td>
---  <td>[213, 115, 61]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#D8DD56"}}></td>
---  <td>Neon green</td>
---  <td>134</td>
---  <td>[216, 221, 86]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#74869D"}}></td>
---  <td>Sand blue</td>
---  <td>135</td>
---  <td>[116, 134, 157]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#877C90"}}></td>
---  <td>Sand violet</td>
---  <td>136</td>
---  <td>[135, 124, 144]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E09864"}}></td>
---  <td>Medium orange</td>
---  <td>137</td>
---  <td>[224, 152, 100]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#958A73"}}></td>
---  <td>Sand yellow</td>
---  <td>138</td>
---  <td>[149, 138, 115]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#203A56"}}></td>
---  <td>Earth blue</td>
---  <td>140</td>
---  <td>[32, 58, 86]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#27462D"}}></td>
---  <td>Earth green</td>
---  <td>141</td>
---  <td>[39, 70, 45]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#CFE2F7"}}></td>
---  <td>Tr. Flu. Blue</td>
---  <td>143</td>
---  <td>[207, 226, 247]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#7988A1"}}></td>
---  <td>Sand blue metallic</td>
---  <td>145</td>
---  <td>[121, 136, 161]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#958EA3"}}></td>
---  <td>Sand violet metallic</td>
---  <td>146</td>
---  <td>[149, 142, 163]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#938767"}}></td>
---  <td>Sand yellow metallic</td>
---  <td>147</td>
---  <td>[147, 135, 103]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#575857"}}></td>
---  <td>Dark grey metallic</td>
---  <td>148</td>
---  <td>[87, 88, 87]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#161D32"}}></td>
---  <td>Black metallic</td>
---  <td>149</td>
---  <td>[22, 29, 50]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#ABADAC"}}></td>
---  <td>Light grey metallic</td>
---  <td>150</td>
---  <td>[171, 173, 172]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#789082"}}></td>
---  <td>Sand green</td>
---  <td>151</td>
---  <td>[120, 144, 130]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#957977"}}></td>
---  <td>Sand red</td>
---  <td>153</td>
---  <td>[149, 121, 119]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#7B2E2F"}}></td>
---  <td>Dark red</td>
---  <td>154</td>
---  <td>[123, 46, 47]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FFF67B"}}></td>
---  <td>Tr. Flu. Yellow</td>
---  <td>157</td>
---  <td>[255, 246, 123]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E1A4C2"}}></td>
---  <td>Tr. Flu. Red</td>
---  <td>158</td>
---  <td>[225, 164, 194]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#756C62"}}></td>
---  <td>Gun metallic</td>
---  <td>168</td>
---  <td>[117, 108, 98]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#97695B"}}></td>
---  <td>Red flip/flop</td>
---  <td>176</td>
---  <td>[151, 105, 91]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#B48455"}}></td>
---  <td>Yellow flip/flop</td>
---  <td>178</td>
---  <td>[180, 132, 85]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#898788"}}></td>
---  <td>Silver flip/flop</td>
---  <td>179</td>
---  <td>[137, 135, 136]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#D7A94B"}}></td>
---  <td>Curry</td>
---  <td>180</td>
---  <td>[215, 169, 75]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#F9D62E"}}></td>
---  <td>Fire Yellow</td>
---  <td>190</td>
---  <td>[249, 214, 46]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E8AB2D"}}></td>
---  <td>Flame yellowish orange</td>
---  <td>191</td>
---  <td>[232, 171, 45]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#694028"}}></td>
---  <td>Reddish brown</td>
---  <td>192</td>
---  <td>[105, 64, 40]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#CF6024"}}></td>
---  <td>Flame reddish orange</td>
---  <td>193</td>
---  <td>[207, 96, 36]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#A3A2A5"}}></td>
---  <td>Medium stone grey</td>
---  <td>194</td>
---  <td>[163, 162, 165]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#4667A4"}}></td>
---  <td>Royal blue</td>
---  <td>195</td>
---  <td>[70, 103, 164]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#23478B"}}></td>
---  <td>Dark Royal blue</td>
---  <td>196</td>
---  <td>[35, 71, 139]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#8E4285"}}></td>
---  <td>Bright reddish lilac</td>
---  <td>198</td>
---  <td>[142, 66, 133]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#635F62"}}></td>
---  <td>Dark stone grey</td>
---  <td>199</td>
---  <td>[99, 95, 98]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#828A5D"}}></td>
---  <td>Lemon metalic</td>
---  <td>200</td>
---  <td>[130, 138, 93]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E5E4DF"}}></td>
---  <td>Light stone grey</td>
---  <td>208</td>
---  <td>[229, 228, 223]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#B08E44"}}></td>
---  <td>Dark Curry</td>
---  <td>209</td>
---  <td>[176, 142, 68]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#709578"}}></td>
---  <td>Faded green</td>
---  <td>210</td>
---  <td>[112, 149, 120]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#79B5B5"}}></td>
---  <td>Turquoise</td>
---  <td>211</td>
---  <td>[121, 181, 181]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#9FC3E9"}}></td>
---  <td>Light Royal blue</td>
---  <td>212</td>
---  <td>[159, 195, 233]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#6C81B7"}}></td>
---  <td>Medium Royal blue</td>
---  <td>213</td>
---  <td>[108, 129, 183]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#904C2A"}}></td>
---  <td>Rust</td>
---  <td>216</td>
---  <td>[144, 76, 42]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#7C5C46"}}></td>
---  <td>Brown</td>
---  <td>217</td>
---  <td>[124, 92, 70]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#96709F"}}></td>
---  <td>Reddish lilac</td>
---  <td>218</td>
---  <td>[150, 112, 159]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#6B629B"}}></td>
---  <td>Lilac</td>
---  <td>219</td>
---  <td>[107, 98, 155]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#A7A9CE"}}></td>
---  <td>Light lilac</td>
---  <td>220</td>
---  <td>[167, 169, 206]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#CD6298"}}></td>
---  <td>Bright purple</td>
---  <td>221</td>
---  <td>[205, 98, 152]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E4ADC8"}}></td>
---  <td>Light purple</td>
---  <td>222</td>
---  <td>[228, 173, 200]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#DC9095"}}></td>
---  <td>Light pink</td>
---  <td>223</td>
---  <td>[220, 144, 149]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#F0D5A0"}}></td>
---  <td>Light brick yellow</td>
---  <td>224</td>
---  <td>[240, 213, 160]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#EBB87F"}}></td>
---  <td>Warm yellowish orange</td>
---  <td>225</td>
---  <td>[235, 184, 127]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FDEA8D"}}></td>
---  <td>Cool yellow</td>
---  <td>226</td>
---  <td>[253, 234, 141]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#7DBBDD"}}></td>
---  <td>Dove blue</td>
---  <td>232</td>
---  <td>[125, 187, 221]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#342B75"}}></td>
---  <td>Medium lilac</td>
---  <td>268</td>
---  <td>[52, 43, 117]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#506D54"}}></td>
---  <td>Slime green</td>
---  <td>301</td>
---  <td>[80, 109, 84]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#5B5D69"}}></td>
---  <td>Smoky grey</td>
---  <td>302</td>
---  <td>[91, 93, 105]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#0010B0"}}></td>
---  <td>Dark blue</td>
---  <td>303</td>
---  <td>[0, 16, 176]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#2C651D"}}></td>
---  <td>Parsley green</td>
---  <td>304</td>
---  <td>[44, 101, 29]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#527CAE"}}></td>
---  <td>Steel blue</td>
---  <td>305</td>
---  <td>[82, 124, 174]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#335882"}}></td>
---  <td>Storm blue</td>
---  <td>306</td>
---  <td>[51, 88, 130]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#102ADC"}}></td>
---  <td>Lapis</td>
---  <td>307</td>
---  <td>[16, 42, 220]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#3D1585"}}></td>
---  <td>Dark indigo</td>
---  <td>308</td>
---  <td>[61, 21, 133]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#348E40"}}></td>
---  <td>Sea green</td>
---  <td>309</td>
---  <td>[52, 142, 64]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#5B9A4C"}}></td>
---  <td>Shamrock</td>
---  <td>310</td>
---  <td>[91, 154, 76]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#9FA1AC"}}></td>
---  <td>Fossil</td>
---  <td>311</td>
---  <td>[159, 161, 172]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#592259"}}></td>
---  <td>Mulberry</td>
---  <td>312</td>
---  <td>[89, 34, 89]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#1F801D"}}></td>
---  <td>Forest green</td>
---  <td>313</td>
---  <td>[31, 128, 29]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#9FADC0"}}></td>
---  <td>Cadet blue</td>
---  <td>314</td>
---  <td>[159, 173, 192]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#0989CF"}}></td>
---  <td>Electric blue</td>
---  <td>315</td>
---  <td>[9, 137, 207]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#7B007B"}}></td>
---  <td>Eggplant</td>
---  <td>316</td>
---  <td>[123, 0, 123]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#7C9C6B"}}></td>
---  <td>Moss</td>
---  <td>317</td>
---  <td>[124, 156, 107]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#8AAB85"}}></td>
---  <td>Artichoke</td>
---  <td>318</td>
---  <td>[138, 171, 133]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#B9C4B1"}}></td>
---  <td>Sage green</td>
---  <td>319</td>
---  <td>[185, 196, 177]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#CACBD1"}}></td>
---  <td>Ghost grey</td>
---  <td>320</td>
---  <td>[202, 203, 209]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#A75E9B"}}></td>
---  <td>Lilac</td>
---  <td>321</td>
---  <td>[167, 94, 155]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#7B2F7B"}}></td>
---  <td>Plum</td>
---  <td>322</td>
---  <td>[123, 47, 123]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#94BE81"}}></td>
---  <td>Olivine</td>
---  <td>323</td>
---  <td>[148, 190, 129]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#A8BD99"}}></td>
---  <td>Laurel green</td>
---  <td>324</td>
---  <td>[168, 189, 153]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#DFDFDE"}}></td>
---  <td>Quill grey</td>
---  <td>325</td>
---  <td>[223, 223, 222]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#970000"}}></td>
---  <td>Crimson</td>
---  <td>327</td>
---  <td>[151, 0, 0]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#B1E5A6"}}></td>
---  <td>Mint</td>
---  <td>328</td>
---  <td>[177, 229, 166]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#98C2DB"}}></td>
---  <td>Baby blue</td>
---  <td>329</td>
---  <td>[152, 194, 219]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FF98DC"}}></td>
---  <td>Carnation pink</td>
---  <td>330</td>
---  <td>[255, 152, 220]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FF5959"}}></td>
---  <td>Persimmon</td>
---  <td>331</td>
---  <td>[255, 89, 89]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#750000"}}></td>
---  <td>Maroon</td>
---  <td>332</td>
---  <td>[117, 0, 0]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#EFB838"}}></td>
---  <td>Gold</td>
---  <td>333</td>
---  <td>[239, 184, 56]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#F8D96D"}}></td>
---  <td>Daisy orange</td>
---  <td>334</td>
---  <td>[248, 217, 109]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E7E7EC"}}></td>
---  <td>Pearl</td>
---  <td>335</td>
---  <td>[231, 231, 236]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#C7D4E4"}}></td>
---  <td>Fog</td>
---  <td>336</td>
---  <td>[199, 212, 228]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FF9494"}}></td>
---  <td>Salmon</td>
---  <td>337</td>
---  <td>[255, 148, 148]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#BE6862"}}></td>
---  <td>Terra Cotta</td>
---  <td>338</td>
---  <td>[190, 104, 98]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#562424"}}></td>
---  <td>Cocoa</td>
---  <td>339</td>
---  <td>[86, 36, 36]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#F1E7C7"}}></td>
---  <td>Wheat</td>
---  <td>340</td>
---  <td>[241, 231, 199]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FEF3BB"}}></td>
---  <td>Buttermilk</td>
---  <td>341</td>
---  <td>[254, 243, 187]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E0B2D0"}}></td>
---  <td>Mauve</td>
---  <td>342</td>
---  <td>[224, 178, 208]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#D490BD"}}></td>
---  <td>Sunrise</td>
---  <td>343</td>
---  <td>[212, 144, 189]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#965555"}}></td>
---  <td>Tawny</td>
---  <td>344</td>
---  <td>[150, 85, 85]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#8F4C2A"}}></td>
---  <td>Rust</td>
---  <td>345</td>
---  <td>[143, 76, 42]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#D3BE96"}}></td>
---  <td>Cashmere</td>
---  <td>346</td>
---  <td>[211, 190, 150]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E2DCBC"}}></td>
---  <td>Khaki</td>
---  <td>347</td>
---  <td>[226, 220, 188]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#EDEAEA"}}></td>
---  <td>Lily white</td>
---  <td>348</td>
---  <td>[237, 234, 234]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#E9DADA"}}></td>
---  <td>Seashell</td>
---  <td>349</td>
---  <td>[233, 218, 218]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#883E3E"}}></td>
---  <td>Burgundy</td>
---  <td>350</td>
---  <td>[136, 62, 62]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#BC9B5D"}}></td>
---  <td>Cork</td>
---  <td>351</td>
---  <td>[188, 155, 93]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#C7AC78"}}></td>
---  <td>Burlap</td>
---  <td>352</td>
---  <td>[199, 172, 120]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#CABFA3"}}></td>
---  <td>Beige</td>
---  <td>353</td>
---  <td>[202, 191, 163]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#BBB3B2"}}></td>
---  <td>Oyster</td>
---  <td>354</td>
---  <td>[187, 179, 178]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#6C584B"}}></td>
---  <td>Pine Cone</td>
---  <td>355</td>
---  <td>[108, 88, 75]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#A0844F"}}></td>
---  <td>Fawn brown</td>
---  <td>356</td>
---  <td>[160, 132, 79]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#958988"}}></td>
---  <td>Hurricane grey</td>
---  <td>357</td>
---  <td>[149, 137, 136]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#ABA89E"}}></td>
---  <td>Cloudy grey</td>
---  <td>358</td>
---  <td>[171, 168, 158]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#AF9483"}}></td>
---  <td>Linen</td>
---  <td>359</td>
---  <td>[175, 148, 131]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#966766"}}></td>
---  <td>Copper</td>
---  <td>360</td>
---  <td>[150, 103, 102]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#564236"}}></td>
---  <td>Medium brown</td>
---  <td>361</td>
---  <td>[86, 66, 54]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#7E683F"}}></td>
---  <td>Bronze</td>
---  <td>362</td>
---  <td>[126, 104, 63]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#69665C"}}></td>
---  <td>Flint</td>
---  <td>363</td>
---  <td>[105, 102, 92]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#5A4C42"}}></td>
---  <td>Dark taupe</td>
---  <td>364</td>
---  <td>[90, 76, 66]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#6A3909"}}></td>
---  <td>Burnt Sienna</td>
---  <td>365</td>
---  <td>[106, 57, 9]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#F8F8F8"}}></td>
---  <td>Institutional white</td>
---  <td>1001</td>
---  <td>[248, 248, 248]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#CDCDCD"}}></td>
---  <td>Mid gray</td>
---  <td>1002</td>
---  <td>[205, 205, 205]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#111111"}}></td>
---  <td>Really black</td>
---  <td>1003</td>
---  <td>[17, 17, 17]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FF0000"}}></td>
---  <td>Really red</td>
---  <td>1004</td>
---  <td>[255, 0, 0]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FFB000"}}></td>
---  <td>Deep orange</td>
---  <td>1005</td>
---  <td>[255, 176, 0]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#B480FF"}}></td>
---  <td>Alder</td>
---  <td>1006</td>
---  <td>[180, 128, 255]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#A34B4B"}}></td>
---  <td>Dusty Rose</td>
---  <td>1007</td>
---  <td>[163, 75, 75]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#C1BE42"}}></td>
---  <td>Olive</td>
---  <td>1008</td>
---  <td>[193, 190, 66]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FFFF00"}}></td>
---  <td>New Yeller</td>
---  <td>1009</td>
---  <td>[255, 255, 0]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#0000FF"}}></td>
---  <td>Really blue</td>
---  <td>1010</td>
---  <td>[0, 0, 255]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#002060"}}></td>
---  <td>Navy blue</td>
---  <td>1011</td>
---  <td>[0, 32, 96]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#2154B9"}}></td>
---  <td>Deep blue</td>
---  <td>1012</td>
---  <td>[33, 84, 185]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#04AFEC"}}></td>
---  <td>Cyan</td>
---  <td>1013</td>
---  <td>[4, 175, 236]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#AA5500"}}></td>
---  <td>CGA brown</td>
---  <td>1014</td>
---  <td>[170, 85, 0]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#AA00AA"}}></td>
---  <td>Magenta</td>
---  <td>1015</td>
---  <td>[170, 0, 170]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FF66CC"}}></td>
---  <td>Pink</td>
---  <td>1016</td>
---  <td>[255, 102, 204]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FFAF00"}}></td>
---  <td>Deep orange</td>
---  <td>1017</td>
---  <td>[255, 175, 0]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#12EED4"}}></td>
---  <td>Teal</td>
---  <td>1018</td>
---  <td>[18, 238, 212]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#00FFFF"}}></td>
---  <td>Toothpaste</td>
---  <td>1019</td>
---  <td>[0, 255, 255]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#00FF00"}}></td>
---  <td>Lime green</td>
---  <td>1020</td>
---  <td>[0, 255, 0]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#3A7D15"}}></td>
---  <td>Camo</td>
---  <td>1021</td>
---  <td>[58, 125, 21]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#7F8E64"}}></td>
---  <td>Grime</td>
---  <td>1022</td>
---  <td>[127, 142, 100]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#8C5B9F"}}></td>
---  <td>Lavender</td>
---  <td>1023</td>
---  <td>[140, 91, 159]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#AFDDFF"}}></td>
---  <td>Pastel light blue</td>
---  <td>1024</td>
---  <td>[175, 221, 255]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FFC9C9"}}></td>
---  <td>Pastel orange</td>
---  <td>1025</td>
---  <td>[255, 201, 201]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#B1A7FF"}}></td>
---  <td>Pastel violet</td>
---  <td>1026</td>
---  <td>[177, 167, 255]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#9FF3E9"}}></td>
---  <td>Pastel blue-green</td>
---  <td>1027</td>
---  <td>[159, 243, 233]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#CCFFCC"}}></td>
---  <td>Pastel green</td>
---  <td>1028</td>
---  <td>[204, 255, 204]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FFFFCC"}}></td>
---  <td>Pastel yellow</td>
---  <td>1029</td>
---  <td>[255, 255, 204]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FFCC99"}}></td>
---  <td>Pastel brown</td>
---  <td>1030</td>
---  <td>[255, 204, 153]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#6225D1"}}></td>
---  <td>Royal purple</td>
---  <td>1031</td>
---  <td>[98, 37, 209]</td>
---</tr>
---<tr>
---  <td style={{backgroundColor: "#FF00BF"}}></td>
---  <td>Hot pink</td>
---  <td>1032</td>
---  <td>[255, 0, 191]</td>
---</tr>
---</tbody>
---</table>
---
BrickColor = nil;
---The unique number that identifies the BrickColor.
---
BrickColor.Number = nil;
---The red component of the BrickColor (between 0 and 1).
---
BrickColor.r = nil;
---The green component of the BrickColor (between 0 and 1).
---
BrickColor.g = nil;
---The blue component of the BrickColor (between 0 and 1).
---
BrickColor.b = nil;
---The name associated with the BrickColor.
---
BrickColor.Name = nil;
---The Color3 associated with the BrickColor.
---
BrickColor.Color = nil;
---Returns the BrickColor Black.
---@return BrickColor
BrickColor.Black = function() end;
---Returns the BrickColor Bright Red.
---@return BrickColor
BrickColor.Red = function() end;
---Returns a random BrickColor.
---@return BrickColor
BrickColor.random = function() end;
---Returns the BrickColor White.
---@return BrickColor
BrickColor.White = function() end;
---Returns the BrickColor Bright Blue.
---@return BrickColor
BrickColor.Blue = function() end;
---Returns the BrickColor Medium stone grey.
---@return BrickColor
BrickColor.Gray = function() end;
---Returns the BrickColor Dark Green.
---@return BrickColor
BrickColor.Green = function() end;
---Returns the BrickColor Bright Yellow.
---@return BrickColor
BrickColor.Yellow = function() end;
---Returns the BrickColor Dark stone grey.
---@return BrickColor
BrickColor.DarkGray = function() end;
---@overload fun(r: number, g: number, b: number)
---@overload fun(val: string)
---@overload fun(color: Color3)
---@param val number
---Constructs a BrickColor from its numerical index.
---@return BrickColor
BrickColor.new = function(val) end;
---@param paletteValue number
---Constructs a BrickColor from its palette index.
---@return BrickColor
BrickColor.palette = function(paletteValue) end;
---@class CFrame
---@field public identity CFrame
---@field public Position Vector3
---@field public Rotation CFrame
---@field public X number
---@field public Y number
---@field public Z number
---@field public LookVector Vector3
---@field public RightVector Vector3
---@field public UpVector Vector3
---@field public XVector Vector3
---@field public YVector Vector3
---@field public ZVector Vector3
---The `CFrame` data type, short for **coordinate frame**, describes a 3D
---position and orientation. It is made up of a **positional** component and a
---**rotational** component. It includes essential arithmetic operations for
---working with 3D data on Roblox.
---
---```lua
----- A canonical method of creating a CFrame at a certain position and Euler rotation (XYZ).
---local cf = CFrame.new(0, 5, 0) * CFrame.Angles(math.rad(45), 0, 0)
---```
---
---A `CFrameValue` object stores exactly one `CFrame` value in a Roblox object.
---For an introduction to `CFrame` data type, see Understanding CFrame. To learn
---more about `CFrame` math operations see CFrame Math Operations.
---
---## Components
---
---### Positional
---
---The positional component is available as a `Vector3` in the **Position**
---property. In addition, the components of a `CFrame object`'s position are also
---available in the X, Y and Z properties like a Vector3. A CFrame placed at a
---specific position without any rotation can be constructed using
---`CFrame.new(Vector3)` or `CFrame.new(X, Y, Z)`.
---
---### Rotational
---
---CFrame stores 3D rotation data in a 3-by-3 **rotation matrix**. These values
---are returned by the `CFrame:GetComponents` function after the X, Y and Z
---positional values. This matrix is used internally when doing
---[calculations involving rotations](https://en.wikipedia.org/wiki/Rotation_matrix#Basic_rotations).
---They use [radians](https://en.wikipedia.org/wiki/Radian) as their unit (for
---conversion to degrees, use `math.rad` or `math.deg`).
---
---The matrix below represents the components of a `CFrame` object's rotation
---matrix and their relationship with the various vector properties available
---(`LookVector`, `RightVector`, etc). Although the individual components of the
---rotation matrix are rarely useful by themselves, the vector properties which
---derive from them are much more useful.
---
---<table>
---<tbody>
---<tr><td></td>
---  <td><strong>RightVector</strong>
---  </td><td><strong>UpVector</strong>
---  </td><td><strong>&ndash;LookVector<sup>&dagger;</sup></strong></td>
---</tr>
---<tr><td><strong>XVector</strong></td><td>R00</td><td>R01</td><td>R02</td></tr>
---<tr><td><strong>YVector</strong></td><td>R10</td><td>R11</td><td>R12</td></tr>
---<tr><td><strong>ZVector</strong></td><td>R20</td><td>R21</td><td>R22</td></tr>
---</tbody>
---</table>
---
---&dagger; Unlike `RightVector` and `UpVector`, `LookVector` represents the
---negated right/third column components.
---
CFrame = nil;
---An identity CFrame, one with no translation or rotation.
---
---This API member is a **constant**, and must be accessed through the CFrame
---global as opposed to an individual CFrame object.
---
---```lua
---print(CFrame.identity) --> 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1
---```
---
CFrame.identity = nil;
---The 3D position of the CFrame.
---
CFrame.Position = nil;
---A copy of the CFrame with no translation.
---
CFrame.Rotation = nil;
---The x-coordinate of the position.
---
CFrame.X = nil;
---The y-coordinate of the position.
---
CFrame.Y = nil;
---The z-coordinate of the position.
---
CFrame.Z = nil;
---The forward-direction component of the CFrame's orientation. Equivalent
---to: `Vector3.new(-r20, -r21, -r22)`.
---
---Adding a CFrame's `LookVector` to itself would produce a CFrame moved
---forward in whichever direction the CFrame is facing by 1 unit:
---
---```lua
---cf = cf + cf.LookVector * n -- Move cf forward n units
---```
---
CFrame.LookVector = nil;
---The right-direction component of the CFrame's orientation. Equivalent to
---the first/left column of the rotation matrix, or
---`Vector3.new(r00, r01, r02)`.
---
CFrame.RightVector = nil;
---The up-direction component of the CFrame's orientation. Equivalent to the
---second/middle column of the rotation matrix, or
---`Vector3.new(r01, r11, r12)`.
---
CFrame.UpVector = nil;
---Equivalent to the first row of the rotation matrix, or
---`Vector3.new(r00, r01, r02)`.
---
CFrame.XVector = nil;
---Equivalent to the second/middle row of the rotation matrix, or
---`Vector3.new(r10, r11, r12)`.
---
CFrame.YVector = nil;
---Equivalent to the third/bottom row of the rotation matrix, or
---`Vector3.new(r20, r21, r22)`.
---
CFrame.ZVector = nil;
---@param v Vector3
---@param r number
---Returns a rotated CFrame from a Unit Vector3 and a rotation in radians.
---@return CFrame
CFrame.fromAxisAngle = function(v, r) end;
---@param pos Vector3
---@param vX Vector3
---@param vY Vector3
---@param vZ Vector3
---Returns a CFrame from a translation and the columns of a rotation
---matrix. If `vz` is excluded, the third column is calculated as
---`[vx:Cross(vy).Unit]`.
---@return CFrame
CFrame.fromMatrix = function(pos, vX, vY, vZ) end;
---@param at Vector3
---@param lookAt Vector3
---@param up Vector3
---Returns a new CFrame located at `at` and facing towards `lookAt`,
---optionally specifying the upward direction (by default, (0, 1, 0)).
---
---This function replaces the `CFrame.new(Vector3, Vector3)` constructor (see
---above) which accomplished a similar task. This function allows you to
---specify the `up` Vector, using the same default as the old constructor.
---@return CFrame
CFrame.lookAt = function(at, lookAt, up) end;
---@param rx number
---@param ry number
---@param rz number
---Equivalent to `fromEulerAnglesYXZ`.
---@return CFrame
CFrame.fromOrientation = function(rx, ry, rz) end;
---@param rx number
---@param ry number
---@param rz number
---Returns a rotated CFrame using angles (rx, ry, rz) in radians. Rotations
---are applied in Z, Y, X order.
---@return CFrame
CFrame.fromEulerAnglesXYZ = function(rx, ry, rz) end;
---@overload fun(pos: Vector3)
---@overload fun(pos: Vector3, lookAt: Vector3)
---@overload fun(x: number, y: number, z: number)
---@overload fun(x: number, y: number, z: number, qX: number, qY: number, qZ: number, qW: number)
---@overload fun(x: number, y: number, z: number, R00: number, R01: number, R02: number, R10: number, R11: number, R12: number, R20: number, R21: number, R22: number)
---Creates a blank identity CFrame.
---@return CFrame
CFrame.new = function() end;
---@param rx number
---@param ry number
---@param rz number
---Equivalent to `fromEulerAnglesXYZ`.
---@return CFrame
CFrame.Angles = function(rx, ry, rz) end;
---@param rx number
---@param ry number
---@param rz number
---Returns a rotated CFrame using angles (rx, ry, rz) in radians. Rotations
---are applied in Y, X, Z order.
---@return CFrame
CFrame.fromEulerAnglesYXZ = function(rx, ry, rz) end;
---@param cf CFrame
---@return CFrame
---Returns a CFrame transformed from World to Object space. Equivalent to
---`[CFrame:inverse() * cf]`.
---
CFrame.ToObjectSpace = function(self, cf) end;
---@return Tuple
---Returns all 12 numerical components of the CFrame in the following order:
---
---```lua
---x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = cf:components()
---```
---
---(See the Rotational Component section above)
---
CFrame.components = function(self) end;
---@return Vector3, number
---Returns a tuple of a Vector3 and a number which represent the rotation of
---the CFrame in the axis-angle representation.
---
CFrame.ToAxisAngle = function(self) end;
---@return number, number, number
---Returns approximate angles that could be used to generate the CFrame, if
---angles were applied in Z, Y, X order.
---
CFrame.ToEulerAnglesXYZ = function(self) end;
---@param v3 Vector3
---@return Vector3
---Returns a Vector3 rotated from World to Object space. Equivalent to
---`[(CFrame:inverse() - CFrame:inverse().p) * v3]`.
---
CFrame.VectorToObjectSpace = function(self, v3) end;
---@return CFrame
---Returns an orthonormalized copy of the CFrame. The `BasePart/CFrame`
---property automatically applies orthonormalization, but other APIs which
---take CFrames do not, so this method will occasionally be necessary when
---when incrementally updating a CFrame and using it with them.
---
CFrame.Orthonormalize = function(self) end;
---@param v3 Vector3
---@return Vector3
---Returns a Vector3 transformed from World to Object space. Equivalent to
---`[CFrame:inverse() * v3]`.
---
CFrame.PointToObjectSpace = function(self, v3) end;
---@return number, number, number
---Returns approximate angles that could be used to generate the CFrame, if
---angles were applied in Z, X, Y order.
---
CFrame.ToEulerAnglesYXZ = function(self) end;
---@param cf CFrame
---@return CFrame
---Returns a CFrame transformed from Object to World space. Equivalent to
---`[CFrame * cf]`.
---
CFrame.ToWorldSpace = function(self, cf) end;
---@return CFrame
---Returns the inverse of the CFrame.
---
CFrame.Inverse = function(self) end;
---@return Tuple<number>
---Returns the values: x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22,
---where R00-R22 represent the 3x3 rotation matrix of the CFrame, and xyz
---represent the position of the CFrame.
---
CFrame.GetComponents = function(self) end;
---@return number, number, number
---Returns approximate angles that could be used to generate the CFrame, if
---angles were applied in Z, X, Y order. Equivalent to toEulerAnglesYXZ.
---
CFrame.ToOrientation = function(self) end;
---@param goal CFrame
---@param alpha number
---@return CFrame
---Returns a CFrame interpolated between this CFrame and the goal by the
---fraction alpha.
---
CFrame.Lerp = function(self, goal, alpha) end;
---@param v3 Vector3
---@return Vector3
---Returns a Vector3 rotated from Object to World space. Equivalent to
---`[(CFrame - CFrame.p) *v3]`.
---
CFrame.VectorToWorldSpace = function(self, v3) end;
---@param v3 Vector3
---@return Vector3
---Returns a Vector3 transformed from Object to World space. Equivalent to
---`[CFrame * v3]`.
---
CFrame.PointToWorldSpace = function(self, v3) end;
---@class CatalogSearchParams
---@field public SearchKeyword string
---@field public MinPrice int
---@field public MaxPrice int
---@field public SortType CatalogSortType
---@field public CategoryFilter CatalogCategoryFilter
---@field public BundleType Array<BundleType>
---@field public AssetTypes Array<AvatarAssetType>
---The `CatalogSearchParams` data type stores the parameters of a catalog search
---via `AvatarEditorService:SearchCatalog()`.
---
---When accessing the value of the `BundleTypes` or `AssetTypes` property the
---returned table will be read-only to avoid confusion when not directly
---accessing the `CatalogSearchParams` instance.
---
---For example, you can use these properties as follows:
---
---```lua
---local params = CatalogSearchParams.new()
---params.SearchKeyword = "Test"
---params.MinPrice = 5000
---params.MaxPrice = 10000
---params.BundleTypes = {Enum.BundleType.Animations, Enum.BundleType.BodyParts}
---
---local types = params.BundleTypes
---for _, val in ipairs(types) do
---  print(val)
---end
----- table.insert(types, Enum.BundleType.Animations) -- This would not work because the table is read only
---```
---
CatalogSearchParams = nil;
---The keyword to search for catalog results with.
---
CatalogSearchParams.SearchKeyword = nil;
---The minimum item price to search for.
---
CatalogSearchParams.MinPrice = nil;
---The maximum item price to search for.
---
CatalogSearchParams.MaxPrice = nil;
---The order in which to sort the results, represented by a
---`enum/CatalogSortType`.
---
CatalogSearchParams.SortType = nil;
---The category to filter the search by, represented by a
---`enum/CatalogCategoryFilter`.
---
CatalogSearchParams.CategoryFilter = nil;
---An array containing `enum/BundleType` values to filter the search by.
---
CatalogSearchParams.BundleType = nil;
---An array containing `enum/AvatarAssetType` values to filter the search by.
---
CatalogSearchParams.AssetTypes = nil;
---@class Color3
---@field public R number
---@field public G number
---@field public B number
---The `Color3` a data type describes a color using R, G and B components, which
---are on the range `[0, 1]`. `Color3` is used for precise coloring of objects on
---screen through properties like `BasePart/Color` and
---`GuiObject/BackgroundColor3`. Unlike, the `BrickColor` data type, which
---**describes** named colors, `Color3` describes **specific** colors.
---
Color3 = nil;
---The red value of the color.
---
Color3.R = nil;
---The green value of the color.
---
Color3.G = nil;
---The blue value of the color.
---
Color3.B = nil;
---@param hue number
---@param saturation number
---@param value number
---Creates a Color3 with the given [hue](https://en.wikipedia.org/wiki/Hue),
---[saturation](https://en.wikipedia.org/wiki/Colorfulness#Saturation), and
---[value](https://en.wikipedia.org/wiki/Lightness). The parameters should be
---on the range ``[0, 1]``.
---@return Color3
Color3.fromHSV = function(hue, saturation, value) end;
---@param red number
---@param green number
---@param blue number
---Creates a Color3 with the given red, green, and blue components. Unlike
---most other Color3 functions, the parameters for this function should be on
---the range `[0, 255]`.
---@return Color3
Color3.fromRGB = function(red, green, blue) end;
---@param red number
---@param green number
---@param blue number
---Returns a Color3 with the given red, green, and blue values. The
---parameters should be on the range `[0, 1]`.
---@return Color3
Color3.new = function(red, green, blue) end;
---@param hex string
---Returns a new Color3 from a six- or three-character
---[hexadecimal](https://en.wikipedia.org/wiki/Hexadecimal) format. A
---preceding octothorpe (`#`) is ignored, if present. This function
---interprets the given string as a typical web hex color in the format
---`RRGGBB` or `RGB` (shorthand for `RRGGBB`). For example, `#FFAA00`
---produces an orange color, and is the same as `#FA0`.
---
---The color returned can be converted back into hex using `Color3:toHex`,
---although it is not guaranteed to return the exact same string as passed to
---this function.
---
---```lua
---print(Color3.fromHex("#FF0000")) --> 1, 0, 0
---```
---@return Color3
Color3.fromHex = function(hex) end;
---@param color Color3
---@return number, number, number
---Returns the
---[hue, saturation, and value](https://en.wikipedia.org/wiki/HSL_and_HSV) of
---a Color3. This function is the inverse operation of the `Color3.fromHSV`
---constructor.
---
Color3.toHSV = function(color) end;
---@param color Color3
---@param alpha number
---@return Color3
---Returns a Color3 interpolated between two Color3 objects. Alpha is a
---number from 0 to 1.
---
Color3.Lerp = function(self, color, alpha) end;
---@return number, number, number
---Returns the
---[hue, saturation, and value](https://en.wikipedia.org/wiki/HSL_and_HSV) of
---a Color3. This function is the inverse operation of the `Color3.fromHSV`
---constructor.
---
Color3.ToHSV = function(self) end;
---@return string
---Converts the color to a six-character hexadecimal string representing the
---color in the format `RRGGBB`. It is not prefixed with an octothorpe (`#`),
---although this can be concatenated easily.
---
---The returned string can be provided to `Color3.fromHex` to produce the
---original color.
---
---```lua
---print(Color3.new(0, 1, 0):ToHex()) --> "00FF00"
---print(BrickColor.new("Really red").Color:ToHex()) --> "FF0000"
---```
---
Color3.ToHex = function(self) end;
---@class ColorSequence
---@field public Keypoints table
---The `ColorSequence` data type represents a gradient of color values from `0`
---to `1`. The color values are expressed using the `ColorSequenceKeypoint` type.
---This type is used in various properties of `ParticleEmitter`, `Trail`, and
---`Beam`. In Studio, this data type is edited using a gradient editor:
---
---![Editing the Color property of a ParticleEmitter within Studio. The gradient
---shows 5 `ColorSequenceKeypoint` at times 0, 0.25, 0.5, 0.75 and 1. The 2nd and
---4th are blue and yellow, respectively.][1]
---
---The above gradient can be set using a script using the following call to
---`ColorSequence.new()`:
---
---```lua
---local white = Color3.new(1, 1, 1)
---local lightBlue = Color3.new(0, 2/3, 1)
---local yellow = Color3.new(1, 1, 0)
---particleEmitter.Color = ColorSequence.new{
---    ColorSequenceKeypoint.new(0, white),
---    ColorSequenceKeypoint.new(0.25, lightBlue),
---    ColorSequenceKeypoint.new(0.5, white),
---    ColorSequenceKeypoint.new(0.75, yellow),
---    ColorSequenceKeypoint.new(1, white)
---}
---```
---
---## Equality
---
---Two `ColorSequence` objects are equivalent if and only if the values of their
---`ColorSequenceKeypoint` are equivalent, even if the two `ColorSequence` would
---result in similar gradients.
---
---## Evaluation
---
---The `ColorSequence` type does not have a built-in method for getting the value
---at a certain time/point. However, you can use the following function to
---evaluate at a specific time.
---
---```lua
---function evalCS(cs, time)
---	-- If we are at 0 or 1, return the first or last value respectively
---	if time == 0 then return cs.Keypoints[1].Value end
---	if time == 1 then return cs.Keypoints[#cs.Keypoints].Value end
---	-- Step through each sequential pair of keypoints and see if alpha
---	-- lies between the points' time values.
---	for i = 1, #cs.Keypoints - 1 do
---		local this = cs.Keypoints[i]
---		local next = cs.Keypoints[i + 1]
---		if time >= this.Time and time < next.Time then
---			-- Calculate how far alpha lies between the points
---			local alpha = (time - this.Time) / (next.Time - this.Time)
---			-- Evaluate the real value between the points using alpha
---			return Color3.new(
---				(next.Value.R - this.Value.R) * alpha + this.Value.R,
---				(next.Value.G - this.Value.G) * alpha + this.Value.G,
---				(next.Value.B - this.Value.B) * alpha + this.Value.B
---			)
---		end
---	end
---end
---```
---
---You can use the function above like this:
---
---```lua
---local cs = ColorSequence.new{
---    ColorSequenceKeypoint.new(0, BrickColor.new("Really red").Color),
---    ColorSequenceKeypoint.new(1, BrickColor.new("Really blue").Color)
---}
---print(evalCS(cs, 0.5))
----- 0.5, 0, 0.5 (purple, since it's halfway between red and blue)
---```
---
---[1]: /assets/blt80328d6105a0c126/ParticleEmitter.Color.jpg
---
ColorSequence = nil;
---An array containing `ColorSequenceKeypoint` values for the
---`ColorSequence`.
---
ColorSequence.Keypoints = nil;
---@overload fun(c0: Color3, c1: Color3)
---@overload fun(keypoints: table)
---@param c Color3
---Returns a sequence of two keypoints with `c` for both the start and end
---values.
---
---```lua
---local cs = ColorSequence.new(c)
----- is equivalent to
---local cs = ColorSequence.new{
---    ColorSequenceKeypoint.new(0, c),
---    ColorSequenceKeypoint.new(1, c)
---}
---```
---@return ColorSequence
ColorSequence.new = function(c) end;
---@class ColorSequenceKeypoint
---@field public Time number
---@field public Value Color3
ColorSequenceKeypoint = nil;
---The relative time at which the keypoint is located.
---
ColorSequenceKeypoint.Time = nil;
---The Color3 value of the keypoint.
---
ColorSequenceKeypoint.Value = nil;
---@param time number
---@param color Color3
---Creates a keypoint with a specified time and color.
---@return ColorSequenceKeypoint
ColorSequenceKeypoint.new = function(time, color) end;
---@class DateTime
---@field public UnixTimestamp Integer
---@field public UnixTimestampMillis Integer
---The `DateTime` data type represents a moment in time using a
---[Unix timestamp](https://en.wikipedia.org/wiki/Unix_time). It can be used to
---easily format dates and times in specific locales. When converted to a string,
---a string conversion of the stored timestamp integer is returned. They don't
---store timezone values. Instead, timezones are considered when constructing and
---using DateTime objects.
---
---DateTime objects are equal if and only if their `UnixTimestampMillis`
---properties are equal.
---
---## Time Value Table
---
---The functions `ToUniversalTime()` and `ToLocalTime()` return a table of
---time-related values, such as Year, Month, and Day. The format of the table
---returned by these functions is described below, with each integer element in
---descending size order:
---
---<table>
---<thead>
---  <tr>
---    <td>Name</td>
---    <td>Range</td>
---    <td>Notes</td>
---  </tr>
---</thead>
---<tbody>
---<tr>
---  <td><code>Year</code></td><td>1400&ndash;9999</td><td>&ndash;</td>
---</tr>
---<tr>
---  <td><code>Month</code></td><td>1&ndash;12</td><td >&ndash;</td>
---</tr>
---<tr>
---  <td><code>Day</code></td><td>1&ndash;31</td><td >&ndash;</td>
---</tr>
---<tr>
---  <td><code>Hour</code></td><td>0&ndash;23</td><td >&ndash;</td>
---</tr>
---<tr>
---  <td><code>Minute</code></td><td>0&ndash;59</td><td >&ndash;</td>
---</tr>
---<tr>
---  <td><code>Second</code></td><td>0&ndash;60</td><td>Usually
---  0&ndash;59, sometimes 60 to accommodate leap seconds in certain
---  systems.</td>
---</tr> <tr>
---  <td>Millisecond</td><td>0&ndash;999</td><td >&ndash;</td>
---</tr>
---</tbody>
---</table>
---
---## String Format
---
---The `DateTime` object supports date/time conversion into a string through the
---`FormatUniversalTime()` and `FormatLocalTime()` functions. They both work the
---same except for which timezone the `DateTime` should be interpreted in.
---
---The first argument passed to these functions must be a string representing one
---of the tokens shown below. The tokens are then replaced with a specific value
---depending on the provided locale.
---
---```lua
---local dt = DateTime.now()
----- The "dddd" token is replaced with the full day of the week
---print("Today is " .. dt:FormatLocalTime("dddd", "en-us"))
---
----- For the "en-us" locale, the "LL" token equals "MMMM D, YYYY"
---print("The date is " .. dt:FormatLocalTime("LL", "en-us"))
---```
---
---### Composite Tokens
---
---Depending on locale, these tokens replace to **specific combinations** of the
---[elemental tokens](#elemental-tokens) described in the next section. This
---produces a correct date/time string depending on the locale. For example, in
---English, the date has the "[month] [day]" as in "June 11". In French, the date
---is in a "[day] [month]" format as in "11 juin". These special rules are
---handled for you automatically through the following composite tokens, so use
---these if you're displaying simple time and/or date information.
---
---<table>
---  <thead>
---    <tr>
---      <th>Token(s)</th>
---      <th>Locale Examples (Format)</th>
---    </tr>
---  </thead>
---    <thead>
---    <tr>
---      <th colspan=2>Time</th>
---    </tr>
---  </thead>
---  <tbody>
---    <tr>
---      <td><code>LT</code></td>
---      <td>
---        <div><code>en-us</code> : <code>8:30 PM</code> (<code>h:mm A</code>)</div>
---        <div><code>zh-cn</code> : <code>20:30</code> (<code>HH:mm</code>)</div>
---      </td>
---    </tr>
---  </tbody>
---    <thead>
---    <tr>
---      <th colspan=2>Time with Seconds</th>
---    </tr>
---  </thead>
---  <tbody>
---    <tr>
---      <td><code>LTS</code></td>
---      <td>
---        <div><code>en-us</code> : <code>8:30:25 PM</code> (<code>h:mm:ss A</code>)</div>
---        <div><code>zh-cn</code> : <code>20:30:25</code> (<code>HH:mm:ss</code>)</div>
---      </td>
---    </tr>
---  </tbody>
---    <thead>
---    <tr>
---      <th colspan=2>Month (Number), Day, Year</th>
---    </tr>
---  </thead>
---  <tbody>
---    <tr>
---      <td><code>L</code></td>
---      <td>
---        <div><code>en-us</code> : <code>09/04/1986</code> (<code>MM/DD/YYYY</code>)</div>
---        <div><code>zh-cn</code> : <code>1986/09/04</code> (<code>YYYY/MM/DD</code>)</div>
---      </td>
---    </tr>
---    <tr>
---      <td><code>l</code></td>
---      <td>
---        <div><code>en-us</code> : <code>9/4/1986</code> (<code>M/D/YYYY</code>)</div>
---        <div><code>zh-cn</code> : <code>1986/9/4</code> (<code>YYYY/M/D</code>)</div>
---      </td>
---    </tr>
---  </tbody>
---    <thead>
---    <tr>
---      <th colspan=2>Month (Name), Day, Year</th>
---    </tr>
---  </thead>
---  <tbody>
---    <tr>
---      <td><code>LL</code></td>
---      <td>
---        <div><code>en-us</code> : <code>September 4, 1986</code> (<code>MMMM D, YYYY</code>)</div>
---        <div><code>zh-cn</code> : <code>1986年9月4日</code> (<code>YYYY年M月D日</code>)</div>
---      </td>
---    </tr>
---    <tr>
---      <td><code>ll</code></td>
---      <td>
---        <div><code>en-us</code> : <code>Sep 4, 1986</code> (<code>MMM D, YYYY</code>)</div>
---        <div><code>zh-cn</code> : <code>1986年9月4日</code> (<code>YYYY年M月D日</code>)</div>
---      </td>
---    </tr>
---  </tbody>
---    <thead>
---    <tr>
---      <th colspan=2>Month (Name), Day, Year, Time</th>
---    </tr>
---  </thead>
---  <tbody>
---    <tr>
---      <td><code>LLL</code></td>
---      <td>
---        <div><code>en-us</code> : <code>September 4, 1986 8:30 PM</code> (<code>MMMM D, YYYY h:mm A</code>)</div>
---        <div><code>zh-cn</code> : <code>1986年9月4日晚上8点30分</code> (<code>YYYY年M月D日Ah点mm分</code>)</div>
---      </td>
---    </tr>
---    <tr>
---      <td><code>lll</code></td>
---      <td>
---        <div><code>en-us</code> : <code>Sep 4, 1986 8:30 PM</code> (<code>MMM D, YYYY h:mm A</code>)</div>
---        <div><code>zh-cn</code> : <code>1986年9月4日 20:30</code> (<code>YYYY年M月D日 HH:mm</code>)</div>
---      </td>
---    </tr>
---  </tbody>
---    <thead>
---    <tr>
---      <th colspan=2>Day of Week, Month (Name), Day, Year, Time</th>
---    </tr>
---  </thead>
---  <tbody>
---    <tr>
---      <td><code>LLLL</code></td>
---      <td>
---        <div><code>en-us</code> : <code>Thursday, September 4, 1986 8:30 PM</code> (<code>dddd, MMMM D, YYYY h:mm A</code>)</div>
---        <div><code>zh-cn</code> : <code>1986年9月4日星期四晚上8点30分</code> (<code>YYYY年M月D日ddddAh点mm分</code>)</div>
---      </td>
---    </tr>
---    <tr>
---      <td><code>llll</code></td>
---      <td>
---        <div><code>en-us</code> : <code>Thu, Sep 4, 1986 8:30 PM</code> (<code>ddd, MMM D, YYYY h:mm A</code>)</div>
---        <div><code>zh-cn</code> : <code>1986年9月4日星期四 20:30</code> (<code>YYYY年M月D日dddd HH:mm</code>)</div>
---      </td>
---    </tr>
---  </tbody>
---</table>
---
---### Elemental Tokens
---
---Each of these tokens replace to a **single value** and can be used as elements
---of a larger time string. Avoid using these if you only need simple date and
---time information because the composite tokens above are more appropriate for
---those purposes.
---
---<table>
---<thead>
---  <tr>
---    <th>Token(s)</th>
---    <th>Examples</th>
---  </tr>
---</thead>
---  <thead>
---  <tr>
---    <th colspan=2>Year</th>
---  </tr>
---</thead>
---<tbody>
---<tr>
---  <td><code>YY</code></td>
---  <td><code>70</code>, <code>71</code>, &hellip;, <code>29</code>, <code>30</code></td>
---</tr>
---<tr>
---  <td><code>YYYY</code></td>
---  <td><code>1970</code>, <code>1971</code>, &hellip;, <code>2029</code>, <code>2030</code></td>
---</tr>
---</tbody>
---  <thead>
---  <tr>
---    <th colspan=2>Month</th>
---  </tr>
---</thead>
---<tbody>
---<tr>
---  <td><code>M</code></td>
---  <td><code>1</code>, <code>2</code>, &hellip;, <code>11</code>, <code>12</code></td>
---</tr>
---<tr>
---  <td><code>MM</code></td>
---  <td><code>01</code>, <code>02</code>, &hellip;, <code>11</code>, <code>12</code></td>
---</tr>
---<tr>
---  <td><code>MMM</code></td>
---  <td><code>Jan</code>, <code>Feb</code>, &hellip;, <code>Nov</code>, <code>Dec</code></td>
---</tr>
---<tr>
---  <td><code>MMMM</code></td>
---  <td><code>January</code>, <code>February</code>, &hellip;, <code>November</code>, <code>December</code></td>
---</tr>
---</tbody>
---  <thead>
---  <tr>
---    <th colspan=2>Day of Month</th>
---  </tr>
---</thead>
---<tbody>
---<tr>
---  <td><code>D</code></td>
---  <td><code>1</code>, <code>2</code>, &hellip;, <code>30</code>, <code>31</code></td>
---</tr>
---<tr>
---  <td><code>DD</code></td>
---  <td><code>01</code>, <code>02</code>, &hellip;, <code>30</code>, <code>31</code></td>
---</tr>
---</tbody>
---  <thead>
---  <tr>
---    <th colspan=2>Day of Year</th>
---  </tr>
---</thead>
---<tbody>
---<tr>
---  <td><code>DDD</code></td>
---  <td><code>1</code>, <code>2</code>, &hellip;, <code>364</code>, <code>365</code></td>
---</tr>
---<tr>
---  <td><code>DDDD</code></td>
---  <td><code>001</code>, <code>002</code>, &hellip;, <code>364</code>, <code>365</code></td>
---</tr>
---</tbody>
---  <thead>
---  <tr>
---    <th colspan=2>Day of Week</th>
---  </tr>
---</thead>
---<tbody>
---<tr>
---  <td><code>d</code></td>
---  <td><code>0</code>, <code>1</code>, &hellip;, <code>5</code>, <code>6</code></td>
---</tr>
---<tr>
---  <td><code>dd</code></td>
---  <td><code>Su</code>, <code>Mo</code>, &hellip;, <code>Fr</code>, <code>Sa</code></td>
---</tr>
---<tr>
---  <td><code>ddd</code></td>
---  <td><code>Sun</code>, <code>Mon</code>, &hellip;, <code>Fri</code>, <code>Sat</code></td>
---</tr>
---<tr>
---  <td><code>dddd</code></td>
---  <td><code>Sunday</code>, <code>Monday</code>, &hellip;, <code>Friday</code>, <code>Saturday</code></td>
---</tr>
---</tbody>
---  <thead>
---  <tr>
---    <th colspan=2>Hour</th>
---  </tr>
---</thead>
---<tbody>
---<tr>
---  <td><code>H</code></td>
---  <td><code>0</code>, <code>1</code>, &hellip;, <code>22</code>, <code>23</code></td>
---</tr>
---<tr>
---  <td><code>HH</code></td>
---  <td><code>00</code>, <code>01</code>, &hellip;, <code>22</code>, <code>23</code></td>
---</tr>
---<tr>
---  <td><code>h</code></td>
---  <td><code>1</code>, <code>2</code>, &hellip;, <code>11</code>, <code>12</code></td>
---</tr>
---<tr>
---  <td><code>hh</code></td>
---  <td><code>01</code>, <code>02</code>, &hellip;, <code>11</code>, <code>12</code></td>
---</tr>
---</tbody>
---  <thead>
---  <tr>
---    <th colspan=2>Minute</th>
---  </tr>
---</thead>
---<tbody>
---<tr>
---  <td><code>m</code></td>
---  <td><code>0</code>, <code>1</code>, &hellip;, <code>58</code>, <code>59</code></td>
---</tr>
---<tr>
---  <td><code>mm</code></td>
---  <td><code>00</code>, <code>01</code>, &hellip;, <code>58</code>, <code>59</code></td>
---</tr>
---</tbody>
---  <thead>
---  <tr>
---    <th colspan=2>Second</th>
---  </tr>
---</thead>
---<tbody>
---<tr>
---  <td><code>s</code></td>
---  <td><code>0</code>, <code>1</code>, &hellip;, <code>58</code>, <code>59</code></td>
---</tr>
---<tr>
---  <td><code>ss</code></td>
---  <td><code>00</code>, <code>01</code>, &hellip;, <code>58</code>, <code>59</code></td>
---</tr>
---</tbody>
---  <thead>
---  <tr>
---    <th colspan=2>Fractional Second</th>
---  </tr>
---</thead>
---<tbody>
---<tr>
---  <td><code>S</code></td>
---  <td><code>0</code>, <code>1</code>, &hellip;, <code>8</code>, <code>9</code></td>
---</tr>
---<tr>
---  <td><code>SS</code></td>
---  <td><code>00</code>, <code>01</code>, &hellip;, <code>98</code>, <code>99</code></td>
---</tr>
---<tr>
---  <td><code>SSS</code></td>
---  <td><code>000</code>, <code>001</code>, &hellip;, <code>998</code>, <code>999</code></td>
---</tr>
---</tbody>
---  <thead>
---  <tr>
---    <th colspan=2>AM/PM</th>
---  </tr>
---</thead>
---<tbody>
---<tr>
---  <td><code>A</code></td>
---  <td><div><code>en-us</code> : <code>AM</code>, <code>PM</code></div>
---        <div><code>zh-cn</code> : <code>凌晨|早上|上午|中午|下午|晚上</code></div></td>
---</tr>
---<tr>
---  <td><code>a</code></td>
---  <td><div><code>en-us</code> : <code>am</code>, <code>pm</code></div>
---        <div><code>zh-cn</code> : <code>凌晨|早上|上午|中午|下午|晚上</code></div></td>
---</tr>
---</tbody>
---</table>
---
DateTime = nil;
---The number of seconds since January 1st, 1970 at 00:00 UTC (the Unix
---epoch). For more information, see
---[Unix timestamp](https://en.wikipedia.org/wiki/Unix_time). Range is
----17,987,443,200&ndash;253,402,300,799, approximately years
---1400&ndash;9999.
---
DateTime.UnixTimestamp = nil;
---The number of milliseconds since January 1st, 1970 at 00:00 UTC (the Unix
---epoch). For more information, see
---[Unix timestamp](https://en.wikipedia.org/wiki/Unix_time). Range is
----17,987,443,200,000 to 253,402,300,799,999, approximately years
---1400&ndash;9999.
---
DateTime.UnixTimestampMillis = nil;
---Returns a new `DateTime` representing the current moment in time.
---@return DateTime
DateTime.now = function() end;
---@param unixTimestampMillis Integer
---Create a new DateTime object from the given [Unix
---timestamp](https://en.wikipedia.org/wiki/Unix_time), or the number of
---**milliseconds** since January 1st, 1970 at 00:00 (UTC).
---@return DateTime
DateTime.fromUnixTimestampMillis = function(unixTimestampMillis) end;
---@param year Integer
---@param month Integer
---@param day Integer
---@param hour Integer
---@param minute Integer
---@param second Integer
---@param millisecond Integer
---Returns a new `DateTime` using the given units from a local time. The
---values accepted are similar to those found in the time value table
---returned by `ToLocalTime`.
---
---- Date units (year, month, day) that produce an invalid date will raise an error. For example, January 32nd or February 29th on a non-leap year.
---- Time units (hour, minute, second, millisecond) that are outside their normal range are valid. For example, 90 minutes will cause the hour to roll over by 1; -10 seconds will cause the minute value to roll back by 1.
---- Non-integer values are rounded down. For example, providing 2.5 hours will be equivalent to providing 2 hours, not 2 hours 30 minutes.
---- Omitted values are assumed to be their lowest value in their normal range, except for year which defaults to 1970.
---@return DateTime
DateTime.fromLocalTime = function(year, month, day, hour, minute, second, millisecond) end;
---@param unixTimestamp Integer
---Returns a new `DateTime` object from the given [Unix
---timestamp](https://en.wikipedia.org/wiki/Unix_time), or the number of
---**seconds** since January 1st, 1970 at 00:00 (UTC).
---@return DateTime
DateTime.fromUnixTimestamp = function(unixTimestamp) end;
---@param isoDate string
---Returns a `DateTime` from an [ISO
---8601](https://en.wikipedia.org/wiki/ISO_8601) date-time string in UTC
---time, such as those returned by `ToIsoDate`. If the string parsing fails,
---the function returns nil.
---
---An example ISO 8601 date-time string would be `2020-01-02T10:30:45Z`,
---which represents January 2nd 2020 at 10:30 AM, 45 seconds.
---@return DateTime
DateTime.fromIsoDate = function(isoDate) end;
---@param year Integer
---@param month Integer
---@param day Integer
---@param hour Integer
---@param minute Integer
---@param second Integer
---@param millisecond Integer
---Returns a new `DateTime` using the given units from a UTC time. The values
---accepted are similar to those found in the time value table returned by
---`ToUniversalTime`.
---
---- Date units (year, month, day) that produce an invalid date will raise an error. For example, January 32nd or February 29th on a non-leap year.
---- Time units (hour, minute, second, millisecond) that are outside their normal range are valid. For example, 90 minutes will cause the hour to roll over by 1; -10 seconds will cause the minute value to roll back by 1.
---- Non-integer values are rounded down. For example, providing 2.5 hours will be equivalent to providing 2 hours, not 2 hours 30 minutes.
---- Omitted values are assumed to be their lowest value in their normal range, except for year which defaults to 1970.
---@return DateTime
DateTime.fromUniversalTime = function(year, month, day, hour, minute, second, millisecond) end;
---@return string
---Formats a date as a [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601)
---date-time string. The value returned by this function could be passed to
---`fromIsoDate` to produce the original DateTime object.
---
---An example ISO 8601 date-time string would be `2020-01-02T10:30:45Z`,
---which represents January 2nd 2020 at 10:30 AM, 45 seconds.
---
DateTime.ToIsoDate = function(self) end;
---@return table
---Converts the value of this `DateTime` object to Universal Coordinated Time
---(UTC). The returned table contains the following keys: `Year`, `Month`,
---`Day`, `Hour`, `Minute`, `Second`, `Millisecond`. For more details, see
---the table in the `DateTime` description. The values within this table
---could be passed to `fromUniversalTime` to produce the original `DateTime`
---object.
---
DateTime.ToUniversalTime = function(self) end;
---@param format string
---@param locale string
---@return string
---Generates a string from the `DateTime` value interpreted as Universal
---Coordinated Time (UTC) and a format string. The format string should
---contain tokens, which will replace to certain date/time values described
---by the `DateTime` object. For details on all the available tokens, see
---`DateTime` Format Strings.
---
---```lua
---local dt = DateTime.now()
----- For en-us, the "LL" token equals "MMM D, YYYY", which gives "June 11, 2020"
---print("The date is " .. dt:FormatUniversalTime("LL", "en-us"))
-----> "The date is June 11, 2020"
---```
---
DateTime.FormatUniversalTime = function(self, format, locale) end;
---@return table
---Converts the value of this `DateTime` object to local time. The returned
---table contains the following keys: `Year`, `Month`, `Day`, `Hour`,
---`Minute`, `Second`, `Millisecond`. For more details, see the table in the
---`DateTime` description. The values within this table could be passed to
---`fromLocalTime` to produce the original `DateTime` object.
---
DateTime.ToLocalTime = function(self) end;
---@param format string
---@param locale string
---@return string
---Generates a string from the `DateTime` value interpreted as **local time**
---and a format string. The format string should contain tokens, which will
---replace to certain date/time values described by the `DateTime` object.
---For details on all the available tokens, see `DateTime` Format Strings.
---
---```lua
---local dt = DateTime.now()
----- For en-us, the "LL" token equals "MMM D, YYYY", which gives "June 11, 2020"
---print("The date is " .. dt:FormatLocalTime("LL", "en-us"))
-----> "The date is June 11, 2020"
---```
---
DateTime.FormatLocalTime = function(self, format, locale) end;
---@class DockWidgetPluginGuiInfo
---@field public InitialEnabled bool
---@field public InitialEnabledShouldOverrideRestore bool
---@field public FloatingXSize int
---@field public FloatingYSize int
---@field public MinWidth int
---@field public MinHeight int
---The `DockWidgetPluginGuiInfo` data type describes details for a
---`DockWidgetPluginGui`. This datatype is used when constructing a `PluginGui`
---via the plugin's `Plugin:CreateDockWidgetPluginGui()` method.
---
DockWidgetPluginGuiInfo = nil;
---The initial enabled state of a `PluginGui` created using this
---`DockWidgetPluginGuiInfo`. If a `PluginGui` with the same ''pluginGuiId''
---has previously been created in an earlier session of Roblox Studio, then
---it will reload that saved enabled state (unless
---`InitialEnabledShouldOverrideRestore` is true).
---
DockWidgetPluginGuiInfo.InitialEnabled = nil;
---If true, the value of `InitialEnabled` will override the previously saved
---enabled state of a `PluginGui` being created with this
---`DockWidgetPluginGuiInfo`. The previously saved enabled state is loaded
---based on the `pluginGuiId` argument of `Plugin/CreateDockWidgetPluginGui`.
---
DockWidgetPluginGuiInfo.InitialEnabledShouldOverrideRestore = nil;
---The initial pixel width of a `PluginGui` created using this
---`DockWidgetPluginGuiInfo`, when the `InitialDockState` is set to `Float`.
---
DockWidgetPluginGuiInfo.FloatingXSize = nil;
---The initial pixel height of a `PluginGui` created using this
---`DockWidgetPluginGuiInfo`, when the `InitialDockState` is set to `Float`.
---
DockWidgetPluginGuiInfo.FloatingYSize = nil;
---The minimum width of a `PluginGui` created using this
---`DockWidgetPluginGuiInfo`, in pixels.
---
---Each platform has its own absolute minimum that Roblox will enforce. These
---variations exist to account for the contents of the title bar (which
---varies by platform) when the widget is floating. For example, on a Mac,
---the width can never be less than ~80 pixels to accommodate the
---close/minimize/maximize buttons.
---
DockWidgetPluginGuiInfo.MinWidth = nil;
---The minimum height of a `PluginGui` created using this
---`DockWidgetPluginGuiInfo`, in pixels.
---
DockWidgetPluginGuiInfo.MinHeight = nil;
---@param initDockState Enum.InitialDockState
---@param initEnabled bool
---@param overrideEnabledRestore bool
---@param floatXSize int
---@param floatYSize int
---@param minWidth int
---@param minHeight int
---The main constructor function for the `DockWidgetPluginGuiInfo`.
---@return DockWidgetPluginGuiInfo
DockWidgetPluginGuiInfo.new = function(initDockState, initEnabled, overrideEnabledRestore, floatXSize, floatYSize, minWidth, minHeight) end;
---@class Enum
---The `Enum` data type represents an individual enum in Roblox. An individual
---enum can be indexed through the `Enum` type, via the name of the enum itself.
---All available enums on Roblox are listed on the
---[`Enum` page](/reference/engine/enums).
---
Enum = nil;
---@return Array
---Returns an array of all the `datatype/EnumItem` options available for this
---enum.
---
Enum.GetEnumItems = function(self) end;
---@class EnumItem
---@field public Name string
---@field public Value int
---@field public EnumType Enum
---The `EnumItem` datatype represents an individual item in a Roblox enum.
---
EnumItem = nil;
---The name of the EnumItem.
---
EnumItem.Name = nil;
---The integral value assigned to the EnumItem.
---
EnumItem.Value = nil;
---A reference to the parent `datatype/Enum` of the EnumItem.
---
EnumItem.EnumType = nil;
---@class Enums
---The `Enums` data type, more commonly known as `Enum` by its global variable in
---Lua), acts as the root access point for all available enums on Roblox. All
---enums on Roblox are indexed via their name through this datatype, and
---developers can also utilize the `GetEnums()` method to get a list of all enums
---on Roblox.
---
Enums = nil;
---@return Array
---Returns an array containing all available `datatype/Enum`s on Roblox.
---
Enums.GetEnums = function(self) end;
---@class Faces
---@field public Top bool
---@field public Bottom bool
---@field public Left bool
---@field public Right bool
---@field public Back bool
---@field public Front bool
---The `Faces` data type contains six booleans representing whether a feature is
---enabled for each face (`enum/NormalId`) of a Part. In other words, this
---contains a boolean for each axes (X/Y/Z) in both directions
---(positive/negative). The `Handles` object uses this data type to enable
---whether a direction has a visible handle on a Part's face.
---
---```lua
---local handles = Instance.new("Handles")
---handles.Faces = Faces.new(Enum.NormalId.Front, Enum.NormalId.Left)
---```
---
---Like most data types on Roblox, the Faces data type is immutable: you cannot
---assign to its properties once created.
---
Faces = nil;
---Whether the top face is included.
---
Faces.Top = nil;
---Whether the bottom face is included.
---
Faces.Bottom = nil;
---Whether the left face is included.
---
Faces.Left = nil;
---Whether the right face is included.
---
Faces.Right = nil;
---Whether the back face is included.
---
Faces.Back = nil;
---Whether the front face is included.
---
Faces.Front = nil;
---@vararg Tuple
---Creates a new Faces given some number of `enum/NormalId` as arguments. Each NormalId provided indicates the property of the same name in the new Faces will be true.
---
---- The `table.unpack` function can be used to unpack a table of NormalId to be included.
---- Passing values that are not a `enum/NormalId` will do nothing; they are ignored silently.
---@return Faces
Faces.new = function(...) end;
---@class FloatCurveKey
---@field public Interpolation KeyInterpolationMode
---@field public Time number
---@field public Value number
---@field public RightTangent number
---@field public LeftTangent number
---A time-value pair used with `FloatCurve` instances.
---
---The `Interpolation` property dictates the interpolation mode for the segment
---started by this key and ended by the next key on the curve. Each segment may
---use a different interpolation mode.
---
---The `LeftTangent` and `RightTangent` properties apply to the cubic
---interpolation mode and define the desired tangent (slope) at the key.
---Different left and right values can be used to encode discontinuities in slope
---at the key. Attempting to set a `RightTangent` value on a key that doesn't use
---the cubic interpolation mode will result in a runtime error. It is possible to
---set the `LeftTangent` property on any key, as it will be used should the
---preceding segment use cubic interpolation.
---
FloatCurveKey = nil;
---Defines this key interpolation mode for the segment started by this key.
---
FloatCurveKey.Interpolation = nil;
---The time position of this key.
---
FloatCurveKey.Time = nil;
---The value of this key.
---
FloatCurveKey.Value = nil;
---The tangent to the right of this key.
---
FloatCurveKey.RightTangent = nil;
---The tangent to the left of this key.
---
FloatCurveKey.LeftTangent = nil;
---@param time number
---@param value number
---@param Interpolation Enum.KeyInterpolationMode
---Creates a new `FloatCurveKey` at a given time and value. `LeftTangent` and
---RightTangent are left uninitialized. If not initialized, tangent values of
---0 will be used when evaluating the curve.
---@return FloatCurveKey
FloatCurveKey.new = function(time, value, Interpolation) end;
---@class Instance
---The `Instance` data type holds the constructor for `Instance` objects.
---
Instance = nil;
---@generic CLASSNAMEGENERIC : string
---@param className `CLASSNAMEGENERIC`
---@param parent? Instance
---Creates an new object of type val. The parent argument is optional; If it
---is supplied, the object will be parented to that object.
---
---**Performance note:** When the `Instance/Parent|Parent` of an object is
---set, Luau listens to a variety of different property changes
---for replication, rendering and physics. Therefore, it is recommended to
---**set the Parent property last** when creating new objects. As such, you
---should avoid using the second argument (`parent`) of this function. You
---can read [this thread on the developer
---forum](https://devforum.roblox.com/t/psa-dont-use-instance-new-with-parent-argument/30296)
---for more information.
---@return CLASSNAMEGENERIC
Instance.new = function(className, parent) end;
---@class NumberRange
---@field public Min number
---@field public Max number
---The `NumberRange` represents a range of numbers.
---
NumberRange = nil;
---The minimum value of the `NumberRange`. It's always less than or equal to
---the maximum.
---
NumberRange.Min = nil;
---The maximum value of the `NumberRange`. It's always greater than or equal
---to the minimum.
---
NumberRange.Max = nil;
---@overload fun(minimum: number, maximum: number)
---@param value number
---Returns a new `NumberRange` with the minimum and maximum set to the
---`value`.
---@return NumberRange
NumberRange.new = function(value) end;
---@class NumberSequence
---@field public Keypoints Array<NumberSequenceKeypoint>
---The `NumberSequence` data type represents a series of number values from `0`
---to `1`. The number values are expressed using the
---`datatype/NumberSequenceKeypoint` type. This type is used in properties of
---`ParticleEmitter` to indicate properties of particles over their lifetime. In
---Studio, this data type is edited using a line graph:
---
---![A NumberSequence for a ParticleEmitter's Transparency][1]
---
---The above line graph can be set using a script using the following call to
---`NumberSequence.new`:
---
---```lua
---particleEmitter.Transparency = NumberSequence.new{
---    NumberSequenceKeypoint.new(0, 0), -- (time, value)
---    NumberSequenceKeypoint.new(.5, .75),
---    NumberSequenceKeypoint.new(1, 1)
---}
---```
---
---## Equality
---
---Two `NumberSequence` objects are equivalent if and only if the values of their
---`datatype/NumberSequenceKeypoint` are equivalent, even if the two
---`NumberSequence` would result in similar graphs.
---
---## Evaluation
---
---The `NumberSequence` type does not have a built-in method for getting the
---value at a certain time/point because keypoints can have random envelopes.
---Assuming the envelope values of your keypoints are all 0, you can use the
---following function to evaluate at a specific time:
---
---```lua
---function evalNS(ns, time)
---	-- If we are at 0 or 1, return the first or last value respectively
---	if time == 0 then return ns.Keypoints[1].Value end
---	if time == 1 then return ns.Keypoints[#ns.Keypoints].Value end
---	-- Step through each sequential pair of keypoints and see if alpha
---	-- lies between the points' time values.
---	for i = 1, #ns.Keypoints - 1 do
---		local this = ns.Keypoints[i]
---		local next = ns.Keypoints[i + 1]
---		if time >= this.Time and time < next.Time then
---			-- Calculate how far alpha lies between the points
---			local alpha = (time - this.Time) / (next.Time - this.Time)
---			-- Evaluate the real value between the points using alpha
---			return (next.Value - this.Value) * alpha + this.Value
---		end
---	end
---end
---```
---
---You can use the function above like this:
---
---```lua
---local ns = NumberSequence.new{
---	NumberSequenceKeypoint.new(0, 0),
---	NumberSequenceKeypoint.new(.5, .8),
---	NumberSequenceKeypoint.new(1, 1),
---}
---
---print(evalNS(ns, 0))   --> 0
---print(evalNS(ns, .25)) --> .4
---print(evalNS(ns, .5))  --> .8
---print(evalNS(ns, .75)) --> .9
---print(evalNS(ns, 1))   --> 1
---```
---
---[1]: /assets/blt0d60ed8c7e23650a/ParticleEmitter.Transparency.jpg
---
NumberSequence = nil;
---An array of keypoints for the `NumberSequence`.
---
NumberSequence.Keypoints = nil;
---@overload fun(n0: number, n1: number)
---@overload fun(Keypoints: table)
---@param n number
---Returns a `NumberSequence` with the start and end values set to the
---provided `n`.
---
---```lua
---local ns = NumberSequence.new(n)
----- is equivalent to
---local ns = NumberSequence.new{
---	NumberSequenceKeypoint.new(0, n),
---	NumberSequenceKeypoint.new(1, n),
---}
---```
---@return NumberSequence
NumberSequence.new = function(n) end;
---@class NumberSequenceKeypoint
---@field public Envelope number
---@field public Time number
---@field public Value number
---The `NumberSequenceKeypoint` data type represents keypoints within a
---NumberSequence with a particular time, value, and envelope size.
---
NumberSequenceKeypoint = nil;
---The amount of variance allowed from the value. A computed value.
---
NumberSequenceKeypoint.Envelope = nil;
---The relative time at which the keypoint is positioned.
---
NumberSequenceKeypoint.Time = nil;
---The base value of this keypoint.
---
NumberSequenceKeypoint.Value = nil;
---@overload fun(time: number, value: number, envelop: number)
---@param time number
---@param value number
---Returns a keypoint with a specified time and value.
---@return NumberSequenceKeypoint
NumberSequenceKeypoint.new = function(time, value) end;
---@class OverlapParams
---@field public FilterDescendantsInstances Array
---@field public FilterType RaycastFilterType
---@field public MaxParts number
---@field public CollisionGroup string
---The `OverlapParams` data type stores parameters for use with `WorldRoot`
---boundary-querying functions, in particular
---`WorldRoot/GetPartBoundsInBox|GetPartBoundsInBox`,
---`WorldRoot/GetPartBoundsInRadius|GetPartBoundsInRadius` and
---`WorldRoot/GetPartsInPart|GetPartsInPart`. The `FilterDescendantsInstances`
---property stores an array of objects to use as either a whitelist or blacklist
---based on the `FilterType` enum. The `CollisionGroup` property can specify a
---collision group for the boundary query operation.
---
---This data type performs a similar role as the `datatype/RaycastParams` type.
---
---Unlike most datatypes in Luau, all the members of `OverlapParams` can be
---changed without creating a new object. When performing boundary queries
---repeatedly, you should use the same object.
---
OverlapParams = nil;
---An array of objects whose descendants is used in filtering candidates.
---
OverlapParams.FilterDescendantsInstances = nil;
---Determines how the `FilterDescendantsInstances` list is used, depending on
---the `enum/RaycastFilterType` provided.
---
---- `Enum.RaycastFilterType.Whitelist` &mdash; Only `BasePart|BaseParts`
---  which are descendants of objects in the filter list is considered.
---- `Enum.RaycastFilterType.Blacklist` &mdash; Every `BasePart` in the game
---  is considered **except** those that are descendants of objects in the
---  filter list.
---
OverlapParams.FilterType = nil;
---The maximum amount of parts to be returned by the query. The default value
---of zero (`0`) represents no limit.
---
OverlapParams.MaxParts = nil;
---Specifies a collision group for the operation. Parts in collision groups
---that are set to **not** collide with this group is ignored. If this
---property is omitted, the operation assumes the **Default** collision
---group.
---
OverlapParams.CollisionGroup = nil;
---Returns a blank `datatype/OverlapParams` object. Unlike other datatype
---constructors, this constructor does not have any parameters, so you should
---set its properties appropriately.
---@return OverlapParams
OverlapParams.new = function() end;
---@class PathWaypoint
---@field public Action Enum.PathWaypointAction
---@field public Position Vector3
---@field public Label string
---The `PathWaypoint` datatype constructed by a `Enum/PathWaypointAction` action,
---`DataType/Vector3` position, and `string` label which is used by the
---`PathfindingService` to create points along a generated path.
---
---The code block below constructs a `PathWaypoint` variable with
---`Vector2.new(10, 10, 10)` as its position, `Enum.PathWaypointAction.Walk` as
---its action, and `Custom Label` as its label:
---
---```lua
---local pos = Vector3.new(10, 10, 10)
---local waypoint = PathWaypoint.new(pos, Enum.PathWaypointAction.Walk, "Custom Label")
---```
---
---PathWaypoint can also be constructed by passing position and action. Label
---property will be set to default as empty string.
---
---```lua
---local pos = Vector3.new(10, 10, 10)
---local waypoint = PathWaypoint.new(pos, Enum.PathWaypointAction.Walk)
---```
---
---## Action
---
---The `Enum/PathWaypointAction|Action` describes the action to take in order to
---reach this PathWaypoint. It can be set to one of the following enum values:
---
---<table>
---	<thead>
---		<tr>
---			<th>Name</th>
---			<th>Value</th>
---			<th>Description</th>
---		</tr>
---	</thead>
---	<tbody>
---		<tr>
---			<td>
---				Walk
---			</td>
---			<td>0</td>
---			<td>
---				Walk action needed to reach this waypoint from the previous one.
---			</td>
---		</tr>
---		<tr>
---			<td>
---				Jump
---			</td>
---			<td>1</td>
---			<td>
---				Jump action needed to reach this waypoint from the previous one.
---			</td>
---		</tr>
---	</tbody>
---</table>
---
PathWaypoint = nil;
---The action to be performed at this waypoint.
---
PathWaypoint.Action = nil;
---The 3D position of the waypoint.
---
PathWaypoint.Position = nil;
---The name of the navigation area that generates this waypoint. You can use
---PathwayPoint.Label to decide the custom action to take to reach the
---waypoint. PathfindingModifier and Material each have a Label. Automatic
---jump links have "Jump" as their Label.
---
PathWaypoint.Label = nil;
---@param position Vector3
---@param action Enum.PathWaypointAction
---@param PathWaypointLabel string
---Returns a `PathWaypoint` object from the given `Vector3` position, `Enum.PathWaypointAction` action, and optional string label.
---@return PathWaypoint
PathWaypoint.new = function(position, action, PathWaypointLabel) end;
---@class PhysicalProperties
---@field public Density number
---@field public Friction number
---@field public Elasticity number
---@field public FrictionWeight number
---@field public ElasticityWeight number
---The `PhysicalProperties` data type describes several physical properties of a
---part: `Density`, `Elasticity`, and `Friction`. It is used in the
---similarly-named `BasePart/CustomPhysicalProperties` property.
---
---## Weighting Behavior
---
---`PhysicalProperties` also provides weightings properties, `ElasticityWeight`
---and `FrictionWeight`. When two parts interact, the `Friction` and `Elasticity`
---between them are determined in the same way by the following pairwise weighted
---average function:
---
---![(Friction_a * FrictionWeight_a + Friction_b * FrictionWeight_b) / (FrictionWeight_a + FrictionWeight_b)][1]
---
---Although the formula above refers to the Friction and FrictionWeight of two
---parts, `A` and `B`, the formula is used in the same manner when determining
---`Elasticity`. Generally, when the weight of `A` is much greater than that of
---`B`, the actual value will be closer to `A`. If the weights are similar, then
---the actual value will be close to the midpoint between their individual
---values.
---
---## History
---
---`PhysicalProperties` was released in
---[November 2015](https://blog.roblox.com/2015/11/announcing-new-physical-material-properties/).
---Previously, `BasePart` had individual `Friction` and `Elasticity` properties.
---This was changed so that all physical properties of a part will replicate as
---one, among other reasons. Its release was done over the course of three
---months.
---
---[1]: /assets/bltf1f11533d788f341/FrictionWeight.png
---
PhysicalProperties = nil;
---The density set for the custom physical properties. Density is defined as
---the amount of mass per unit volume. The more dense a part is, the more
---force it takes to accelerate it.
---
PhysicalProperties.Density = nil;
---The friction set for the custom physical properties. Friction is defined
---as the force that opposes the relative lateral motion of two solid
---surfaces in contact. The greater the friction on a part, the quicker it
---will decelerate when it rubs against another part with friction.
---
PhysicalProperties.Friction = nil;
---The elasticity set for the custom physical properties. On Roblox,
---`Elasticity` refers to a part's tendency to retain energy when colliding
---with another part. An `Elasticity` of `1` indicates that the part bounces
---with the same energy it had before a collision.
---
PhysicalProperties.Elasticity = nil;
---The friction weight set for the custom physical properties. The
---`FrictionWeight` of two parts rubbing together creates a ratio used to
---calculate the actual friction between the two parts: the higher a part's
---`FrictionWeight` is, the more its `Friction` is used.
---
PhysicalProperties.FrictionWeight = nil;
---The elasticity weight set for the custom physical properties. The
---`ElasticityWeight` of two parts colliding creates a ratio used to
---calculate the actual elasticity between the two parts: the higher a part's
---`ElasticityWeight` is, the more its `Elasticity` is used.
---
PhysicalProperties.ElasticityWeight = nil;
---@overload fun(density: number, friction: number, elasticity: number)
---@overload fun(density: number, friction: number, elasticity: number, frictionWeight: number, elasticityWeight: number)
---@param material Enum.Material
---Returns a `PhysicalProperties` container, with the density, friction, and elasticity specified for this Material.
---@return PhysicalProperties
PhysicalProperties.new = function(material) end;
---@class RBXScriptConnection
---@field public Connected bool
---The `RBXScriptConnection` data type, also known as a Connection, is a special
---object returned by the Connect method of an Event
---(`DataType/RBXScriptSignal`). This is used primarily to disconnect a listener
---from an `DataType/RBXScriptSignal`. For more information about events, see
---[Events](/scripting/events/index).
---
RBXScriptConnection = nil;
---Describes whether or not the connection is still alive. This becomes false
---if `connection:Disconnect()` is called.
---
RBXScriptConnection.Connected = nil;
---@return void
---Disconnects the connection from the event.
---
RBXScriptConnection.Disconnect = function(self) end;
---@class RBXScriptSignal
---The `RBXScriptSignal` data type, more commonly known as an **Event**, provides
---a way for user-defined functions, called **listeners**, to call when something
---happens in the game. When an event happens, the `RBXScriptSignal` fires and
---calls any listeners that are connected to it. An `RBXScriptSignal` may also
---pass arguments to each listener to provide extra information about the event.
---For more information about events, see [Events](/scripting/events/index).
---
RBXScriptSignal = nil;
---@param func function
---@return RBXScriptConnection
---Establishes a function to be called when the event fires. Returns a
---`DataType/RBXScriptConnection` object associated with the connection.
---
RBXScriptSignal.Connect = function(self, func) end;
---@return Variant
---Yields the current thread until the signal fires and returns the arguments
---provided by the signal.
---
RBXScriptSignal.Wait = function(self) end;
---@class Random
---The `Random` data type provides pseudorandom numbers.
---
Random = nil;
---@param seed number
---Returns a new `Random` object. If the seed parameter is not specified, it
---will use a seed pulled from an internal entropy source.
---@return Random
Random.new = function(seed) end;
---@param min int
---@param max int
---@return int
---Returns a pseudorandom integer uniformly distributed over `[min, max]`.
---
Random.NextInteger = function(self, min, max) end;
---@return Random
---Returns a new Random object with the same state as the original.
---
Random.Clone = function(self) end;
---@overload fun(self, min: number, max: number): number
---@return number
---Returns a pseudorandom number uniformly distributed over `[0, 1)`.
---
Random.NextNumber = function(self) end;
---@return Vector3
---Returns a unit vector with a pseudorandom direction. Vectors returned from
---this function are uniformly distributed over the unit sphere.
---
Random.NextUnitVector = function(self) end;
---@class Ray
---@field public Unit Ray
---@field public Origin Vector3
---@field public Direction Vector3
---The `Ray` data type represents a half-line, finite in one direction but
---infinite in the other. It can be defined by a 3D point, where the line
---originates from, and a direction vector, which is the direction it goes in.
---
Ray = nil;
---The `Ray` with a normalized direction (the direction has a magnitude of
---`1`).
---
Ray.Unit = nil;
---The position of the origin.
---
Ray.Origin = nil;
---The direction vector of the `Ray`.
---
Ray.Direction = nil;
---@param Origin Vector3
---@param Direction Vector3
---Returns a new `Ray` with given `Origin` and `Direction`.
---@return Ray
Ray.new = function(Origin, Direction) end;
---@param point Vector3
---@return number
---Returns the distance between the given point and the point on the ray
---nearest to the given point (`Ray:ClosestPoint(point)`).
---
Ray.Distance = function(self, point) end;
---@param point Vector3
---@return Vector3
---Returns a `Vector3` projected onto the ray so that it is within the
---`Ray`'s line of sight.
---
---**Note:** the `Ray` **must** be a unit ray for this method to behave as
---expected!
---
Ray.ClosestPoint = function(self, point) end;
---@class RaycastParams
---@field public FilterDescendantsInstances Array
---@field public FilterType RaycastFilterType
---@field public IgnoreWater bool
---@field public CollisionGroup string
---The `RaycastParams` data type stores parameters for
---`WorldRoot/Raycast|WorldRoot:Raycast()` operations. The
---`FilterDescendantsInstances` property stores an array of objects to use as
---either a whitelist or blacklist based on the `FilterType` enum. If desired,
---the `IgnoreWater` property can be used to ignore `Terrain` water and the
---`CollisionGroup` property can specify a collision group for the raycasting
---operation.
---
---This object is different from the similarly-named `datatype/RaycastResult`
---which provides the results of a raycast.
---
---Unlike most datatypes on Roblox, you can change all the members of
---`RaycastParams` without creating a new object. When raycasting repeatedly,
---re-use the same object instead of creating new ones.
---
RaycastParams = nil;
---An array of objects whose descendants is used in filtering raycasting
---candidates.
---
RaycastParams.FilterDescendantsInstances = nil;
---Determines how the `FilterDescendantsInstances` list is used, depending on
---the `enum/RaycastFilterType` provided.
---
---- `Enum.RaycastFilterType.Whitelist` &mdash; Only `BasePart|BaseParts`
---  which are descendants of objects in the filter list is considered in the
---  raycast operation.
---- `Enum.RaycastFilterType.Blacklist` &mdash; Every `BasePart` in the game
---  is considered **except** those that are descendants of objects in the
---  filter list.
---
RaycastParams.FilterType = nil;
---Determines whether the water material is considered when raycasting
---against `Terrain`.
---
RaycastParams.IgnoreWater = nil;
---Specifies a collision group for the raycasting operation. Parts in
---collision groups that are set to **not** collide with this group is
---ignored. If this property is omitted, the raycast assumes the **Default**
---collision group.
---
RaycastParams.CollisionGroup = nil;
---Returns a blank `datatype/RaycastParams` object. Unlike other datatype
---constructors, this constructor does not have any parameters, so you should
---set its properties appropriately.
---@return RaycastParams
RaycastParams.new = function() end;
---@class RaycastResult
---@field public Distance number
---@field public Instance Instance
---@field public Material Material
---@field public Position Vector3
---@field public Normal Vector3
---The `RaycastResult` data type stores the result of a successful raycasting
---operation performed by `WorldRoot/Raycast|WorldRoot:Raycast()`. It contains
---the properties listed below.
---
---This object should not be confused with the similarly-named
---`datatype/RaycastParams` which is used to perform a raycast.
---
RaycastResult = nil;
---The distance between the ray origin and the intersection point.
---
RaycastResult.Distance = nil;
---The `BasePart` or `Terrain` cell that the ray intersected.
---
RaycastResult.Instance = nil;
---The `enum/Material` at the intersection point. For normal parts this is
---the `BasePart/Material`; for `Terrain` this can vary depending on terrain
---data.
---
RaycastResult.Material = nil;
---The world space point at which the intersection occurred, usually a point
---directly on the surface of the instance.
---
RaycastResult.Position = nil;
---The normal vector of the intersected face.
---
RaycastResult.Normal = nil;
---@class Rect
---@field public Width number
---@field public Height number
---@field public Min Vector2
---@field public Max Vector2
---The `Rect` describes a rectangle on a 2D plane. It is constructed using two of
---its corners, either using two `datatype/Vector2` form or as four numbers:
---
---```lua
---Rect.new(Vector2.new(1, 2), Vector2.new(3, 4))
---Rect.new(1, 2, 3, 4)
---```
---
---The Rect data type is used in the `ImageLabel/SliceCenter` property, which
---determines the center area of a scaled image.
---
Rect = nil;
---The width of the Rect in pixels.
---
Rect.Width = nil;
---The height of the Rect in pixels.
---
Rect.Height = nil;
---The top-left corner.
---
Rect.Min = nil;
---The bottom-right corner.
---
Rect.Max = nil;
---@overload fun(min: Vector2, max: Vector2)
---@overload fun(minX: number, minY: number, maxX: number, maxY: number)
---Constructs a new Rect given two zero `datatype/Vector2`: `min` as top left corner and `max` as bottom right corner.
---@return Rect
Rect.new = function() end;
---@class Region3
---@field public CFrame CFrame
---@field public Size Vector3
---The `Region3` data type describes a volume in 3D space similar to an
---**axis-aligned rectangular prism**. It is commonly used with `Terrain`
---functions and functions that detect parts within a volume, such as
---`Workspace/FindPartsInRegion3`.
---
---- The prism's center can be accessed using the `datatype/CFrame` **CFrame**
---  property.
---- The prism's size is available in the `datatype/Vector3` **Size** property.
---  Note that the components of this property may be **negative**!
---
---When converted to a string, the output format is `CFrame; Size` where each of
---these is the respective property also converted to a string.
---
---The only operation that can be done on a `Region3` is
---`Region3.ExpandToGrid(resolution)`, which returns a new `Region3` whose bounds
---comply with a provided resolution value. The resulting volume may be equal to
---or greater than the original volume, but never smaller.
---
---See also:
---
---- `datatype/Region3int16`, a similar data type
---
Region3 = nil;
---The center location and rotation of the `Region3`.
---
Region3.CFrame = nil;
---The 3D size of the `Region3`.
---
Region3.Size = nil;
---@param min Vector3
---@param max Vector3
---Returns a new `Region3` given the `datatype/Vector3` bounds of a the
---rectangular prism volume.
---
---Note that the order of the provided bounds matters: by switching them, the
---polarity of the Size components will switch. It is possible to create a
---`Region3` with a **negative volume**.
---@return Region3
Region3.new = function(min, max) end;
---@param resolution int
---@return Region3
---Expands the `Region3` so that it is aligned with a voxel grid based on the
---provided resolution and returns the expanded `Region3`.
---
---All you need to do is perform the method on the Region3 you have defined,
---providing a resolution. Then, the function will align the region so that
---it is compatible with the `Terrain` grid.
---
Region3.ExpandToGrid = function(self, resolution) end;
---@class Region3int16
---@field public Min Vector3int16
---@field public Max Vector3int16
---Not to be confused with `datatype/Region3`, a separate class that fulfills a
---different purpose.
---
---The `Region3int16` data type represents a volume in 3D space similar to an
---**axis-aligned rectangular prism**. It uses two `datatype/Vector3int16` to
---store the volume's bounds in the `Min` and `Max` properties. It is constructed
---using `Region3int16.new(Min, Max)`, given the two `Vector3int16` bounds. This
---data type features no functions or operations.
---
---## Calculating Center and Size
---
---This data type differs from `datatype/Region3` in that it stores its bounds
---directly, rather than through a center and size combination. Nonetheless, it
---is possible to calculate these dimensions using `Min` and `Max`:
---
---```lua
---local region = Region3int16.new(Vector3int16.new(0, 0, -3), Vector3int16.new(4, 4, 4))
---local size = region.Max - region.Min
---local center = (region.Max + region.Min) / 2
---```
---
---## Conversion to Region3
---
---The following function can be used to convert a Region3int16 into a similar
---`Region3`. It does this by converting the `Min` and `Max` properties, which
---are Vector3int16, into `datatype/Vector3` used with `Region3.new`.
---
---```lua
---local function Region3int16toRegion3(region16)
---	return Region3.new(
---		Vector3.new(region16.Min.X, region16.Min.Y, region16.Min.Z),
---		Vector3.new(region16.Max.X, region16.Max.Y, region16.Max.Z)
---	)
---end
---```
---
---See also:
---
---- `datatype/Region3`, a similar data type
---
Region3int16 = nil;
---The lower bound of the `Region3int16`, as passed to `Region3int16.new`.
---
Region3int16.Min = nil;
---The upper bound of the `Region3int16`, as passed to `Region3int16.new`.
---
Region3int16.Max = nil;
---@param min Vector3int16
---@param max Vector3int16
---Returns a new Region3int16 from the provided boundaries.
---@return Region3int16
Region3int16.new = function(min, max) end;
---@class TweenInfo
---@field public EasingDirection Enum.EasingDirection
---@field public Time number
---@field public DelayTime number
---@field public RepeatCount number
---@field public EasingStyle Enum.EasingStyle
---@field public Reverses bool
---The `TweenInfo` data type stores parameters for
---`TweenService/Create|TweenService:Create()` to specify the behavior of the
---tween. The properties of a `TweenInfo` cannot be written to after its
---creation.
---
TweenInfo = nil;
---The direction in which the EasingStyle executes.
---
TweenInfo.EasingDirection = nil;
---The amount of time the tween takes in seconds.
---
TweenInfo.Time = nil;
---The amount of time that elapses before tween starts in seconds.
---
TweenInfo.DelayTime = nil;
---The number of times the tween repeats after tweening once.
---
TweenInfo.RepeatCount = nil;
---The style in which the tween executes.
---
TweenInfo.EasingStyle = nil;
---Whether or not the tween does the reverse tween once the initial tween
---completes.
---
TweenInfo.Reverses = nil;
---@param time number
---@param easingStyle Enum.EasingStyle
---@param easingDirection Enum.EasingDirection
---@param repeatCount number
---@param reverses bool
---@param delayTime number
---Creates a new `TweenInfo` from the provided parameters.
---@return TweenInfo
TweenInfo.new = function(time, easingStyle, easingDirection, repeatCount, reverses, delayTime) end;
---@class UDim
---@field public Scale number
---@field public Offset int
---The `UDim` data type represents a one-dimensional value with two components, a
---relative scale and an absolute offset.
---
UDim = nil;
---The scale component of the `UDim`. The value this represents is scaled
---relative to the axis that this `UDim` is representing in a `UDim2`.
---
UDim.Scale = nil;
---The pixel unit component of the `UDim`.
---
UDim.Offset = nil;
---@param Scale number
---@param Offset number
---Returns a `UDim` from the given components.
---@return UDim
UDim.new = function(Scale, Offset) end;
---@class UDim2
---@field public X UDim
---@field public Y UDim
---@field public Width UDim
---@field public Height UDim
---The `UDim2` data type represents a two-dimensional value where each dimension
---is composed of a relative scale and an absolute offset. for a coordinate used
---in building user interfaces. It is a combination of two `UDim` representing
---the x and y dimensions. The most common usages of `UDim2` objects are setting
---the `GuiObject/Size|Size` and `GuiObject/Position|Position` of `GuiObject`s.
---
---```lua
---local guiObject = script.Parent
---guiObject.Size = UDim2.new(0, 300, 1, 0) -- 300 px wide, full height of parent
---guiObject.Position = UDim2.new(0, 50, 0, 0) -- 50 px from the left
---```
---
UDim2 = nil;
---The x dimension scale and offset of the `UDim2`.
---
UDim2.X = nil;
---The y dimension scale and offset of the `UDim2`.
---
UDim2.Y = nil;
---The x dimension scale and offset of the `UDim2`.
---
UDim2.Width = nil;
---The y dimension scale and offset of the `UDim2`.
---
UDim2.Height = nil;
---@param xOffset number
---@param yOffset number
---Returns a new `UDim2` with the given offset coordinates and no scales.
---Equivalent to:
---
---```lua
---UDim2.fromOffset(xOffset, yOffset) == UDim2.new(0, xOffset, 0, yOffset)
---```
---@return UDim2
UDim2.fromOffset = function(xOffset, yOffset) end;
---@overload fun(xScale: number, xOffset: number, yScale: number, yOffset: number)
---@overload fun(x: UDim, y: UDim)
---Returns a new `UDim2` with the coordinates of the two zero `UDim`
---representing each axis.
---@return UDim2
UDim2.new = function() end;
---@param xScale number
---@param yScale number
---Returns a new `UDim2` with the given scalar coordinates and no offsets.
---Equivalent to:
---
---```lua
---UDim2.fromScale(xScale, yScale) == UDim2.new(xScale, 0, yScale, 0)
---```
---@return UDim2
UDim2.fromScale = function(xScale, yScale) end;
---@param goal UDim2
---@param alpha number
---@return UDim2
---Returns a `UDim2` interpolated linearly between this `UDim2` and the given
---`goal`. The `alpha` value should be a number between 0 and 1.
---
UDim2.Lerp = function(self, goal, alpha) end;
---@class Vector2
---@field public zero Vector2
---@field public one Vector2
---@field public xAxis Vector2
---@field public yAxis Vector2
---@field public X number
---@field public Y number
---@field public Magnitude number
---@field public Unit Vector2
---The `Vector2` data type represents a 2D value with direction and magnitude.
---Some applications include GUI elements and 2D mouse positions.
---
Vector2 = nil;
---A `Vector2` with a magnitude of zero.
---
---This API member is a **constant**, and must be accessed through the
---`Vector2` global as opposed to an individual `Vector2` object.
---
---```lua
---print(Vector2.zero) --> 0, 0
---```
---
Vector2.zero = nil;
---A `Vector2` with a value of 1 on every axis.
---
---This API member is a **constant**, and must be accessed through the
---`Vector2` global as opposed to an individual `Vector2` object.
---
---```lua
---print(Vector2.one) --> 1, 1
---```
---
Vector2.one = nil;
---A `Vector2` with a value of 1 on the x axis.
---
---This API member is a **constant**, and must be accessed through the
---`Vector2` global as opposed to an individual `Vector2` object.
---
---```lua
---print(Vector2.xAxis) --> 1, 0
---```
---
Vector2.xAxis = nil;
---A `Vector2` with a value of 1 on the y-axis.
---
---This API member is a **constant**, and must be accessed through the
---`Vector2` global as opposed to an individual `Vector2` object.
---
---```lua
---print(Vector2.yAxis) --> 0, 1
---```
---
Vector2.yAxis = nil;
---The x-coordinate of the `Vector2`.
---
Vector2.X = nil;
---The y-coordinate of the `Vector2`.
---
Vector2.Y = nil;
---The length of the `Vector2`.
---
Vector2.Magnitude = nil;
---A normalized copy of the `Vector2`.
---
Vector2.Unit = nil;
---@param x number
---@param y number
---Returns a `Vector2` from the given x and y components.
---@return Vector2
Vector2.new = function(x, y) end;
---@param v Vector2
---@param alpha number
---@return Vector2
---Returns a `Vector2` linearly interpolated between this `Vector2` and the
---given goal by the given alpha.
---
Vector2.Lerp = function(self, v, alpha) end;
---@param other Vector2
---@return number
---Returns the cross product of the two vectors.
---
Vector2.Cross = function(self, other) end;
---@vararg Tuple
---@return Vector2
---Returns a `Vector2` with each component as the lowest among the respective
---components of the provided `Vector2` objects.
---
---```lua
---local a = Vector2.new(1, 2)
---local b = Vector2.new(2, 1)
---
---print(a:Min(b)) -- Vector2.new(1, 1)
---```
---
Vector2.Min = function(self, ...) end;
---@param v Vector2
---@return number
---Returns a scalar dot product of the two vectors.
---
Vector2.Dot = function(self, v) end;
---@vararg Tuple
---@return Vector2
---Returns a `Vector2` with each component as the highest among the
---respective components of the provided `Vector2` objects.
---
---```lua
---local a = Vector2.new(1, 2)
---local b = Vector2.new(2, 1)
---
---print(a:Max(b)) -- Vector2.new(2, 2)
---```
---
Vector2.Max = function(self, ...) end;
---@class Vector2int16
---@field public X integer
---@field public Y integer
---Not to be confused with:
---
---- `datatype/Vector2`, a **more precise** and complete implementation for 2D
---  vectors.
---- `datatype/Vector3int16`, a similar implementation for 3D vectors.
---
---The `Vector2int16` data type represents a vector in 2D space with a **signed
---16-bit integer** for its components. It is similar to `datatype/Vector2` in
---that it allows for the same arithmetic operations; however it lacks commonly
---used vector functions.
---
---For each component:
---
---- The **lower** bound is -2<sup>15</sup>, or **-32,768**.
---- The **upper** bound is 2<sup>15</sup> &minus; 1, or **32,767**.
---
---## Converting to Vector2
---
---To convert a `Vector2int16` to a `Vector2`, construct a `Vector2`
---component-wise by passing the components of the `Vector2int16` to
---`Vector2.new()`:
---
---```lua
---local function ConvertVector2int16ToVector2(vector16)
---	return Vector2.new(vector16.X, vector16.Y)
---end
---```
---
---**Don't pass a `Vector2int16` to `Vector2.new()`:** The `Vector2.new()`
---constructor interprets a `Vector2int16` as a 0 (zero) within its parameters
---**without producing an error**. This can lead to silent logic errors if you do
---something like this:
---
---```lua
---Vector2.new(Vector2int16.new(1, 2, 3)) --> Vector2.new(0, 0, 0)
---```
---
Vector2int16 = nil;
---The x-coordinate of the `Vector2int16`, also accessible in its lower-case
---variant.
---
Vector2int16.X = nil;
---The y-coordinate of the `Vector2int16`, also accessible in its lower-case
---variant.
---
Vector2int16.Y = nil;
---@param x number
---@param y number
---Returns a new `Vector2int16` given the x and y components. Non-integer
---components are rounded down.
---
---The components must fall within the range [-2<sup>15</sup>,
---2<sup>15</sup>).  If outside this range, [integer
---overflow](https://en.wikipedia.org/wiki/Integer_overflow) may occur. For
---example, providing 32,768 (equal to 2<sup>15</sup>) as a component
---overflows the 16-bit integer, and so the component is -32,768 (equal
---to -2<sup>15</sup>) instead.
---@return Vector2int16
Vector2int16.new = function(x, y) end;
---@class Vector3
---@field public zero Vector3
---@field public one Vector3
---@field public xAxis Vector3
---@field public yAxis Vector3
---@field public zAxis Vector3
---@field public X number
---@field public Y number
---@field public Z number
---@field public Magnitude number
---@field public Unit Vector3
---The `Vector3` data type represents a
---[vector](<https://en.wikipedia.org/wiki/Vector_(mathematics_and_physics)>) in
---3D space, typically usually used as a point in 3D space or the dimensions of a
---rectangular prism. `Vector3` supports basic component-based arithmetic
---operators: sum, difference, product, and quotient. These operations can be
---applied on the left or right hand side to either another `Vector3` or a
---number. It also features functions for commonly used vector operations, such
---as cross and dot products.
---
---Some example usages of `Vector3` are the `BasePart/Position|Position`,
---`BasePart/Rotation|Rotation` and `BasePart/Size|Size` of `BasePart|parts`.
---Learning to set these properties are among the first things many developers
---will learn:
---
---```lua
---local part = workspace.Part
---part.Position = part.Position + Vector3.new(5, 20, 100) -- Moves a part by this much
---```
---
---`Vector3` is commonly used when constructing other more complex 3D data types,
---namely `datatype/CFrame` and `datatype/Ray`. Many of these data types'
---functions will use a `Vector3` within their parameters, such as
---`CFrame:PointToObjectSpace` or `Ray:ClosestPoint`. CFrame arithmetic also
---supports `Vector3` for addition/subtraction.
---
---See also:
---
---- `datatype/Vector3int16`, a lower precision implementation of 3D vectors used
---  with `Region3int16`.
---
Vector3 = nil;
---A `Vector3` with a magnitude of zero.
---
---This API member is a **constant**, and must be accessed through the
---`Vector3` global as opposed to an individual `Vector3` object.
---
---```lua
---print(Vector3.zero) --> 0, 0, 0
---```
---
Vector3.zero = nil;
---A `Vector3` with a value of 1 on every axis.
---
---This API member is a **constant**, and must be accessed through the
---`Vector3` global as opposed to an individual `Vector3` object.
---
---```lua
---print(Vector3.one) --> 1, 1, 1
---```
---
Vector3.one = nil;
---A `Vector3` with a value of 1 on the X axis.
---
---This API member is a **constant**, and must be accessed through the
---`Vector3` global as opposed to an individual `Vector3` object.
---
---```lua
---print(Vector3.xAxis) --> 1, 0, 0
---```
---
Vector3.xAxis = nil;
---A `Vector3` with a value of 1 on the Y axis.
---
---This API member is a **constant**, and must be accessed through the
---`Vector3` global as opposed to an individual `Vector3` object.
---
---```lua
---print(Vector3.yAxis) --> 0, 1, 0
---```
---
Vector3.yAxis = nil;
---A `Vector3` with a value of 1 on the Z axis.
---
---This API member is a **constant**, and must be accessed through the
---`Vector3` global as opposed to an individual `Vector3` object.
---
---```lua
---print(Vector3.zAxis) --> 0, 0, 1
---```
---
Vector3.zAxis = nil;
---The x-coordinate of the Vector3.
---
Vector3.X = nil;
---The y-coordinate of the Vector3.
---
Vector3.Y = nil;
---The z-coordinate of the Vector3.
---
Vector3.Z = nil;
---The length of the Vector3.
---
Vector3.Magnitude = nil;
---A normalized copy of the `Vector3` - one that has the same direction as
---the original but a magnitude of 1.
---
Vector3.Unit = nil;
---@param normal Enum.NormalId
---Returns a new `Vector3` in the given direction.
---@return Vector3
Vector3.FromNormalId = function(normal) end;
---@param x number
---@param y number
---@param z number
---Returns a new `Vector3` using the given x, y, and z components.
---@return Vector3
Vector3.new = function(x, y, z) end;
---@param axis Enum.Axis
---Returns a new `Vector3` for the given axis.
---@return Vector3
Vector3.FromAxis = function(axis) end;
---@param goal Vector3
---@param alpha number
---@return Vector3
---Returns a `Vector3` linearly interpolated between this `Vector3` and the
---given `goal` `Vector3` by the fraction `alpha`.
---
---Note: the `alpha` value is **not** limited to the range [0, 1].
---
Vector3.Lerp = function(self, goal, alpha) end;
---@vararg Tuple
---@return Vector3
---Returns a `Vector3` with each component as the highest among the
---respective components of the provided `Vector3` objects.
---
---```lua
---local a = Vector3.new(1, 2, 1)
---local b = Vector3.new(2, 1, 2)
---
---print(a:Max(b)) -- Vector3.new(2, 2, 2)
---```
---
Vector3.Max = function(self, ...) end;
---@vararg Tuple
---@return Vector3
---Returns a `Vector3` with each component as the lowest among the respective
---components of the provided `Vector3` objects.
---
---```lua
---local a = Vector3.new(1, 2, 1)
---local b = Vector3.new(2, 1, 2)
---
---print(a:Min(b)) -- Vector3.new(1, 1, 1)
---```
---
Vector3.Min = function(self, ...) end;
---@param other Vector3
---@return number
---Returns a scalar dot product of the two vectors.
---
Vector3.Dot = function(self, other) end;
---@param other Vector3
---@return Vector3
---Returns the cross product of the two vectors.
---
Vector3.Cross = function(self, other) end;
---@param other Vector3
---@param epsilon number
---@return bool
---Returns `true` if the `other` `Vector3` falls within the `epsilon` radius
---of this `Vector3`.
---
Vector3.FuzzyEq = function(self, other, epsilon) end;
---@class Vector3int16
---@field public X integer
---@field public Y integer
---@field public Z integer
---Not to be confused with `datatype/Vector3`, which is more commonly used in the
---Roblox API.
---
---The `Vector3int16` data type describes a vector in 3D space using a **signed
---16-bit integer** for its components. It is similar to `datatype/Vector3` in
---that it allows for the same arithmetic operations; however it lacks commonly
---used vector functions. It is used in constructing `Region3int16`, which is
---relevant in some `Terrain` operations.
---
---For each component:
---
---- The **lower** bound is -2<sup>15</sup>, or **-32,768**.
---- The **upper** bound is 2<sup>15</sup> &minus; 1, or **32,767**.
---
---## Conversion to Vector3
---
---To convert a `Vector3int16` to a `Vector3`, construct the `Vector3`
---component-wise by passing the components of the `Vector3int16` to
---`Vector3.new()`:
---
---```lua
---local function ConvertVector3int16ToVector3(vector16)
---	return Vector3.new(vector16.X, vector16.Y, vector16.Z)
---end
---```
---
---**Don't pass a `Vector3int16` to `Vector3.new()`:** The `Vector3.new()`
---constructor interprets a `Vector3int16` as a 0 (zero) within its parameters
---**without producing an error**. This can lead to silent logic errors if you're
---doing something like this:
---
---```lua
---Vector3.new(Vector3int16.new(1, 2, 3)) --> Vector3.new(0, 0, 0)
---```
---
---In order to properly convert to `Vector3`, you must construct it
---component-wise as above.
---
Vector3int16 = nil;
---The x-coordinate of the `Vector3int16`, also accessible in its lower-case
---variant.
---
Vector3int16.X = nil;
---The y-coordinate of the `Vector3int16`, also accessible in its lower-case
---variant.
---
Vector3int16.Y = nil;
---The z-coordinate of the `Vector3int16`, also accessible in its lower-case
---variant.
---
Vector3int16.Z = nil;
---@param x number
---@param y number
---@param z number
---Returns a new `Vector3int16` from the given x, y and z components.
---Non-integer components are rounded down.
---
---The components must fall within the range [-2<sup>15</sup>,
---2<sup>15</sup>).  If outside this range, [integer
---overflow](https://en.wikipedia.org/wiki/Integer_overflow) may occur. For
---example, providing 32,768 (equal to 2<sup>15</sup>) as a component
---overflows the 16-bit integer, and so the component will be -32,768 (equal
---to -2<sup>15</sup>) instead.
---@return Vector3int16
Vector3int16.new = function(x, y, z) end;
---@class Enum.ABTestLoadingStatus
---@field public None number | '0'
---@field public Pending number | '1'
---@field public Initialized number | '2'
---@field public Error number | '3'
---@field public TimedOut number | '4'
---@field public ShutOff number | '5'
local ABTestLoadingStatus;
---
ABTestLoadingStatus.None = nil;
---
ABTestLoadingStatus.Pending = nil;
---
ABTestLoadingStatus.Initialized = nil;
---
ABTestLoadingStatus.Error = nil;
---
ABTestLoadingStatus.TimedOut = nil;
---
ABTestLoadingStatus.ShutOff = nil;
Enum.ABTestLoadingStatus = ABTestLoadingStatus;
---@diagnostic disable-next-line
---@alias ABTestLoadingStatus Enum.ABTestLoadingStatus
---@class Enum.AccessoryType
---@field public Unknown number | '0'
---@field public Hat number | '1'
---@field public Hair number | '2'
---@field public Face number | '3'
---@field public Neck number | '4'
---@field public Shoulder number | '5'
---@field public Front number | '6'
---@field public Back number | '7'
---@field public Waist number | '8'
---@field public TShirt number | '9'
---@field public Shirt number | '10'
---@field public Pants number | '11'
---@field public Jacket number | '12'
---@field public Sweater number | '13'
---@field public Shorts number | '14'
---@field public LeftShoe number | '15'
---@field public RightShoe number | '16'
---@field public DressSkirt number | '17'
---@field public Eyebrow number | '18'
---@field public Eyelash number | '19'
---AccessoryType is a subset of AssetTypes which are relevant to only
---accessories.
---
---To get the AccessoryType of an accessory, see the Type on the accessory's web
---page. For example, see
---[Yi the Art Teacher - Hair](https://www.roblox.com/catalog/5911063681/Yi-the-Art-Teacher-Hair).
---
---AccessoryTypes are mainly used in the AccessoryBlob of HumanoidDescription,
---and to specify the type in Accessory.
---
local AccessoryType;
---If the accessory type is not known.
---
AccessoryType.Unknown = nil;
---A hat accessory (may be a rigid or layered accessory).
---
AccessoryType.Hat = nil;
---A hair accessory (may be a rigid or layered accessory).
---
AccessoryType.Hair = nil;
---A face accessory (may be a rigid or layered accessory).
---
AccessoryType.Face = nil;
---A neck Accessory (may be a rigid or layered accessory).
---
AccessoryType.Neck = nil;
---A shoulder accessory (may be a rigid or layered accessory).
---
AccessoryType.Shoulder = nil;
---A front accessory (may be a rigid or layered accessory).
---
AccessoryType.Front = nil;
---A back accessory (may be a rigid or layered accessory).
---
AccessoryType.Back = nil;
---A waist accessory (may be a rigid or layered accessory).
---
AccessoryType.Waist = nil;
---A layered clothing T-Shirt accessory.
---
AccessoryType.TShirt = nil;
---A layered clothing shirt accessory.
---
AccessoryType.Shirt = nil;
---A layered clothing pants accessory.
---
AccessoryType.Pants = nil;
---A layered clothing jacket accessory.
---
AccessoryType.Jacket = nil;
---A layered clothing sweater accessory.
---
AccessoryType.Sweater = nil;
---A layered clothing shorts accessory.
---
AccessoryType.Shorts = nil;
---A layered clothing left shoe accessory.
---
AccessoryType.LeftShoe = nil;
---A layered clothing right shoe accessory.
---
AccessoryType.RightShoe = nil;
---A layered clothing dress or skirt accessory.
---
AccessoryType.DressSkirt = nil;
---
AccessoryType.Eyebrow = nil;
---
AccessoryType.Eyelash = nil;
Enum.AccessoryType = AccessoryType;
---@diagnostic disable-next-line
---@alias AccessoryType Enum.AccessoryType
---@class Enum.ActionType
---@field public Nothing number | '0'
---@field public Pause number | '1'
---@field public Lose number | '2'
---@field public Draw number | '3'
---@field public Win number | '4'
local ActionType;
---
ActionType.Nothing = nil;
---
ActionType.Pause = nil;
---
ActionType.Lose = nil;
---
ActionType.Draw = nil;
---
ActionType.Win = nil;
Enum.ActionType = ActionType;
---@diagnostic disable-next-line
---@alias ActionType Enum.ActionType
---@class Enum.ActuatorRelativeTo
---@field public Attachment0 number | '0'
---@field public Attachment1 number | '1'
---@field public World number | '2'
---The CFrame value in which the body mover constraint is expressed.
---
local ActuatorRelativeTo;
---The constraint is expressed relative to Attatchment0.
---
ActuatorRelativeTo.Attachment0 = nil;
---The constraint is expressed relative to Attatchment1.
---
ActuatorRelativeTo.Attachment1 = nil;
---The constraint is expressed relative to the game world.
---
ActuatorRelativeTo.World = nil;
Enum.ActuatorRelativeTo = ActuatorRelativeTo;
---@diagnostic disable-next-line
---@alias ActuatorRelativeTo Enum.ActuatorRelativeTo
---@class Enum.ActuatorType
---@field public None number | '0'
---@field public Motor number | '1'
---@field public Servo number | '2'
local ActuatorType;
---
ActuatorType.None = nil;
---
ActuatorType.Motor = nil;
---
ActuatorType.Servo = nil;
Enum.ActuatorType = ActuatorType;
---@diagnostic disable-next-line
---@alias ActuatorType Enum.ActuatorType
---@class Enum.AdornCullingMode
---@field public Automatic number | '0'
---@field public Never number | '1'
---Used by `HandleAdornment` to determine how it is culled.
---
local AdornCullingMode;
---Automatically culls adornment based on distance.
---
AdornCullingMode.Automatic = nil;
---Never culls adornment. Adornment is always visible.
---
AdornCullingMode.Never = nil;
Enum.AdornCullingMode = AdornCullingMode;
---@diagnostic disable-next-line
---@alias AdornCullingMode Enum.AdornCullingMode
---@class Enum.AlignType
---@field public Parallel number | '0'
---@field public Perpendicular number | '1'
---An enum that specifies the relationship between two axes. It's either parallel
---or perpendicular.
---
local AlignType;
---Two parallel axes.
---
AlignType.Parallel = nil;
---Two perpendicular axes.
---
AlignType.Perpendicular = nil;
Enum.AlignType = AlignType;
---@diagnostic disable-next-line
---@alias AlignType Enum.AlignType
---@class Enum.AlphaMode
---@field public Overlay number | '0'
---@field public Transparency number | '1'
---Used by `SurfaceAppearance/AlphaMode` to determine how the alpha channel of
---the `SurfaceAppearance/ColorMap` of a `SurfaceAppearance` is used.
---
local AlphaMode;
---Overlays the `SurfaceAppearance/ColorMap` on top of the underlying part
---color based on the ColorMap's alpha channel.
---
---![AlphaMode OverLay](assets/blt625b6777e66ae841/fern-cutout.png)
---
AlphaMode.Overlay = nil;
---Overlays the `SurfaceAppearance/ColorMap` on top of the underlying part
---`Part/Color3|color` color based on the ColorMap's alpha channel.
---
---![AlphaMode Transparency](assets/bltd194e7f5a88d1fdd/fern-overlay.png).
---
AlphaMode.Transparency = nil;
Enum.AlphaMode = AlphaMode;
---@diagnostic disable-next-line
---@alias AlphaMode Enum.AlphaMode
---@class Enum.AnalyticsEconomyAction
---@field public Default number | '0'
---@field public Acquire number | '1'
---@field public Spend number | '2'
---This enum is used as an argument in `AnalyticsService/FireInGameEconomyEvent`.
---
local AnalyticsEconomyAction;
---Default action. Used for an undefined Action.
---
AnalyticsEconomyAction.Default = nil;
---Indicates the acquisition of an in game resource. For example, a player
---acquires virtual currency by completing a specific in game task.
---
AnalyticsEconomyAction.Acquire = nil;
---Indicates the spending or loss of an in game resource. For example, a
---player spends virtual currency to acquire a new item.
---
AnalyticsEconomyAction.Spend = nil;
Enum.AnalyticsEconomyAction = AnalyticsEconomyAction;
---@diagnostic disable-next-line
---@alias AnalyticsEconomyAction Enum.AnalyticsEconomyAction
---@class Enum.AnalyticsLogLevel
---@field public Trace number | '0'
---@field public Debug number | '1'
---@field public Information number | '2'
---@field public Warning number | '3'
---@field public Error number | '4'
---@field public Fatal number | '5'
---This enum is used as an argument in `AnalyticsService/LogEvent` to describe
---the error severity level.
---
local AnalyticsLogLevel;
---Trace is the noisiest level, rarely (if ever) enabled for a production
---app.
---
AnalyticsLogLevel.Trace = nil;
---Used for debugging.
---
AnalyticsLogLevel.Debug = nil;
---
AnalyticsLogLevel.Information = nil;
---Used for warning.
---
AnalyticsLogLevel.Warning = nil;
---When functionality is unavailable or expectations broken.
---
AnalyticsLogLevel.Error = nil;
---The most critical level, Fatal events demand immediate attention.
---
AnalyticsLogLevel.Fatal = nil;
Enum.AnalyticsLogLevel = AnalyticsLogLevel;
---@diagnostic disable-next-line
---@alias AnalyticsLogLevel Enum.AnalyticsLogLevel
---@class Enum.AnalyticsProgressionStatus
---@field public Default number | '0'
---@field public Begin number | '1'
---@field public Complete number | '2'
---@field public Abandon number | '3'
---@field public Fail number | '4'
---This enum is used as an argument in
---`AnalyticsService/FirePlayerProgressionEvent` to describe the status of
---progression.
---
local AnalyticsProgressionStatus;
---Default status. Used for an undefined status.
---
AnalyticsProgressionStatus.Default = nil;
---Indicates the beginning of progression.
---
AnalyticsProgressionStatus.Begin = nil;
---Indicates the progression completed.
---
AnalyticsProgressionStatus.Complete = nil;
---Indicates the progression abandoned.
---
AnalyticsProgressionStatus.Abandon = nil;
---Indicates the progression failed.
---
AnalyticsProgressionStatus.Fail = nil;
Enum.AnalyticsProgressionStatus = AnalyticsProgressionStatus;
---@diagnostic disable-next-line
---@alias AnalyticsProgressionStatus Enum.AnalyticsProgressionStatus
---@class Enum.AnimationPriority
---@field public Idle number | '0'
---@field public Movement number | '1'
---@field public Action number | '2'
---@field public Action2 number | '3'
---@field public Action3 number | '4'
---@field public Action4 number | '5'
---@field public Core number | '1000'
---When multiple AnimationTracks are played concurrently by the same Animator and
---affect the same animated joints, the tracks are evaluated in order from high
---to low priority, per joint, while the total track weight sum remains less than
---1.0. When the track weight sum reaches or exceeds 1.0 for a joint, evaluation
---stops and no lower-priority tracks will be evaluated for that joint.
---AnimationTracks with the same priority that are playing concurrently will
---blend proportional to their track weights (normalized if the sum exceeds 1).
---
---Higher priority animation will override lower priority ones per joint. The
---priority order is: <br /> 1. Action4 (Highest Priority) <br /> 2. Action3
---<br /> 3. Action2 <br /> 4. Action <br /> 5. Movement <br /> 6. Idle <br /> 7.
---Core (Lowest Priority)
---
---Roblox's default character animations, including catalog animation bundles,
---play at Core priority. Idle through Action4 priority are for developer use.
---
local AnimationPriority;
---(6) - Recommended priority for character idle animations.
---
AnimationPriority.Idle = nil;
---(5) - Recommended priority for walk, run, swim, climb, and other
---locomotion animations.
---
AnimationPriority.Movement = nil;
---(4) - Recommended priority for character actions that must override idle
---and locomotion animations.
---
AnimationPriority.Action = nil;
---(3) - Action2 will override Action.
---
AnimationPriority.Action2 = nil;
---(2) - Action3 will override Action2.
---
AnimationPriority.Action3 = nil;
---(1) - Action4 is the highest priority available, overriding all other
---priority values.
---
AnimationPriority.Action4 = nil;
---(7) - Lowest priority, intended for use by Roblox default animations and
---catalog animation bundles.
---
AnimationPriority.Core = nil;
Enum.AnimationPriority = AnimationPriority;
---@diagnostic disable-next-line
---@alias AnimationPriority Enum.AnimationPriority
---@class Enum.AnimatorRetargetingMode
---@field public Default number | '0'
---@field public Disabled number | '1'
---@field public Enabled number | '2'
---The AnimatorRetargetingMode Enum describes the setting for Animation
---Retargeting. Retargeting adapts animations to various character rigs based on
---their proportions.
---
local AnimatorRetargetingMode;
---Retargeting in default state, opt-in initially but subject to change.
---
AnimatorRetargetingMode.Default = nil;
---Retargeting disabled.
---
AnimatorRetargetingMode.Disabled = nil;
---Retargeting enabled.
---
AnimatorRetargetingMode.Enabled = nil;
Enum.AnimatorRetargetingMode = AnimatorRetargetingMode;
---@diagnostic disable-next-line
---@alias AnimatorRetargetingMode Enum.AnimatorRetargetingMode
---@class Enum.AppShellActionType
---@field public None number | '0'
---@field public OpenApp number | '1'
---@field public TapChatTab number | '2'
---@field public TapConversationEntry number | '3'
---@field public TapAvatarTab number | '4'
---@field public ReadConversation number | '5'
---@field public TapGamePageTab number | '6'
---@field public TapHomePageTab number | '7'
---@field public GamePageLoaded number | '8'
---@field public HomePageLoaded number | '9'
---@field public AvatarEditorPageLoaded number | '10'
local AppShellActionType;
---
AppShellActionType.None = nil;
---
AppShellActionType.OpenApp = nil;
---
AppShellActionType.TapChatTab = nil;
---
AppShellActionType.TapConversationEntry = nil;
---
AppShellActionType.TapAvatarTab = nil;
---
AppShellActionType.ReadConversation = nil;
---
AppShellActionType.TapGamePageTab = nil;
---
AppShellActionType.TapHomePageTab = nil;
---
AppShellActionType.GamePageLoaded = nil;
---
AppShellActionType.HomePageLoaded = nil;
---
AppShellActionType.AvatarEditorPageLoaded = nil;
Enum.AppShellActionType = AppShellActionType;
---@diagnostic disable-next-line
---@alias AppShellActionType Enum.AppShellActionType
---@class Enum.AppShellFeature
---@field public None number | '0'
---@field public Chat number | '1'
---@field public AvatarEditor number | '2'
---@field public GamePage number | '3'
---@field public HomePage number | '4'
---@field public More number | '5'
---@field public Landing number | '6'
local AppShellFeature;
---
AppShellFeature.None = nil;
---
AppShellFeature.Chat = nil;
---
AppShellFeature.AvatarEditor = nil;
---
AppShellFeature.GamePage = nil;
---
AppShellFeature.HomePage = nil;
---
AppShellFeature.More = nil;
---
AppShellFeature.Landing = nil;
Enum.AppShellFeature = AppShellFeature;
---@diagnostic disable-next-line
---@alias AppShellFeature Enum.AppShellFeature
---@class Enum.AppUpdateStatus
---@field public Unknown number | '0'
---@field public NotSupported number | '1'
---@field public Failed number | '2'
---@field public NotAvailable number | '3'
---@field public Available number | '4'
local AppUpdateStatus;
---
AppUpdateStatus.Unknown = nil;
---
AppUpdateStatus.NotSupported = nil;
---
AppUpdateStatus.Failed = nil;
---
AppUpdateStatus.NotAvailable = nil;
---
AppUpdateStatus.Available = nil;
Enum.AppUpdateStatus = AppUpdateStatus;
---@diagnostic disable-next-line
---@alias AppUpdateStatus Enum.AppUpdateStatus
---@class Enum.ApplyStrokeMode
---@field public Contextual number | '0'
---@field public Border number | '1'
---This enum is used by `UIStroke/ApplyStrokeMode` to determine whether to apply
---the stroke to the object's border or of the text itself. For a more detailed
---walkthrough of the UIStroke object, see Applying Strokes.
---
local ApplyStrokeMode;
---The stroke is applied to the parent UI element's text.
---
ApplyStrokeMode.Contextual = nil;
---The stroke is applied to the parent UI element's border.
---
ApplyStrokeMode.Border = nil;
Enum.ApplyStrokeMode = ApplyStrokeMode;
---@diagnostic disable-next-line
---@alias ApplyStrokeMode Enum.ApplyStrokeMode
---@class Enum.AspectType
---@field public FitWithinMaxSize number | '0'
---@field public ScaleWithParentSize number | '1'
---Used by `UIAspectRatioConstraint/AspectType` to control the sizing behavior.
---
local AspectType;
---Makes the element the maximum size it can be within the current possible
---AbsoluteSize of the element while maintaining the aspect ratio.
---
AspectType.FitWithinMaxSize = nil;
---Scales the element to the largest size it can fit inside the parent
---element's maximum size whilse maintaining the aspect ratio.
---
AspectType.ScaleWithParentSize = nil;
Enum.AspectType = AspectType;
---@diagnostic disable-next-line
---@alias AspectType Enum.AspectType
---@class Enum.AssetFetchStatus
---@field public Success number | '0'
---@field public Failure number | '1'
local AssetFetchStatus;
---
AssetFetchStatus.Success = nil;
---
AssetFetchStatus.Failure = nil;
Enum.AssetFetchStatus = AssetFetchStatus;
---@diagnostic disable-next-line
---@alias AssetFetchStatus Enum.AssetFetchStatus
---@class Enum.AssetType
---@field public Image number | '1'
---@field public TShirt number | '2'
---@field public Audio number | '3'
---@field public Mesh number | '4'
---@field public Lua number | '5'
---@field public Hat number | '8'
---@field public Place number | '9'
---@field public Model number | '10'
---@field public Shirt number | '11'
---@field public Pants number | '12'
---@field public Decal number | '13'
---@field public Head number | '17'
---@field public Face number | '18'
---@field public Gear number | '19'
---@field public Badge number | '21'
---@field public Animation number | '24'
---@field public Torso number | '27'
---@field public RightArm number | '28'
---@field public LeftArm number | '29'
---@field public LeftLeg number | '30'
---@field public RightLeg number | '31'
---@field public Package number | '32'
---@field public GamePass number | '34'
---@field public Plugin number | '38'
---@field public MeshPart number | '40'
---@field public HairAccessory number | '41'
---@field public FaceAccessory number | '42'
---@field public NeckAccessory number | '43'
---@field public ShoulderAccessory number | '44'
---@field public FrontAccessory number | '45'
---@field public BackAccessory number | '46'
---@field public WaistAccessory number | '47'
---@field public ClimbAnimation number | '48'
---@field public DeathAnimation number | '49'
---@field public FallAnimation number | '50'
---@field public IdleAnimation number | '51'
---@field public JumpAnimation number | '52'
---@field public RunAnimation number | '53'
---@field public SwimAnimation number | '54'
---@field public WalkAnimation number | '55'
---@field public PoseAnimation number | '56'
---@field public EarAccessory number | '57'
---@field public EyeAccessory number | '58'
---@field public EmoteAnimation number | '61'
---@field public Video number | '62'
---@field public TShirtAccessory number | '64'
---@field public ShirtAccessory number | '65'
---@field public PantsAccessory number | '66'
---@field public JacketAccessory number | '67'
---@field public SweaterAccessory number | '68'
---@field public ShortsAccessory number | '69'
---@field public LeftShoeAccessory number | '70'
---@field public RightShoeAccessory number | '71'
---@field public DressSkirtAccessory number | '72'
---@field public EyebrowAccessory number | '76'
---@field public EyelashAccessory number | '77'
---This Enum can be used to match the AssetTypeId from
---`MarketplaceService/GetProductInfo` to an asset type.
---
local AssetType;
---The asset is an image.
---
AssetType.Image = nil;
---
AssetType.TShirt = nil;
---The asset is an audio clip.
---
AssetType.Audio = nil;
---The asset is a mesh.
---
AssetType.Mesh = nil;
---The asset is Lua code, for example a `ModuleScript`.
---
AssetType.Lua = nil;
---The asset is a hat.
---
AssetType.Hat = nil;
---The asset is a place.
---
AssetType.Place = nil;
---The asset is a model.
---
AssetType.Model = nil;
---The asset is a shirt.
---
AssetType.Shirt = nil;
---The asset is a pants item.
---
AssetType.Pants = nil;
---The asset is a decal (image).
---
AssetType.Decal = nil;
---The asset is a head.
---
AssetType.Head = nil;
---The asset is a face.
---
AssetType.Face = nil;
---The asset is a gear item.
---
AssetType.Gear = nil;
---The asset is a badge.
---
AssetType.Badge = nil;
---The asset is an animation; also see the more specific animation type enums
---below.
---
AssetType.Animation = nil;
---The asset is a torso.
---
AssetType.Torso = nil;
---The asset is a right arm.
---
AssetType.RightArm = nil;
---The asset is a left arm.
---
AssetType.LeftArm = nil;
---The asset is a left leg.
---
AssetType.LeftLeg = nil;
---The asset is a right leg.
---
AssetType.RightLeg = nil;
---The asset is a pack, for example an animation package.
---
AssetType.Package = nil;
---The asset is a GamePass.
---
AssetType.GamePass = nil;
---The asset is a plugin.
---
AssetType.Plugin = nil;
---The asset is a mesh part.
---
AssetType.MeshPart = nil;
---The asset is a hair accessory.
---
AssetType.HairAccessory = nil;
---The asset is a face accessory.
---
AssetType.FaceAccessory = nil;
---The asset is a neck accessory.
---
AssetType.NeckAccessory = nil;
---The asset is a shoulder accessory.
---
AssetType.ShoulderAccessory = nil;
---The asset is a front accessory.
---
AssetType.FrontAccessory = nil;
---The asset is a back accessory.
---
AssetType.BackAccessory = nil;
---The asset is a waist accessory.
---
AssetType.WaistAccessory = nil;
---The asset is a climb animation.
---
AssetType.ClimbAnimation = nil;
---The asset is a death animation.
---
AssetType.DeathAnimation = nil;
---The asset is a fall animation.
---
AssetType.FallAnimation = nil;
---The asset is an idle animation.
---
AssetType.IdleAnimation = nil;
---The asset is a jump animation.
---
AssetType.JumpAnimation = nil;
---The asset is a run animation.
---
AssetType.RunAnimation = nil;
---The asset is a swim animation.
---
AssetType.SwimAnimation = nil;
---The asset is a walk animation.
---
AssetType.WalkAnimation = nil;
---The asset is a pose animation.
---
AssetType.PoseAnimation = nil;
---
AssetType.EarAccessory = nil;
---
AssetType.EyeAccessory = nil;
---The asset is an emote animation.
---
AssetType.EmoteAnimation = nil;
---The asset is a video.
---
AssetType.Video = nil;
---
AssetType.TShirtAccessory = nil;
---
AssetType.ShirtAccessory = nil;
---
AssetType.PantsAccessory = nil;
---
AssetType.JacketAccessory = nil;
---
AssetType.SweaterAccessory = nil;
---
AssetType.ShortsAccessory = nil;
---
AssetType.LeftShoeAccessory = nil;
---
AssetType.RightShoeAccessory = nil;
---
AssetType.DressSkirtAccessory = nil;
---
AssetType.EyebrowAccessory = nil;
---
AssetType.EyelashAccessory = nil;
Enum.AssetType = AssetType;
---@diagnostic disable-next-line
---@alias AssetType Enum.AssetType
---@class Enum.AssetTypeVerification
---@field public Default number | '1'
---@field public ClientOnly number | '2'
---@field public Always number | '3'
---Determines the asset type verification mode used when calling
---`Humanoid/ApplyDescription`. Asset type verification determines if
---ApplyDescription will load models or not. Loading models can be insecure if
---it's possible for malicious users to trick your game into loading unexpected
---models that you own which may include malicious scripts. You should set this
---to Always unless you want to load non-catalog assets.
---
local AssetTypeVerification;
---Use the default behavior for asset type verification.
---
AssetTypeVerification.Default = nil;
---Only verify asset types on the client. Asset type verification can not be
---turned off on the client.
---
AssetTypeVerification.ClientOnly = nil;
---Always verify the asset types to be loaded and disallow loading models.
---
AssetTypeVerification.Always = nil;
Enum.AssetTypeVerification = AssetTypeVerification;
---@diagnostic disable-next-line
---@alias AssetTypeVerification Enum.AssetTypeVerification
---@class Enum.AutoIndentRule
---@field public Off number | '0'
---@field public Absolute number | '1'
---@field public Relative number | '2'
local AutoIndentRule;
---
AutoIndentRule.Off = nil;
---
AutoIndentRule.Absolute = nil;
---
AutoIndentRule.Relative = nil;
Enum.AutoIndentRule = AutoIndentRule;
---@diagnostic disable-next-line
---@alias AutoIndentRule Enum.AutoIndentRule
---@class Enum.AutomaticSize
---@field public None number | '0'
---@field public X number | '1'
---@field public Y number | '2'
---@field public XY number | '3'
---UI objects with `GuiObject/AutomaticSize|AutomaticSize` enabled will increase
---in size up to maximum size allowed by the parent (if there is one) and no
---smaller than the `GuiObject/Size|Size` property bounds. To enable
---`AutomaticSize`, set the value to an enum value other than `None`.
---
---This enum is used by `GuiObject/AutomaticSize` and
---`ScrollingFrame/AutomaticCanvasSize` to determine whether and how resizing
---occurs based on child content.
---
---For more information, see How to use AutomaticSize.
---
local AutomaticSize;
---Default sizing behavior.
---
AutomaticSize.None = nil;
---Automatically resize element along X-axis to fit child contents.
---
AutomaticSize.X = nil;
---Automatically resize element along Y-axis to fit child contents. Text
---Objects will only resize along the Y-axis if TextWrapped is enabled.
---
AutomaticSize.Y = nil;
---Automatically resize element along X and Y axes to fit child contents.
---
AutomaticSize.XY = nil;
Enum.AutomaticSize = AutomaticSize;
---@diagnostic disable-next-line
---@alias AutomaticSize Enum.AutomaticSize
---@class Enum.AvatarAssetType
---@field public TShirt number | '2'
---@field public Hat number | '8'
---@field public Shirt number | '11'
---@field public Pants number | '12'
---@field public Head number | '17'
---@field public Face number | '18'
---@field public Gear number | '19'
---@field public Torso number | '27'
---@field public RightArm number | '28'
---@field public LeftArm number | '29'
---@field public LeftLeg number | '30'
---@field public RightLeg number | '31'
---@field public HairAccessory number | '41'
---@field public FaceAccessory number | '42'
---@field public NeckAccessory number | '43'
---@field public ShoulderAccessory number | '44'
---@field public FrontAccessory number | '45'
---@field public BackAccessory number | '46'
---@field public WaistAccessory number | '47'
---@field public ClimbAnimation number | '48'
---@field public FallAnimation number | '50'
---@field public IdleAnimation number | '51'
---@field public JumpAnimation number | '52'
---@field public RunAnimation number | '53'
---@field public SwimAnimation number | '54'
---@field public WalkAnimation number | '55'
---@field public EmoteAnimation number | '61'
---@field public TShirtAccessory number | '64'
---@field public ShirtAccessory number | '65'
---@field public PantsAccessory number | '66'
---@field public JacketAccessory number | '67'
---@field public SweaterAccessory number | '68'
---@field public ShortsAccessory number | '69'
---@field public LeftShoeAccessory number | '70'
---@field public RightShoeAccessory number | '71'
---@field public DressSkirtAccessory number | '72'
---@field public EyebrowAccessory number | '76'
---@field public EyelashAccessory number | '77'
---Describes the asset types that an avatar can equip. See `Enum/AssetType` for
---all asset types.
---
local AvatarAssetType;
---A classic 2D TShirt.
---
AvatarAssetType.TShirt = nil;
---A hat.
---
AvatarAssetType.Hat = nil;
---A classic 2D shirt.
---
AvatarAssetType.Shirt = nil;
---A classic 2D pants.
---
AvatarAssetType.Pants = nil;
---A head.
---
AvatarAssetType.Head = nil;
---A face.
---
AvatarAssetType.Face = nil;
---A gear.
---
AvatarAssetType.Gear = nil;
---A torso.
---
AvatarAssetType.Torso = nil;
---A right arm.
---
AvatarAssetType.RightArm = nil;
---A left arm.
---
AvatarAssetType.LeftArm = nil;
---A left leg.
---
AvatarAssetType.LeftLeg = nil;
---A right leg.
---
AvatarAssetType.RightLeg = nil;
---A hair accessory.
---
AvatarAssetType.HairAccessory = nil;
---A face accessory.
---
AvatarAssetType.FaceAccessory = nil;
---A neck accessory.
---
AvatarAssetType.NeckAccessory = nil;
---A shoulder accessory.
---
AvatarAssetType.ShoulderAccessory = nil;
---A front accessory.
---
AvatarAssetType.FrontAccessory = nil;
---A back accessory.
---
AvatarAssetType.BackAccessory = nil;
---A waist accessory.
---
AvatarAssetType.WaistAccessory = nil;
---A climb animation.
---
AvatarAssetType.ClimbAnimation = nil;
---A fall animation.
---
AvatarAssetType.FallAnimation = nil;
---An idle animation.
---
AvatarAssetType.IdleAnimation = nil;
---A jump animation.
---
AvatarAssetType.JumpAnimation = nil;
---A run animation.
---
AvatarAssetType.RunAnimation = nil;
---A swim animation.
---
AvatarAssetType.SwimAnimation = nil;
---A walk animation.
---
AvatarAssetType.WalkAnimation = nil;
---A emote animation.
---
AvatarAssetType.EmoteAnimation = nil;
---A layered clothing TShirt.
---
AvatarAssetType.TShirtAccessory = nil;
---A layered clothing shirt.
---
AvatarAssetType.ShirtAccessory = nil;
---A layered clothing pants.
---
AvatarAssetType.PantsAccessory = nil;
---A layered clothing jacket.
---
AvatarAssetType.JacketAccessory = nil;
---A layered clothing sweater.
---
AvatarAssetType.SweaterAccessory = nil;
---A layered clothing shorts.
---
AvatarAssetType.ShortsAccessory = nil;
---A layered clothing left shoe.
---
AvatarAssetType.LeftShoeAccessory = nil;
---A layered clothing right shoe.
---
AvatarAssetType.RightShoeAccessory = nil;
---A layered clothing dress or skirt.
---
AvatarAssetType.DressSkirtAccessory = nil;
---
AvatarAssetType.EyebrowAccessory = nil;
---
AvatarAssetType.EyelashAccessory = nil;
Enum.AvatarAssetType = AvatarAssetType;
---@diagnostic disable-next-line
---@alias AvatarAssetType Enum.AvatarAssetType
---@class Enum.AvatarContextMenuOption
---@field public Friend number | '0'
---@field public Chat number | '1'
---@field public Emote number | '2'
---@field public InspectMenu number | '3'
local AvatarContextMenuOption;
---
AvatarContextMenuOption.Friend = nil;
---
AvatarContextMenuOption.Chat = nil;
---
AvatarContextMenuOption.Emote = nil;
---
AvatarContextMenuOption.InspectMenu = nil;
Enum.AvatarContextMenuOption = AvatarContextMenuOption;
---@diagnostic disable-next-line
---@alias AvatarContextMenuOption Enum.AvatarContextMenuOption
---@class Enum.AvatarItemType
---@field public Asset number | '1'
---@field public Bundle number | '2'
---The type (Asset or Bundle) of avatar items.
---
local AvatarItemType;
---Avatar assets.
---
AvatarItemType.Asset = nil;
---Avatar bundles.
---
AvatarItemType.Bundle = nil;
Enum.AvatarItemType = AvatarItemType;
---@diagnostic disable-next-line
---@alias AvatarItemType Enum.AvatarItemType
---@class Enum.AvatarPromptResult
---@field public Success number | '1'
---@field public PermissionDenied number | '2'
---@field public Failed number | '3'
---The result of prompt operations of `AvatarEditorService`.
---
local AvatarPromptResult;
---The prompted action was completed.
---
AvatarPromptResult.Success = nil;
---Denied permission to take the prompted action.
---
AvatarPromptResult.PermissionDenied = nil;
---Failure while trying to take the prompted action.
---
AvatarPromptResult.Failed = nil;
Enum.AvatarPromptResult = AvatarPromptResult;
---@diagnostic disable-next-line
---@alias AvatarPromptResult Enum.AvatarPromptResult
---@class Enum.Axis
---@field public X number | '0'
---@field public Y number | '1'
---@field public Z number | '2'
---The Axis Enum represents the X, Y and Z axes. Primarily this Enum is used with
---`ArcHandles` and `Handles|Handles`.
---
local Axis;
---The X axis.
---
Axis.X = nil;
---The Y axis.
---
Axis.Y = nil;
---The Z axis.
---
Axis.Z = nil;
Enum.Axis = Axis;
---@diagnostic disable-next-line
---@alias Axis Enum.Axis
---@class Enum.BinType
---@field public Script number | '0'
---@field public GameTool number | '1'
---@field public Grab number | '2'
---@field public Clone number | '3'
---@field public Hammer number | '4'
local BinType;
---
BinType.Script = nil;
---
BinType.GameTool = nil;
---
BinType.Grab = nil;
---
BinType.Clone = nil;
---
BinType.Hammer = nil;
Enum.BinType = BinType;
---@diagnostic disable-next-line
---@alias BinType Enum.BinType
---@class Enum.BodyPart
---@field public Head number | '0'
---@field public Torso number | '1'
---@field public LeftArm number | '2'
---@field public RightArm number | '3'
---@field public LeftLeg number | '4'
---@field public RightLeg number | '5'
---The BodyPart Enum determines which BodyPart a `CharacterMesh` affects. (the
---`CharacterMesh` is used with R6 characters)
---
local BodyPart;
---The head BodyPart.
---
BodyPart.Head = nil;
---The torso BodyPart.
---
BodyPart.Torso = nil;
---The left arm BodyPart.
---
BodyPart.LeftArm = nil;
---The right arm BodyPart.
---
BodyPart.RightArm = nil;
---The left leg BodyPart.
---
BodyPart.LeftLeg = nil;
---The right leg BodyPart.
---
BodyPart.RightLeg = nil;
Enum.BodyPart = BodyPart;
---@diagnostic disable-next-line
---@alias BodyPart Enum.BodyPart
---@class Enum.BodyPartR15
---@field public Head number | '0'
---@field public UpperTorso number | '1'
---@field public LowerTorso number | '2'
---@field public LeftFoot number | '3'
---@field public LeftLowerLeg number | '4'
---@field public LeftUpperLeg number | '5'
---@field public RightFoot number | '6'
---@field public RightLowerLeg number | '7'
---@field public RightUpperLeg number | '8'
---@field public LeftHand number | '9'
---@field public LeftLowerArm number | '10'
---@field public LeftUpperArm number | '11'
---@field public RightHand number | '12'
---@field public RightLowerArm number | '13'
---@field public RightUpperArm number | '14'
---@field public RootPart number | '15'
---@field public Unknown number | '17'
---BodyPartR15 is an enum used with both `Humanoid/GetBodyPartR15` and
---`Humanoid/ReplaceBodyPartR15` to find and replace specific body parts of R15
---characters.
---
local BodyPartR15;
---Reference to a Humanoid's Head.
---
BodyPartR15.Head = nil;
---Reference to a Humanoid's UpperTorso.
---
BodyPartR15.UpperTorso = nil;
---Reference to a Humanoid's LowerTorso.
---
BodyPartR15.LowerTorso = nil;
---Reference to a Humanoid's LeftFoot.
---
BodyPartR15.LeftFoot = nil;
---Reference to a Humanoid's LeftLowerLeg.
---
BodyPartR15.LeftLowerLeg = nil;
---Reference to a Humanoid's LeftUpperLeg.
---
BodyPartR15.LeftUpperLeg = nil;
---Reference to a Humanoid's RightFoot.
---
BodyPartR15.RightFoot = nil;
---Reference to a Humanoid's RightLowerLeg.
---
BodyPartR15.RightLowerLeg = nil;
---Reference to a Humanoid's RightUpperLeg.
---
BodyPartR15.RightUpperLeg = nil;
---Reference to a Humanoid's LeftHand.
---
BodyPartR15.LeftHand = nil;
---Reference to a Humanoid's LeftLowerArm.
---
BodyPartR15.LeftLowerArm = nil;
---Reference to a Humanoid's LeftUpperArm.
---
BodyPartR15.LeftUpperArm = nil;
---Reference to a Humanoid's RightHand.
---
BodyPartR15.RightHand = nil;
---Reference to a Humanoid's RightLowerArm.
---
BodyPartR15.RightLowerArm = nil;
---Reference to a Humanoid's RightUpperArm.
---
BodyPartR15.RightUpperArm = nil;
---Reference to a Humanoid's HumanoidRootPart.
---
BodyPartR15.RootPart = nil;
---Unknown R15 Humanoid body part!.
---
BodyPartR15.Unknown = nil;
Enum.BodyPartR15 = BodyPartR15;
---@diagnostic disable-next-line
---@alias BodyPartR15 Enum.BodyPartR15
---@class Enum.BorderMode
---@field public Outline number | '0'
---@field public Middle number | '1'
---@field public Inset number | '2'
---Determines in what matter the border of a `GuiObject` is laid out relative to
---its actual dimensions. It is used by the property of the same name,
---`GuiObject/BorderMode`. See the animation below to understand how the layout
---changes as `GuiObject/BorderSizePixel` increases.
---
---<img src="/assets/bltc055b61764ed776b/BorderSizePixel-BorderMode.gif" />
---
local BorderMode;
---As `GuiObject/BorderSizePixel` increases, the border grows outward. The
---dimensions of the GuiObject's contents do not change.
---
BorderMode.Outline = nil;
---As `GuiObject/BorderSizePixel` increases, the border grows evenly inward
---and outward. The dimensions of the GuiObject's contents are reduced at a
---1:1 ratio.
---
BorderMode.Middle = nil;
---As `GuiObject/BorderSizePixel` increases, the border grows evenly inward
---only. The dimensions of the GuiObject's contents are reduced at a 1:2
---ratio.
---
BorderMode.Inset = nil;
Enum.BorderMode = BorderMode;
---@diagnostic disable-next-line
---@alias BorderMode Enum.BorderMode
---@class Enum.BreakReason
---@field public Other number | '0'
---@field public Error number | '1'
---@field public UserBreakpoint number | '3'
---@field public SpecialBreakpoint number | '2'
---Value for the reason the `ScriptDebugger/EncounteredBreak` signal fired.
---
local BreakReason;
---Pausing for a reason not covered by other values, for example if the user
---hit "Pause" button.
---
BreakReason.Other = nil;
---Pausing on error hit in the code.
---
BreakReason.Error = nil;
---Pausing on a user breakpoint.
---
BreakReason.UserBreakpoint = nil;
---Pausing on an internal breakpoint set by debugger command: e.g. step over,
---step into, step out of.
---
BreakReason.SpecialBreakpoint = nil;
Enum.BreakReason = BreakReason;
---@diagnostic disable-next-line
---@alias BreakReason Enum.BreakReason
---@class Enum.BreakpointRemoveReason
---@field public Requested number | '0'
---@field public ScriptChanged number | '1'
---@field public ScriptRemoved number | '2'
---Reason reason that a breakpoint was removed.
---
local BreakpointRemoveReason;
---Breakpoint removal was requested by user or a command.
---
BreakpointRemoveReason.Requested = nil;
---Script that contained the breakpoint has changed.
---
BreakpointRemoveReason.ScriptChanged = nil;
---Script that contained the breakpoint was removed.
---
BreakpointRemoveReason.ScriptRemoved = nil;
Enum.BreakpointRemoveReason = BreakpointRemoveReason;
---@diagnostic disable-next-line
---@alias BreakpointRemoveReason Enum.BreakpointRemoveReason
---@class Enum.BulkMoveMode
---@field public FireAllEvents number | '0'
---@field public FireCFrameChanged number | '1'
local BulkMoveMode;
---
BulkMoveMode.FireAllEvents = nil;
---
BulkMoveMode.FireCFrameChanged = nil;
Enum.BulkMoveMode = BulkMoveMode;
---@diagnostic disable-next-line
---@alias BulkMoveMode Enum.BulkMoveMode
---@class Enum.BundleType
---@field public BodyParts number | '1'
---@field public Animations number | '2'
---@field public Shoes number | '3'
---The type of a bundle of assets.
---
local BundleType;
---A bundle of body parts and accessories.
---
BundleType.BodyParts = nil;
---A bundle of just animations.
---
BundleType.Animations = nil;
---
BundleType.Shoes = nil;
Enum.BundleType = BundleType;
---@diagnostic disable-next-line
---@alias BundleType Enum.BundleType
---@class Enum.Button
---@field public Jump number | '32'
---@field public Dismount number | '8'
---Used for accessing buttons for use by the `Controller`.
---
local Button;
---The Jump button.
---
Button.Jump = nil;
---The Dismount button.
---
Button.Dismount = nil;
Enum.Button = Button;
---@diagnostic disable-next-line
---@alias Button Enum.Button
---@class Enum.ButtonStyle
---@field public Custom number | '0'
---@field public RobloxButtonDefault number | '1'
---@field public RobloxButton number | '2'
---@field public RobloxRoundButton number | '3'
---@field public RobloxRoundDefaultButton number | '4'
---@field public RobloxRoundDropdownButton number | '5'
---Used by `GuiButton/Style` to set a special hardcoded appearance.
---
---These should generally be avoided in favor of setting other appearance
---properties, but they can be useful for wireframing.
---
---Despite the Roblox naming, these are not used by any official Roblox UI.
---
local ButtonStyle;
---The button will respect the `GuiObject/BorderColor3` and
---`GuiObject/BackgroundColor3` properties.
---
ButtonStyle.Custom = nil;
---A black background with a red border, and rounded corners.
---
ButtonStyle.RobloxButtonDefault = nil;
---A black background with a grey border, and rounded corners.
---
ButtonStyle.RobloxButton = nil;
---A grey background with rounded corners, and a slight drop shadow.
---
ButtonStyle.RobloxRoundButton = nil;
---A blue background with rounded corners, and a slight drop shadow.
---
ButtonStyle.RobloxRoundDefaultButton = nil;
---A white background with a thin grey border, rounded corners, and a slight
---drop shadow.
---
ButtonStyle.RobloxRoundDropdownButton = nil;
Enum.ButtonStyle = ButtonStyle;
---@diagnostic disable-next-line
---@alias ButtonStyle Enum.ButtonStyle
---@class Enum.CageType
---@field public Inner number | '0'
---@field public Outer number | '1'
local CageType;
---
CageType.Inner = nil;
---
CageType.Outer = nil;
Enum.CageType = CageType;
---@diagnostic disable-next-line
---@alias CageType Enum.CageType
---@class Enum.CameraMode
---@field public Classic number | '0'
---@field public LockFirstPerson number | '1'
---The CameraMode Enum is used to set `Player/CameraMode` in `Player`, and
---determines when first person and third person cameras should be used.
---
---## First-person
---
---In first-person mode, the player's camera is zoomed all the way in. Unless
---there is a visible GUI present with the `GuiButton/Modal` property set to
---_true_, the mouse will be locked and the user's camera will turn as the mouse
---moves. ![First Person CameraMode][1]
---
---## Third-person
---
---In third-person mode, the character can be seen in the camera. While in
---third-person mode on Roblox:
---
---- You may right-click and drag to rotate your camera, or use the arrow keys at
---  the bottom right-hand corner of the screen.
---- When you move your mouse, your camera does not change (unless you move the
---  mouse to the end of the screen).
---- When you press any of the arrow keys, the user's character will face in the
---  corresponding arrow key's direction.
---- You can zoom in and out freely.
---
---Third-person is the default camera setting. ![Third Person CameraMode][2]
---
---[1]: /assets/blt3d3247ee058ba219/CameraMode-LockFirstPerson.jpg
---[2]: /assets/bltbf81f29ace6b335b/CameraMode-Classic.jpg
---
local CameraMode;
---Third-person camera which can be zoomed into first-person.
---
CameraMode.Classic = nil;
---Exclusively first-person camera.
---
CameraMode.LockFirstPerson = nil;
Enum.CameraMode = CameraMode;
---@diagnostic disable-next-line
---@alias CameraMode Enum.CameraMode
---@class Enum.CameraPanMode
---@field public Classic number | '0'
---@field public EdgeBump number | '1'
---The CameraPanMode Enum represents the available pan modes for
---`Camera/SetCameraPanMode`.
---
local CameraPanMode;
---Enables swipe and pan on mobile devices, and disables edge bump camera
---controls. Default.
---
CameraPanMode.Classic = nil;
---Disables swipe to pan on mobile devices, and enables edge bump camera
---controls. It does not affect PC or Mac users.
---
CameraPanMode.EdgeBump = nil;
Enum.CameraPanMode = CameraPanMode;
---@diagnostic disable-next-line
---@alias CameraPanMode Enum.CameraPanMode
---@class Enum.CameraType
---@field public Fixed number | '0'
---@field public Watch number | '2'
---@field public Attach number | '1'
---@field public Track number | '3'
---@field public Follow number | '4'
---@field public Custom number | '5'
---@field public Scriptable number | '6'
---@field public Orbital number | '7'
---The CameraType Enum is used in `Camera.CameraType` to set the behavior of the
---Camera object.
---
---Attach, Watch, Track, and Follow all require a valid `Camera/CameraSubject` to
---work properly.
---
local CameraType;
---Camera is stationary.
---
CameraType.Fixed = nil;
---Camera is stationary but will rotate to keep the subject in the center of
---the screen.
---
CameraType.Watch = nil;
---Camera moves with the subject at a fixed offset and will rotate as the
---subject rotates.
---
CameraType.Attach = nil;
---Camera moves with the subject but does not rotate automatically.
---
CameraType.Track = nil;
---Camera moves with the subject and rotates to keep the subject in the
---center.
---
CameraType.Follow = nil;
---Default mode used by Roblox Core Scripts.
---
CameraType.Custom = nil;
---No default behavior. Used when developers need to script custom behavior.
---
CameraType.Scriptable = nil;
---The camera has a fixed Y position, but can be rotated around the player.
---
CameraType.Orbital = nil;
Enum.CameraType = CameraType;
---@diagnostic disable-next-line
---@alias CameraType Enum.CameraType
---@class Enum.CatalogCategoryFilter
---@field public None number | '1'
---@field public Featured number | '2'
---@field public Collectibles number | '3'
---@field public CommunityCreations number | '4'
---@field public Premium number | '5'
---@field public Recommended number | '6'
local CatalogCategoryFilter;
---
CatalogCategoryFilter.None = nil;
---
CatalogCategoryFilter.Featured = nil;
---
CatalogCategoryFilter.Collectibles = nil;
---
CatalogCategoryFilter.CommunityCreations = nil;
---
CatalogCategoryFilter.Premium = nil;
---
CatalogCategoryFilter.Recommended = nil;
Enum.CatalogCategoryFilter = CatalogCategoryFilter;
---@diagnostic disable-next-line
---@alias CatalogCategoryFilter Enum.CatalogCategoryFilter
---@class Enum.CatalogSortType
---@field public Relevance number | '1'
---@field public PriceHighToLow number | '2'
---@field public PriceLowToHigh number | '3'
---@field public RecentlyUpdated number | '4'
---@field public MostFavorited number | '5'
local CatalogSortType;
---
CatalogSortType.Relevance = nil;
---
CatalogSortType.PriceHighToLow = nil;
---
CatalogSortType.PriceLowToHigh = nil;
---
CatalogSortType.RecentlyUpdated = nil;
---
CatalogSortType.MostFavorited = nil;
Enum.CatalogSortType = CatalogSortType;
---@diagnostic disable-next-line
---@alias CatalogSortType Enum.CatalogSortType
---@class Enum.CellBlock
---@field public Solid number | '0'
---@field public VerticalWedge number | '1'
---@field public CornerWedge number | '2'
---@field public InverseCornerWedge number | '3'
---@field public HorizontalWedge number | '4'
local CellBlock;
---
CellBlock.Solid = nil;
---
CellBlock.VerticalWedge = nil;
---
CellBlock.CornerWedge = nil;
---
CellBlock.InverseCornerWedge = nil;
---
CellBlock.HorizontalWedge = nil;
Enum.CellBlock = CellBlock;
---@diagnostic disable-next-line
---@alias CellBlock Enum.CellBlock
---@class Enum.CellMaterial
---@field public Empty number | '0'
---@field public Grass number | '1'
---@field public Sand number | '2'
---@field public Brick number | '3'
---@field public Granite number | '4'
---@field public Asphalt number | '5'
---@field public Iron number | '6'
---@field public Aluminum number | '7'
---@field public Gold number | '8'
---@field public WoodPlank number | '9'
---@field public WoodLog number | '10'
---@field public Gravel number | '11'
---@field public CinderBlock number | '12'
---@field public MossyStone number | '13'
---@field public Cement number | '14'
---@field public RedPlastic number | '15'
---@field public BluePlastic number | '16'
---@field public Water number | '17'
local CellMaterial;
---
CellMaterial.Empty = nil;
---
CellMaterial.Grass = nil;
---
CellMaterial.Sand = nil;
---
CellMaterial.Brick = nil;
---
CellMaterial.Granite = nil;
---
CellMaterial.Asphalt = nil;
---
CellMaterial.Iron = nil;
---
CellMaterial.Aluminum = nil;
---
CellMaterial.Gold = nil;
---
CellMaterial.WoodPlank = nil;
---
CellMaterial.WoodLog = nil;
---
CellMaterial.Gravel = nil;
---
CellMaterial.CinderBlock = nil;
---
CellMaterial.MossyStone = nil;
---
CellMaterial.Cement = nil;
---
CellMaterial.RedPlastic = nil;
---
CellMaterial.BluePlastic = nil;
---
CellMaterial.Water = nil;
Enum.CellMaterial = CellMaterial;
---@diagnostic disable-next-line
---@alias CellMaterial Enum.CellMaterial
---@class Enum.CellOrientation
---@field public NegZ number | '0'
---@field public X number | '1'
---@field public Z number | '2'
---@field public NegX number | '3'
local CellOrientation;
---
CellOrientation.NegZ = nil;
---
CellOrientation.X = nil;
---
CellOrientation.Z = nil;
---
CellOrientation.NegX = nil;
Enum.CellOrientation = CellOrientation;
---@diagnostic disable-next-line
---@alias CellOrientation Enum.CellOrientation
---@class Enum.CenterDialogType
---@field public UnsolicitedDialog number | '1'
---@field public PlayerInitiatedDialog number | '2'
---@field public ModalDialog number | '3'
---@field public QuitDialog number | '4'
local CenterDialogType;
---
CenterDialogType.UnsolicitedDialog = nil;
---
CenterDialogType.PlayerInitiatedDialog = nil;
---
CenterDialogType.ModalDialog = nil;
---
CenterDialogType.QuitDialog = nil;
Enum.CenterDialogType = CenterDialogType;
---@diagnostic disable-next-line
---@alias CenterDialogType Enum.CenterDialogType
---@class Enum.ChatCallbackType
---@field public OnCreatingChatWindow number | '1'
---@field public OnClientSendingMessage number | '2'
---@field public OnClientFormattingMessage number | '3'
---@field public OnServerReceivingMessage number | '17'
local ChatCallbackType;
---
ChatCallbackType.OnCreatingChatWindow = nil;
---
ChatCallbackType.OnClientSendingMessage = nil;
---
ChatCallbackType.OnClientFormattingMessage = nil;
---
ChatCallbackType.OnServerReceivingMessage = nil;
Enum.ChatCallbackType = ChatCallbackType;
---@diagnostic disable-next-line
---@alias ChatCallbackType Enum.ChatCallbackType
---@class Enum.ChatColor
---@field public Blue number | '0'
---@field public Green number | '1'
---@field public Red number | '2'
---@field public White number | '3'
---The ChatStyle Enum is used to change the color of a chat using `Chat`.
---
local ChatColor;
---Blue chat color.
---
ChatColor.Blue = nil;
---Green chat color.
---
ChatColor.Green = nil;
---Red chat color.
---
ChatColor.Red = nil;
---White chat color.
---
ChatColor.White = nil;
Enum.ChatColor = ChatColor;
---@diagnostic disable-next-line
---@alias ChatColor Enum.ChatColor
---@class Enum.ChatMode
---@field public Menu number | '0'
---@field public TextAndMenu number | '1'
---Controls the methods of communication available to a player.
---
local ChatMode;
---The player is restricted to chatting via a menu of chat messages.
---
ChatMode.Menu = nil;
---A player can chat via custom text messages and a menu of chat messages.
---
ChatMode.TextAndMenu = nil;
Enum.ChatMode = ChatMode;
---@diagnostic disable-next-line
---@alias ChatMode Enum.ChatMode
---@class Enum.ChatPrivacyMode
---@field public AllUsers number | '0'
---@field public NoOne number | '1'
---@field public Friends number | '2'
---Internally controls the user's chat privacy settings.
---
local ChatPrivacyMode;
---A player can chat with all users in a game.
---
ChatPrivacyMode.AllUsers = nil;
---A player cannot chat with any other users in a game.
---
ChatPrivacyMode.NoOne = nil;
---A player can only chat with users in a game that are on their friends
---list.
---
ChatPrivacyMode.Friends = nil;
Enum.ChatPrivacyMode = ChatPrivacyMode;
---@diagnostic disable-next-line
---@alias ChatPrivacyMode Enum.ChatPrivacyMode
---@class Enum.ChatStyle
---@field public Classic number | '0'
---@field public Bubble number | '1'
---@field public ClassicAndBubble number | '2'
---The ChatStyle Enum is used to set the style of `Chat` used in a game via the
---`Players/SetChatStyle` method.
---
local ChatStyle;
---Displays chats in the chat user interface at the top-left corner of the
---screen.
---
ChatStyle.Classic = nil;
---Displays chats in a bubble above the sender's head.
---
ChatStyle.Bubble = nil;
---Has the effects of Classic and Bubble combined.
---
ChatStyle.ClassicAndBubble = nil;
Enum.ChatStyle = ChatStyle;
---@diagnostic disable-next-line
---@alias ChatStyle Enum.ChatStyle
---@class Enum.ChatVersion
---@field public LegacyChatService number | '0'
---@field public TextChatService number | '1'
---Determines whether `TextChatService` should be fully enabled or allow legacy
---[Lua Chat System](https://developer.roblox.com/en-us/articles/Lua-Chat-System)
---behavior.
---
---`TextChatService.ChatVersion` is not scriptable. It must be set in Studio.
---
local ChatVersion;
---Enables the legacy
---[Lua Chat System](https://developer.roblox.com/en-us/articles/Lua-Chat-System)
---behavior.
---
ChatVersion.LegacyChatService = nil;
---Enables `TextChatService` chat and prevents legacy
---[Lua Chat System](https://developer.roblox.com/en-us/articles/Lua-Chat-System)
---behavior.
---
ChatVersion.TextChatService = nil;
Enum.ChatVersion = ChatVersion;
---@diagnostic disable-next-line
---@alias ChatVersion Enum.ChatVersion
---@class Enum.ClientAnimatorThrottlingMode
---@field public Default number | '0'
---@field public Disabled number | '1'
---@field public Enabled number | '2'
---An Enum describing various animation throttling modes on clients.
---
local ClientAnimatorThrottlingMode;
---The default animation throttling mode defined by Roblox.
---
ClientAnimatorThrottlingMode.Default = nil;
---Disables animation throttling.
---
ClientAnimatorThrottlingMode.Disabled = nil;
---Enables animation throttling.
---
ClientAnimatorThrottlingMode.Enabled = nil;
Enum.ClientAnimatorThrottlingMode = ClientAnimatorThrottlingMode;
---@diagnostic disable-next-line
---@alias ClientAnimatorThrottlingMode Enum.ClientAnimatorThrottlingMode
---@class Enum.CollisionFidelity
---@field public Default number | '0'
---@field public Hull number | '1'
---@field public Box number | '2'
---@field public PreciseConvexDecomposition number | '3'
---Determines how the collision models of `UnionOperation`s and `MeshPart`s
---behave.
---
---The CollisionFidelity property of union objects is not scriptable: it must be
---set in Studio.
---
local CollisionFidelity;
---Uses the default collision model.
---
CollisionFidelity.Default = nil;
---Collision models behave using a
---[convex hull](https://en.wikipedia.org/wiki/Convex_hull).
---
CollisionFidelity.Hull = nil;
---Collision models behave using a box that corresponds to the union's
---selection box.
---
CollisionFidelity.Box = nil;
---
CollisionFidelity.PreciseConvexDecomposition = nil;
Enum.CollisionFidelity = CollisionFidelity;
---@diagnostic disable-next-line
---@alias CollisionFidelity Enum.CollisionFidelity
---@class Enum.CommandPermission
---@field public Plugin number | '0'
---@field public LocalUser number | '1'
local CommandPermission;
---
CommandPermission.Plugin = nil;
---
CommandPermission.LocalUser = nil;
Enum.CommandPermission = CommandPermission;
---@diagnostic disable-next-line
---@alias CommandPermission Enum.CommandPermission
---@class Enum.ComputerCameraMovementMode
---@field public Default number | '0'
---@field public Follow number | '2'
---@field public Classic number | '1'
---@field public Orbital number | '3'
---@field public CameraToggle number | '4'
---The camera movement mode currently in-use by the client.
---
local ComputerCameraMovementMode;
---The default camera movement mode is classic.
---
ComputerCameraMovementMode.Default = nil;
---Camera tracks the player and automatically rotates if the player walks
---left or right.
---
ComputerCameraMovementMode.Follow = nil;
---Camera tracks the player but will not automatically rotate if the player
---walks left or right.
---
ComputerCameraMovementMode.Classic = nil;
---The camera has a fixed Y position, but can be rotated around the player.
---
ComputerCameraMovementMode.Orbital = nil;
---The camera toggles between locked and free rotation with the right mouse
---button.
---
ComputerCameraMovementMode.CameraToggle = nil;
Enum.ComputerCameraMovementMode = ComputerCameraMovementMode;
---@diagnostic disable-next-line
---@alias ComputerCameraMovementMode Enum.ComputerCameraMovementMode
---@class Enum.ComputerMovementMode
---@field public Default number | '0'
---@field public KeyboardMouse number | '1'
---@field public ClickToMove number | '2'
---The computer movement type in-use by the client.
---
local ComputerMovementMode;
---The default is KeyboardMouse.
---
ComputerMovementMode.Default = nil;
---The player's character is controlled using the keyboard and mouse.
---
ComputerMovementMode.KeyboardMouse = nil;
---The player can right click in the game world and the character will move
---there. Player can also control character with mouse and keyboard.
---
ComputerMovementMode.ClickToMove = nil;
Enum.ComputerMovementMode = ComputerMovementMode;
---@diagnostic disable-next-line
---@alias ComputerMovementMode Enum.ComputerMovementMode
---@class Enum.ConnectionError
---@field public OK number | '0'
---@field public DisconnectErrors number | '256'
---@field public DisconnectBadhash number | '257'
---@field public DisconnectSecurityKeyMismatch number | '258'
---@field public DisconnectProtocolMismatch number | '259'
---@field public DisconnectReceivePacketError number | '260'
---@field public DisconnectReceivePacketStreamError number | '261'
---@field public DisconnectSendPacketError number | '262'
---@field public DisconnectIllegalTeleport number | '263'
---@field public DisconnectDuplicatePlayer number | '264'
---@field public DisconnectDuplicateTicket number | '265'
---@field public DisconnectTimeout number | '266'
---@field public DisconnectLuaKick number | '267'
---@field public DisconnectOnRemoteSysStats number | '268'
---@field public DisconnectHashTimeout number | '269'
---@field public DisconnectCloudEditKick number | '270'
---@field public DisconnectPlayerless number | '271'
---@field public DisconnectNewSecurityKeyMismatch number | '272'
---@field public DisconnectEvicted number | '273'
---@field public DisconnectDevMaintenance number | '274'
---@field public DisconnectRobloxMaintenance number | '275'
---@field public DisconnectRejoin number | '276'
---@field public DisconnectConnectionLost number | '277'
---@field public DisconnectIdle number | '278'
---@field public DisconnectRaknetErrors number | '279'
---@field public DisconnectWrongVersion number | '280'
---@field public DisconnectBySecurityPolicy number | '281'
---@field public DisconnectBlockedIP number | '282'
---@field public DisconnectClientFailure number | '284'
---@field public DisconnectClientRequest number | '285'
---@field public DisconnectOutOfMemory number | '286'
---@field public DisconnectModeratedGame number | '287'
---@field public PlacelaunchErrors number | '512'
---@field public PlacelaunchDisabled number | '515'
---@field public PlacelaunchError number | '516'
---@field public PlacelaunchGameEnded number | '517'
---@field public PlacelaunchGameFull number | '518'
---@field public PlacelaunchUserLeft number | '522'
---@field public PlacelaunchRestricted number | '523'
---@field public PlacelaunchUnauthorized number | '524'
---@field public PlacelaunchFlooded number | '525'
---@field public PlacelaunchHashExpired number | '526'
---@field public PlacelaunchHashException number | '527'
---@field public PlacelaunchPartyCannotFit number | '528'
---@field public PlacelaunchHttpError number | '529'
---@field public PlacelaunchCustomMessage number | '610'
---@field public PlacelaunchOtherError number | '611'
---@field public TeleportErrors number | '768'
---@field public TeleportFailure number | '769'
---@field public TeleportGameNotFound number | '770'
---@field public TeleportGameEnded number | '771'
---@field public TeleportGameFull number | '772'
---@field public TeleportUnauthorized number | '773'
---@field public TeleportFlooded number | '774'
---@field public TeleportIsTeleporting number | '775'
local ConnectionError;
---
ConnectionError.OK = nil;
---
ConnectionError.DisconnectErrors = nil;
---
ConnectionError.DisconnectBadhash = nil;
---
ConnectionError.DisconnectSecurityKeyMismatch = nil;
---
ConnectionError.DisconnectProtocolMismatch = nil;
---
ConnectionError.DisconnectReceivePacketError = nil;
---
ConnectionError.DisconnectReceivePacketStreamError = nil;
---
ConnectionError.DisconnectSendPacketError = nil;
---
ConnectionError.DisconnectIllegalTeleport = nil;
---
ConnectionError.DisconnectDuplicatePlayer = nil;
---
ConnectionError.DisconnectDuplicateTicket = nil;
---
ConnectionError.DisconnectTimeout = nil;
---
ConnectionError.DisconnectLuaKick = nil;
---
ConnectionError.DisconnectOnRemoteSysStats = nil;
---
ConnectionError.DisconnectHashTimeout = nil;
---
ConnectionError.DisconnectCloudEditKick = nil;
---
ConnectionError.DisconnectPlayerless = nil;
---
ConnectionError.DisconnectNewSecurityKeyMismatch = nil;
---
ConnectionError.DisconnectEvicted = nil;
---
ConnectionError.DisconnectDevMaintenance = nil;
---
ConnectionError.DisconnectRobloxMaintenance = nil;
---
ConnectionError.DisconnectRejoin = nil;
---
ConnectionError.DisconnectConnectionLost = nil;
---
ConnectionError.DisconnectIdle = nil;
---
ConnectionError.DisconnectRaknetErrors = nil;
---
ConnectionError.DisconnectWrongVersion = nil;
---
ConnectionError.DisconnectBySecurityPolicy = nil;
---
ConnectionError.DisconnectBlockedIP = nil;
---
ConnectionError.DisconnectClientFailure = nil;
---
ConnectionError.DisconnectClientRequest = nil;
---
ConnectionError.DisconnectOutOfMemory = nil;
---
ConnectionError.DisconnectModeratedGame = nil;
---
ConnectionError.PlacelaunchErrors = nil;
---
ConnectionError.PlacelaunchDisabled = nil;
---
ConnectionError.PlacelaunchError = nil;
---
ConnectionError.PlacelaunchGameEnded = nil;
---
ConnectionError.PlacelaunchGameFull = nil;
---
ConnectionError.PlacelaunchUserLeft = nil;
---
ConnectionError.PlacelaunchRestricted = nil;
---
ConnectionError.PlacelaunchUnauthorized = nil;
---
ConnectionError.PlacelaunchFlooded = nil;
---
ConnectionError.PlacelaunchHashExpired = nil;
---
ConnectionError.PlacelaunchHashException = nil;
---
ConnectionError.PlacelaunchPartyCannotFit = nil;
---
ConnectionError.PlacelaunchHttpError = nil;
---
ConnectionError.PlacelaunchCustomMessage = nil;
---
ConnectionError.PlacelaunchOtherError = nil;
---
ConnectionError.TeleportErrors = nil;
---
ConnectionError.TeleportFailure = nil;
---
ConnectionError.TeleportGameNotFound = nil;
---
ConnectionError.TeleportGameEnded = nil;
---
ConnectionError.TeleportGameFull = nil;
---
ConnectionError.TeleportUnauthorized = nil;
---
ConnectionError.TeleportFlooded = nil;
---
ConnectionError.TeleportIsTeleporting = nil;
Enum.ConnectionError = ConnectionError;
---@diagnostic disable-next-line
---@alias ConnectionError Enum.ConnectionError
---@class Enum.ConnectionState
---@field public Connected number | '0'
---@field public Disconnected number | '1'
---Used to determine the connection state of the client to the game server.
---
local ConnectionState;
---The client is connected.
---
ConnectionState.Connected = nil;
---The client is disconnected.
---
ConnectionState.Disconnected = nil;
Enum.ConnectionState = ConnectionState;
---@diagnostic disable-next-line
---@alias ConnectionState Enum.ConnectionState
---@class Enum.ContextActionPriority
---@field public Low number | '1000'
---@field public Medium number | '2000'
---@field public Default number | '2000'
---@field public High number | '3000'
---The ContextActionPriority is used to set the priority of a context action.
---This priority is used to determine context action order.
---
local ContextActionPriority;
---Low priority.
---
ContextActionPriority.Low = nil;
---Medium priority.
---
ContextActionPriority.Medium = nil;
---Default priority.
---
ContextActionPriority.Default = nil;
---High priority.
---
ContextActionPriority.High = nil;
Enum.ContextActionPriority = ContextActionPriority;
---@diagnostic disable-next-line
---@alias ContextActionPriority Enum.ContextActionPriority
---@class Enum.ContextActionResult
---@field public Pass number | '1'
---@field public Sink number | '0'
---ContextActionResult controls the behavior of multiple bound actions. It gives
---the option of controlling whether or not a bound action should sink or pass
---the input event, meaning other things (including other bound actions) can
---process it.
---
local ContextActionResult;
---If _functionToBind_ from `ContextActionService/BindAction` returns
---Enum.ContextActionResult.Pass, the input event is considered to have not
---been handled by _functionToBind_ and will continue being passed to actions
---bound to the same input type.
---
ContextActionResult.Pass = nil;
---If _functionToBind_ from `ContextActionService/BindAction` returns
---Enum.ContextActionResult.Sink, the input event will stop at that function
---and no other bound actions under it will be . This is the default behavior
---if _functionToBind_ does not return anything or yields in any way.
---
ContextActionResult.Sink = nil;
Enum.ContextActionResult = ContextActionResult;
---@diagnostic disable-next-line
---@alias ContextActionResult Enum.ContextActionResult
---@class Enum.ControlMode
---@field public MouseLockSwitch number | '1'
---@field public Classic number | '0'
---The ControlMode Enum sets how the player is controlled.
---
local ControlMode;
---Similar to classic, but allows the player to toggle mouse locking, causing
---the camera to rotate as the player moves the mouse (without holding down a
---button).
---
ControlMode.MouseLockSwitch = nil;
---Allows the camera to be moved by clicking and dragging with the right
---mouse button.
---
ControlMode.Classic = nil;
Enum.ControlMode = ControlMode;
---@diagnostic disable-next-line
---@alias ControlMode Enum.ControlMode
---@class Enum.CoreGuiType
---@field public PlayerList number | '0'
---@field public Health number | '1'
---@field public Backpack number | '2'
---@field public Chat number | '3'
---@field public All number | '4'
---@field public EmotesMenu number | '5'
---The CoreGuiType Enum represents all `CoreGui` "types" which are available,
---such as the `Backpack` and Leaderboard.
---
local CoreGuiType;
---The CoreGui displaying the list of in-game players.
---
CoreGuiType.PlayerList = nil;
---The CoreGui displaying a player's health.
---
CoreGuiType.Health = nil;
---The CoreGui displaying a player's backpack (containing a player's tools,
---gear, etc.).
---
CoreGuiType.Backpack = nil;
---The CoreGui used to display and send in-game chat message with other
---players.
---
CoreGuiType.Chat = nil;
---Refers to all available CoreGuis.
---
CoreGuiType.All = nil;
---Allows the Emotes Menu to be disabled using the existing
---`StarterGui/SetCoreGuiEnabled` API. Disabling all CoreGui types using
---`Enum/CoreGuiType/All` would also disable the Emotes Menu.
---
CoreGuiType.EmotesMenu = nil;
Enum.CoreGuiType = CoreGuiType;
---@diagnostic disable-next-line
---@alias CoreGuiType Enum.CoreGuiType
---@class Enum.CreateOutfitFailure
---@field public InvalidName number | '1'
---@field public OutfitLimitReached number | '2'
---@field public Other number | '3'
local CreateOutfitFailure;
---
CreateOutfitFailure.InvalidName = nil;
---
CreateOutfitFailure.OutfitLimitReached = nil;
---
CreateOutfitFailure.Other = nil;
Enum.CreateOutfitFailure = CreateOutfitFailure;
---@diagnostic disable-next-line
---@alias CreateOutfitFailure Enum.CreateOutfitFailure
---@class Enum.CreatorType
---@field public User number | '0'
---@field public Group number | '1'
---The ownership type of the open place.
---
local CreatorType;
---The place is owned by a single user.
---
CreatorType.User = nil;
---The place is owned by a group.
---
CreatorType.Group = nil;
Enum.CreatorType = CreatorType;
---@diagnostic disable-next-line
---@alias CreatorType Enum.CreatorType
---@class Enum.CurrencyType
---@field public Default number | '0'
---@field public Robux number | '1'
---@field public Tix number | '2'
---The CurrencyType Enum is used with `MarketplaceService` to set the currency
---used. As tickets no longer exist on the Roblox platform, this enum is
---**ignored** in most API that previously used it, such as
---`MarketplaceService/PromptPurchase|PromptPurchase`.
---
local CurrencyType;
---
CurrencyType.Default = nil;
---Use Robux.
---
CurrencyType.Robux = nil;
---Use Tickets.
---
CurrencyType.Tix = nil;
Enum.CurrencyType = CurrencyType;
---@diagnostic disable-next-line
---@alias CurrencyType Enum.CurrencyType
---@class Enum.CustomCameraMode
---@field public Default number | '0'
---@field public Follow number | '2'
---@field public Classic number | '1'
---Changes the player's camera mode in Roblox's Game settings.
---
local CustomCameraMode;
---The default camera mode is classic.
---
CustomCameraMode.Default = nil;
---Camera tracks the player and automatically rotates if the player walks
---left or right.
---
CustomCameraMode.Follow = nil;
---Camera tracks the player but will not automatically rotate if the player
---walks left or right.
---
CustomCameraMode.Classic = nil;
Enum.CustomCameraMode = CustomCameraMode;
---@diagnostic disable-next-line
---@alias CustomCameraMode Enum.CustomCameraMode
---@class Enum.DataStoreRequestType
---@field public GetAsync number | '0'
---@field public SetIncrementAsync number | '1'
---@field public UpdateAsync number | '2'
---@field public GetSortedAsync number | '3'
---@field public SetIncrementSortedAsync number | '4'
---@field public OnUpdate number | '5'
---Indicates the type of data store request being made.
---
local DataStoreRequestType;
---Refers to `GlobalDataStore/GetAsync|GetAsync()`.
---
DataStoreRequestType.GetAsync = nil;
---Refers to `GlobalDataStore/SetAsync|SetAsync()` and
---`GlobalDataStore/IncrementAsync|IncrementAsync()`.
---
DataStoreRequestType.SetIncrementAsync = nil;
---Refers to `GlobalDataStore/UpdateAsync|UpdateAsync()`.
---
DataStoreRequestType.UpdateAsync = nil;
---Refers to `GlobalDataStore/GetAsync|GetAsync()` while using an
---`OrderedDataStore`.
---
DataStoreRequestType.GetSortedAsync = nil;
---Refers to `GlobalDataStore/SetAsync|SetAsync()` and
---`GlobalDataStore/IncrementAsync|IncrementAsync()` while using an
---`OrderedDataStore`.
---
DataStoreRequestType.SetIncrementSortedAsync = nil;
---Refers to `GlobalDataStore/OnUpdate|OnUpdate()`.
---
DataStoreRequestType.OnUpdate = nil;
Enum.DataStoreRequestType = DataStoreRequestType;
---@diagnostic disable-next-line
---@alias DataStoreRequestType Enum.DataStoreRequestType
---@class Enum.DebuggerEndReason
---@field public ClientRequest number | '0'
---@field public Timeout number | '1'
---@field public InvalidHost number | '2'
---@field public Disconnected number | '3'
---@field public ServerShutdown number | '4'
---@field public ServerProtocolMismatch number | '5'
---@field public ConfigurationFailed number | '6'
---@field public RpcError number | '7'
---Reason for the end of the debugger session.
---
local DebuggerEndReason;
---Client requested connection termination.
---
DebuggerEndReason.ClientRequest = nil;
---Connection timed out.
---
DebuggerEndReason.Timeout = nil;
---Invalid host:port combination.
---
DebuggerEndReason.InvalidHost = nil;
---Connection was lost.
---
DebuggerEndReason.Disconnected = nil;
---Server terminated the connection because it shut down.
---
DebuggerEndReason.ServerShutdown = nil;
---Server has wrong version of protocol.
---
DebuggerEndReason.ServerProtocolMismatch = nil;
---Got a failure response when trying to configure the server.
---
DebuggerEndReason.ConfigurationFailed = nil;
---An error occurred in the RPC layer.
---
DebuggerEndReason.RpcError = nil;
Enum.DebuggerEndReason = DebuggerEndReason;
---@diagnostic disable-next-line
---@alias DebuggerEndReason Enum.DebuggerEndReason
---@class Enum.DebuggerExceptionBreakMode
---@field public Never number | '0'
---@field public Unhandled number | '1'
---@field public Always number | '2'
local DebuggerExceptionBreakMode;
---
DebuggerExceptionBreakMode.Never = nil;
---
DebuggerExceptionBreakMode.Unhandled = nil;
---
DebuggerExceptionBreakMode.Always = nil;
Enum.DebuggerExceptionBreakMode = DebuggerExceptionBreakMode;
---@diagnostic disable-next-line
---@alias DebuggerExceptionBreakMode Enum.DebuggerExceptionBreakMode
---@class Enum.DebuggerFrameType
---@field public C number | '0'
---@field public Lua number | '1'
---Call stack frame type.
---
local DebuggerFrameType;
---Call stack frame belongs to a C (native) function.
---
DebuggerFrameType.C = nil;
---Call stack frame belongs to a Lua function.
---
DebuggerFrameType.Lua = nil;
Enum.DebuggerFrameType = DebuggerFrameType;
---@diagnostic disable-next-line
---@alias DebuggerFrameType Enum.DebuggerFrameType
---@class Enum.DebuggerPauseReason
---@field public Unknown number | '0'
---@field public Requested number | '1'
---@field public Breakpoint number | '2'
---@field public Exception number | '3'
---@field public SingleStep number | '4'
---@field public Entrypoint number | '5'
---Reason that the DataModel was paused.
---
local DebuggerPauseReason;
---Pausing for a reason not covered by other values.
---
DebuggerPauseReason.Unknown = nil;
---Pause was requested by user.
---
DebuggerPauseReason.Requested = nil;
---Pausing on a user breakpoint.
---
DebuggerPauseReason.Breakpoint = nil;
---Pausing on error hit in the code.
---
DebuggerPauseReason.Exception = nil;
---Pausing on an internal breakpoint set by debugger command: e.g. step over,
---step into, step out of.
---
DebuggerPauseReason.SingleStep = nil;
---Pausing at the entry on the script.
---
DebuggerPauseReason.Entrypoint = nil;
Enum.DebuggerPauseReason = DebuggerPauseReason;
---@diagnostic disable-next-line
---@alias DebuggerPauseReason Enum.DebuggerPauseReason
---@class Enum.DebuggerStatus
---@field public Success number | '0'
---@field public Timeout number | '1'
---@field public ConnectionLost number | '2'
---@field public InvalidResponse number | '3'
---@field public InternalError number | '4'
---@field public InvalidState number | '5'
---@field public RpcError number | '6'
---@field public InvalidArgument number | '7'
---@field public ConnectionClosed number | '8'
---Result of a debugger request.
---
local DebuggerStatus;
---Request has completed successfully.
---
DebuggerStatus.Success = nil;
---Timed out while waiting for response.
---
DebuggerStatus.Timeout = nil;
---Connection to the debugger was lost.
---
DebuggerStatus.ConnectionLost = nil;
---Failed to parse response.
---
DebuggerStatus.InvalidResponse = nil;
---Exception encountered while processing response.
---
DebuggerStatus.InternalError = nil;
---The request was not appropriate for the current debugger state.
---
DebuggerStatus.InvalidState = nil;
---Response was an error.
---
DebuggerStatus.RpcError = nil;
---One of the request arguments was invalid.
---
DebuggerStatus.InvalidArgument = nil;
---Connection closed while waiting for response.
---
DebuggerStatus.ConnectionClosed = nil;
Enum.DebuggerStatus = DebuggerStatus;
---@diagnostic disable-next-line
---@alias DebuggerStatus Enum.DebuggerStatus
---@class Enum.DevCameraOcclusionMode
---@field public Zoom number | '0'
---@field public Invisicam number | '1'
---Determines how the default camera handles objects that are in-between the
---camera and the camera subject.
---
local DevCameraOcclusionMode;
---Camera will zoom in until there is nothing between the player and camera.
---
DevCameraOcclusionMode.Zoom = nil;
---Any objects between the camera and player will become translucent locally.
---
DevCameraOcclusionMode.Invisicam = nil;
Enum.DevCameraOcclusionMode = DevCameraOcclusionMode;
---@diagnostic disable-next-line
---@alias DevCameraOcclusionMode Enum.DevCameraOcclusionMode
---@class Enum.DevComputerCameraMovementMode
---@field public UserChoice number | '0'
---@field public Classic number | '1'
---@field public Follow number | '2'
---@field public Orbital number | '3'
---@field public CameraToggle number | '4'
---Overwrites the player's camera movement mode setting on a computer.
---
local DevComputerCameraMovementMode;
---The camera will move based on the player's settings.
---
DevComputerCameraMovementMode.UserChoice = nil;
---Camera tracks the player but will not automatically rotate if the player
---walks left or right.
---
DevComputerCameraMovementMode.Classic = nil;
---Camera tracks the player and automatically rotates if the player walks
---left or right.
---
DevComputerCameraMovementMode.Follow = nil;
---The camera has a fixed Y position, but can be rotated around the player.
---
DevComputerCameraMovementMode.Orbital = nil;
---The camera toggles between locked and free rotation with the right mouse
---button.
---
DevComputerCameraMovementMode.CameraToggle = nil;
Enum.DevComputerCameraMovementMode = DevComputerCameraMovementMode;
---@diagnostic disable-next-line
---@alias DevComputerCameraMovementMode Enum.DevComputerCameraMovementMode
---@class Enum.DevComputerMovementMode
---@field public UserChoice number | '0'
---@field public KeyboardMouse number | '1'
---@field public ClickToMove number | '2'
---@field public Scriptable number | '3'
---Sets the movement mode of players who are playing on computers.
---
local DevComputerMovementMode;
---The player's character will moved based on the user's settings.
---
DevComputerMovementMode.UserChoice = nil;
---The player's character will be controlled using the keyboard and mouse.
---
DevComputerMovementMode.KeyboardMouse = nil;
---The player can right click in the game world and the character will move
---there. Player can also control character with mouse and keyboard.
---
DevComputerMovementMode.ClickToMove = nil;
---The player will not respond to default controls. You must define any
---character movement in custom scripts.
---
DevComputerMovementMode.Scriptable = nil;
Enum.DevComputerMovementMode = DevComputerMovementMode;
---@diagnostic disable-next-line
---@alias DevComputerMovementMode Enum.DevComputerMovementMode
---@class Enum.DevTouchCameraMovementMode
---@field public UserChoice number | '0'
---@field public Classic number | '1'
---@field public Follow number | '2'
---@field public Orbital number | '3'
---Overwrites the camera mode if the player is on a touch device.
---
local DevTouchCameraMovementMode;
---The camera will move based on the player's settings.
---
DevTouchCameraMovementMode.UserChoice = nil;
---Camera tracks the player but will not automatically rotate if the player
---walks left or right.
---
DevTouchCameraMovementMode.Classic = nil;
---Camera tracks the player and automatically rotates if the player walks
---left or right.
---
DevTouchCameraMovementMode.Follow = nil;
---The camera has a fixed Y position, but can be rotated around the player.
---
DevTouchCameraMovementMode.Orbital = nil;
Enum.DevTouchCameraMovementMode = DevTouchCameraMovementMode;
---@diagnostic disable-next-line
---@alias DevTouchCameraMovementMode Enum.DevTouchCameraMovementMode
---@class Enum.DevTouchMovementMode
---@field public UserChoice number | '0'
---@field public Thumbstick number | '1'
---@field public DPad number | '2'
---@field public Thumbpad number | '3'
---@field public ClickToMove number | '4'
---@field public Scriptable number | '5'
---@field public DynamicThumbstick number | '6'
---Overrides the movement mode of players who are playing on touch devices.
---
local DevTouchMovementMode;
---The player's character will moved based on the user's settings.
---
DevTouchMovementMode.UserChoice = nil;
---The player's character is controlled with a virtual thumbstick that moves
---with the player's finger. Jumping is controlled with a separate button.
---
DevTouchMovementMode.Thumbstick = nil;
---The player's character is controlled with a virtual dpad. The dpad
---consists of directional buttons with a jump button in the middle.
---
DevTouchMovementMode.DPad = nil;
---The player's character is controlled with a virtual thumbpad that stays
---stationary as the player's finger moves. Jumping is controlled with a
---separate button.
---
DevTouchMovementMode.Thumbpad = nil;
---The player's character will attempt to move to a location in the world
---when the player taps a location.
---
DevTouchMovementMode.ClickToMove = nil;
---The player will not respond to default controls; any character movement
---must be defined in custom scripts.
---
DevTouchMovementMode.Scriptable = nil;
---The player's character is controlled with a virtual thumbstick that
---appears when they touch the lower portion of the screen. Jumping is
---controlled with a separate button. Good for portrait mode and one handed
---play.
---
DevTouchMovementMode.DynamicThumbstick = nil;
Enum.DevTouchMovementMode = DevTouchMovementMode;
---@diagnostic disable-next-line
---@alias DevTouchMovementMode Enum.DevTouchMovementMode
---@class Enum.DeveloperMemoryTag
---@field public Internal number | '0'
---@field public HttpCache number | '1'
---@field public Instances number | '2'
---@field public Signals number | '3'
---@field public LuaHeap number | '4'
---@field public Script number | '5'
---@field public PhysicsCollision number | '6'
---@field public PhysicsParts number | '7'
---@field public GraphicsSolidModels number | '8'
---@field public GraphicsMeshParts number | '10'
---@field public GraphicsParticles number | '11'
---@field public GraphicsParts number | '12'
---@field public GraphicsSpatialHash number | '13'
---@field public GraphicsTerrain number | '14'
---@field public GraphicsTexture number | '15'
---@field public GraphicsTextureCharacter number | '16'
---@field public Sounds number | '17'
---@field public StreamingSounds number | '18'
---@field public TerrainVoxels number | '19'
---@field public Gui number | '21'
---@field public Animation number | '22'
---@field public Navigation number | '23'
---@field public GeometryCSG number | '24'
---A list of memory categories, and a description of what they are allocated to.
---
local DeveloperMemoryTag;
---General data that doesn't have any categorization. This could be due to
---either internal reasons, or because it simply isn't being tracked
---categorically.
---
DeveloperMemoryTag.Internal = nil;
---A cache of HTTP responses.
---
DeveloperMemoryTag.HttpCache = nil;
---All the Instances present in memory.
---
DeveloperMemoryTag.Instances = nil;
---Events, signals, connections, etc.
---
DeveloperMemoryTag.Signals = nil;
---All of the data in Lua. this includes everything happening in CoreScripts,
---the built-in datatypes, etc.
---
DeveloperMemoryTag.LuaHeap = nil;
---All memory being manipulated and referenced by scripts.
---
DeveloperMemoryTag.Script = nil;
---Collision detection in the Workspace.
---
DeveloperMemoryTag.PhysicsCollision = nil;
---Physics bodies and the components that control their behavior.
---
DeveloperMemoryTag.PhysicsParts = nil;
---Rendering solid models (stuff made with Union, Negate, etc.).
---
DeveloperMemoryTag.GraphicsSolidModels = nil;
---Rendering of mesh parts.
---
DeveloperMemoryTag.GraphicsMeshParts = nil;
---Rendering of particles from ParticleEmitters.
---
DeveloperMemoryTag.GraphicsParticles = nil;
---Rendering of regular parts.
---
DeveloperMemoryTag.GraphicsParts = nil;
---Spatial hash lookup tables of the game world that are used for rendering.
---
DeveloperMemoryTag.GraphicsSpatialHash = nil;
---Rendering of terrain geometry.
---
DeveloperMemoryTag.GraphicsTerrain = nil;
---Rendering of textures in the game world.
---
DeveloperMemoryTag.GraphicsTexture = nil;
---Rendering of texture composition maps that are generated for Humanoids.
---
DeveloperMemoryTag.GraphicsTextureCharacter = nil;
---Data of sounds in-game.
---
DeveloperMemoryTag.Sounds = nil;
---Playback of sounds in-game.
---
DeveloperMemoryTag.StreamingSounds = nil;
---Occupancy/Material data of the Terrain.
---
DeveloperMemoryTag.TerrainVoxels = nil;
---Gui element data and rendering.
---
DeveloperMemoryTag.Gui = nil;
---Playback of Animations on Humanoids and AnimationControllers.
---
DeveloperMemoryTag.Animation = nil;
---Pathfinding for Humanoids via the PathfindingService.
---
DeveloperMemoryTag.Navigation = nil;
---
DeveloperMemoryTag.GeometryCSG = nil;
Enum.DeveloperMemoryTag = DeveloperMemoryTag;
---@diagnostic disable-next-line
---@alias DeveloperMemoryTag Enum.DeveloperMemoryTag
---@class Enum.DeviceType
---@field public Unknown number | '0'
---@field public Desktop number | '1'
---@field public Tablet number | '2'
---@field public Phone number | '3'
---The DeviceType Enum is used to determine the category of devices that a client
---belongs to.
---
---Currently this can only be used in `CoreScript`s.
---
local DeviceType;
---The client is an unknown device.
---
DeviceType.Unknown = nil;
---The client is a desktop device.
---
DeviceType.Desktop = nil;
---The client is a tablet device.
---
DeviceType.Tablet = nil;
---The client is a phone device.
---
DeviceType.Phone = nil;
Enum.DeviceType = DeviceType;
---@diagnostic disable-next-line
---@alias DeviceType Enum.DeviceType
---@class Enum.DialogBehaviorType
---@field public SinglePlayer number | '0'
---@field public MultiplePlayers number | '1'
---Controls whether multiple people can use this dialog, or only one person at a
---time can use it.
---
local DialogBehaviorType;
---Only one player can interact with this dialog at a time. The conversation
---between the player and dialog can be seen by all players.
---
DialogBehaviorType.SinglePlayer = nil;
---Multiple players can simultaneously interact with this dialog. The
---conversation between the player and the dialog cannot be seen by other
---players.
---
DialogBehaviorType.MultiplePlayers = nil;
Enum.DialogBehaviorType = DialogBehaviorType;
---@diagnostic disable-next-line
---@alias DialogBehaviorType Enum.DialogBehaviorType
---@class Enum.DialogPurpose
---@field public Quest number | '0'
---@field public Help number | '1'
---@field public Shop number | '2'
---The DialogPurpose enum is used to set the icon of a `Dialog`.
---
local DialogPurpose;
---Shows an exclamation point ('''!''').
---
DialogPurpose.Quest = nil;
---Shows a question mark ('''?''').
---
DialogPurpose.Help = nil;
---Shows a dollar sign ('''$''').
---
DialogPurpose.Shop = nil;
Enum.DialogPurpose = DialogPurpose;
---@diagnostic disable-next-line
---@alias DialogPurpose Enum.DialogPurpose
---@class Enum.DialogTone
---@field public Neutral number | '0'
---@field public Friendly number | '1'
---@field public Enemy number | '2'
---Sets the `Dialog/Tone` of a `Dialog` object, which influences how the dialog
---appears.
---
local DialogTone;
---Causes the dialog to have a blue bar on its left-hand side.
---
DialogTone.Neutral = nil;
---Causes the dialog to have a green bar on its left-hand side.
---
DialogTone.Friendly = nil;
---Causes the dialog to have a red bar on its left-hand side.
---
DialogTone.Enemy = nil;
Enum.DialogTone = DialogTone;
---@diagnostic disable-next-line
---@alias DialogTone Enum.DialogTone
---@class Enum.DominantAxis
---@field public Width number | '0'
---@field public Height number | '1'
---Used by `UIAspectRatioConstraint/DominantAxis` to specify which axis is used
---when setting the new size of the GUI element.
---
local DominantAxis;
---The X axis.
---
DominantAxis.Width = nil;
---The Y axis.
---
DominantAxis.Height = nil;
Enum.DominantAxis = DominantAxis;
---@diagnostic disable-next-line
---@alias DominantAxis Enum.DominantAxis
---@class Enum.DraftStatusCode
---@field public OK number | '0'
---@field public DraftOutdated number | '1'
---@field public ScriptRemoved number | '2'
---@field public DraftCommitted number | '3'
local DraftStatusCode;
---
DraftStatusCode.OK = nil;
---
DraftStatusCode.DraftOutdated = nil;
---
DraftStatusCode.ScriptRemoved = nil;
---
DraftStatusCode.DraftCommitted = nil;
Enum.DraftStatusCode = DraftStatusCode;
---@diagnostic disable-next-line
---@alias DraftStatusCode Enum.DraftStatusCode
---@class Enum.DraggerCoordinateSpace
---@field public Object number | '0'
---@field public World number | '1'
local DraggerCoordinateSpace;
---
DraggerCoordinateSpace.Object = nil;
---
DraggerCoordinateSpace.World = nil;
Enum.DraggerCoordinateSpace = DraggerCoordinateSpace;
---@diagnostic disable-next-line
---@alias DraggerCoordinateSpace Enum.DraggerCoordinateSpace
---@class Enum.DraggerMovementMode
---@field public Geometric number | '0'
---@field public Physical number | '1'
local DraggerMovementMode;
---
DraggerMovementMode.Geometric = nil;
---
DraggerMovementMode.Physical = nil;
Enum.DraggerMovementMode = DraggerMovementMode;
---@diagnostic disable-next-line
---@alias DraggerMovementMode Enum.DraggerMovementMode
---@class Enum.EasingDirection
---@field public In number | '0'
---@field public Out number | '1'
---@field public InOut number | '2'
---Pass to `TweenInfo|TweenInto.new` to control the direction `Tween|Tweens` play
---in. The animation below demonstrates the different options using
---`enum/EasingStyle|EasingStyle.Quad`.
---
---<img src="/assets/blt9231861ad966495f/EasingDirection.gif" />
---
local EasingDirection;
---The easing style is applied in a forward direction. (See animation).
---
EasingDirection.In = nil;
---The easing style is applied in a reverse direction. (See animation).
---
EasingDirection.Out = nil;
---The easing style is applied forward for the first half and in reverse for
---the second half.
---
EasingDirection.InOut = nil;
Enum.EasingDirection = EasingDirection;
---@diagnostic disable-next-line
---@alias EasingDirection Enum.EasingDirection
---@class Enum.EasingStyle
---@field public Linear number | '0'
---@field public Sine number | '1'
---@field public Back number | '2'
---@field public Quad number | '3'
---@field public Quart number | '4'
---@field public Quint number | '5'
---@field public Bounce number | '6'
---@field public Elastic number | '7'
---@field public Exponential number | '8'
---@field public Circular number | '9'
---@field public Cubic number | '10'
---Passed to `TweenInfo|TweenInfo.new` to control the motion of a `Tween`. Each
---easing style is described in a graph below. The X axis is a value passed to
---`TweenService/GetValue` and the Y axis is the value returned.
---
---This diagram uses `Enum/EasingDirection|EasingDirection.In`. The
---`Enum/EasingDirection|EasingDirection.Out` version of the diagram is a
---reflection flipped in both directions, and the `InOut` version is the In and
---Out versions stuck together.
---
---![Easing style graphs][1]
---
---The following is an animation demonstrating how each `Enum/EasingDirection`
---acts when used with `GuiObject/TweenPosition`. Note that some EasingStyles
---(Elastic and Back) will go **further** than the UDim2s involved in the tween
---(in the case of this animation, the start Positions and end Positions of the
---`TextLabel`s).
---
---![enter image description here][2]
---
---[1]: /assets/blt6e86ddaa7953f358/EasingStyles.jpg
---[2]: /assets/blt164bc3fd53630e3a/Easingstyle.gif
---
local EasingStyle;
---Moves at a constant speed.
---
EasingStyle.Linear = nil;
---Speed is determined by a sine wave.
---
EasingStyle.Sine = nil;
---Slightly overshoots, then backs into place.
---
EasingStyle.Back = nil;
---Slows down as it approaches the end.
---
EasingStyle.Quad = nil;
---Similar to Quad, but starts at a higher speed.
---
EasingStyle.Quart = nil;
---Similar to Quart, but starts at a higher speed.
---
EasingStyle.Quint = nil;
---Bounces backwards multiple times after reaching the end position, before
---eventually settling.
---
EasingStyle.Bounce = nil;
---Moves as if the GUI element is attached to a rubber band, overshooting its
---target several times.
---
EasingStyle.Elastic = nil;
---Slows down very quickly as it approaches the end.
---
EasingStyle.Exponential = nil;
---Follows a circlular arc, slowing down as it approaches the end.
---
EasingStyle.Circular = nil;
---Similar to Quad, but starts at a lower speed.
---
EasingStyle.Cubic = nil;
Enum.EasingStyle = EasingStyle;
---@diagnostic disable-next-line
---@alias EasingStyle Enum.EasingStyle
---@class Enum.ElasticBehavior
---@field public WhenScrollable number | '0'
---@field public Always number | '1'
---@field public Never number | '2'
---This enum is used by `ScrollingFrame/ElasticBehavior` to control when elastic
---scrolling is active for a `ScrollingFrame`.
---
local ElasticBehavior;
---The scrollbar will be elastic when there is content to be scrolled to.
---
ElasticBehavior.WhenScrollable = nil;
---The scrollbar will always have elastic scrolling available, even when
---there isn't content available to scroll to.
---
ElasticBehavior.Always = nil;
---The scrollbar will never have elastic scrolling available.
---
ElasticBehavior.Never = nil;
Enum.ElasticBehavior = ElasticBehavior;
---@diagnostic disable-next-line
---@alias ElasticBehavior Enum.ElasticBehavior
---@class Enum.EnviromentalPhysicsThrottle
---@field public DefaultAuto number | '0'
---@field public Disabled number | '1'
---@field public Always number | '2'
---@field public Skip2 number | '3'
---@field public Skip4 number | '4'
---@field public Skip8 number | '5'
---@field public Skip16 number | '6'
local EnviromentalPhysicsThrottle;
---
EnviromentalPhysicsThrottle.DefaultAuto = nil;
---
EnviromentalPhysicsThrottle.Disabled = nil;
---
EnviromentalPhysicsThrottle.Always = nil;
---
EnviromentalPhysicsThrottle.Skip2 = nil;
---
EnviromentalPhysicsThrottle.Skip4 = nil;
---
EnviromentalPhysicsThrottle.Skip8 = nil;
---
EnviromentalPhysicsThrottle.Skip16 = nil;
Enum.EnviromentalPhysicsThrottle = EnviromentalPhysicsThrottle;
---@diagnostic disable-next-line
---@alias EnviromentalPhysicsThrottle Enum.EnviromentalPhysicsThrottle
---@class Enum.ExplosionType
---@field public NoCraters number | '0'
---@field public Craters number | '1'
---The ExplosionType Enum is used to set the `Explosion/ExplosionType` property.
---
local ExplosionType;
---Explosion does not generate craters.
---
ExplosionType.NoCraters = nil;
---Explosion generates craters.
---
ExplosionType.Craters = nil;
Enum.ExplosionType = ExplosionType;
---@diagnostic disable-next-line
---@alias ExplosionType Enum.ExplosionType
---@class Enum.FieldOfViewMode
---@field public Vertical number | '0'
---@field public Diagonal number | '1'
---@field public MaxAxis number | '2'
local FieldOfViewMode;
---
FieldOfViewMode.Vertical = nil;
---
FieldOfViewMode.Diagonal = nil;
---
FieldOfViewMode.MaxAxis = nil;
Enum.FieldOfViewMode = FieldOfViewMode;
---@diagnostic disable-next-line
---@alias FieldOfViewMode Enum.FieldOfViewMode
---@class Enum.FillDirection
---@field public Horizontal number | '0'
---@field public Vertical number | '1'
---Used by `UIGridStyleLayout/FillDirection` to control which direction elements
---are placed.
---
local FillDirection;
---Fill in the left to right direction.
---
FillDirection.Horizontal = nil;
---Fill in the top to bottom direction.
---
FillDirection.Vertical = nil;
Enum.FillDirection = FillDirection;
---@diagnostic disable-next-line
---@alias FillDirection Enum.FillDirection
---@class Enum.FilterResult
---@field public Rejected number | '1'
---@field public Accepted number | '0'
---Used to determine the result of a text filter request.
---
local FilterResult;
---Text rejected by filter.
---
FilterResult.Rejected = nil;
---Text accepted by filter.
---
FilterResult.Accepted = nil;
Enum.FilterResult = FilterResult;
---@diagnostic disable-next-line
---@alias FilterResult Enum.FilterResult
---@class Enum.Font
---@field public AmaticSC number | '21'
---@field public Antique number | '15'
---@field public Arcade number | '13'
---@field public Arial number | '1'
---@field public ArialBold number | '2'
---@field public Bangers number | '22'
---@field public Bodoni number | '7'
---@field public Cartoon number | '9'
---@field public Code number | '10'
---@field public Creepster number | '23'
---@field public DenkOne number | '24'
---@field public Fantasy number | '14'
---@field public Fondamento number | '25'
---@field public FredokaOne number | '26'
---@field public Garamond number | '8'
---@field public Gotham number | '17'
---@field public GothamBlack number | '20'
---@field public GothamBold number | '19'
---@field public GothamSemibold number | '18'
---@field public GrenzeGotisch number | '27'
---@field public Highway number | '11'
---@field public IndieFlower number | '28'
---@field public JosefinSans number | '29'
---@field public Jura number | '30'
---@field public Kalam number | '31'
---@field public Legacy number | '0'
---@field public LuckiestGuy number | '32'
---@field public Merriweather number | '33'
---@field public Michroma number | '34'
---@field public Nunito number | '35'
---@field public Oswald number | '36'
---@field public PatrickHand number | '37'
---@field public PermanentMarker number | '38'
---@field public Roboto number | '39'
---@field public RobotoCondensed number | '40'
---@field public RobotoMono number | '41'
---@field public Sarpanch number | '42'
---@field public SciFi number | '12'
---@field public SourceSans number | '3'
---@field public SourceSansBold number | '4'
---@field public SourceSansItalic number | '6'
---@field public SourceSansLight number | '5'
---@field public SourceSansSemibold number | '16'
---@field public SpecialElite number | '43'
---@field public TitilliumWeb number | '44'
---@field public Ubuntu number | '45'
---@field public Unknown number | '100'
---The Font enum is used in `TextBox`, `TextLabel`, and `TextButton` to determine
---how the GUI element will render its text.
---
local Font;
---<img width="80%" src="/assets/engine-api/enums/Font-AmaticSC.png" />.
---
Font.AmaticSC = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Antique.png" />.
---
Font.Antique = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Arcade.png" />.
---
Font.Arcade = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Arial.png" />.
---
Font.Arial = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-ArialBold.png" />.
---
Font.ArialBold = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Bangers.png" />.
---
Font.Bangers = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Bodoni.png" />.
---
Font.Bodoni = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Cartoon.png" />.
---
Font.Cartoon = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Code.png" />.
---
Font.Code = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Creepster.png" />.
---
Font.Creepster = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-DenkOne.png" />.
---
Font.DenkOne = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Fantasy.png" />.
---
Font.Fantasy = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Fondamento.png" />.
---
Font.Fondamento = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-FredokaOne.png" />.
---
Font.FredokaOne = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Garamond.png" />.
---
Font.Garamond = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Gotham.png" />.
---
Font.Gotham = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-GothamBlack.png" />.
---
Font.GothamBlack = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-GothamBold.png" />.
---
Font.GothamBold = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-GothamSemibold.png" />.
---
Font.GothamSemibold = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-GrenzeGotisch.png" />.
---
Font.GrenzeGotisch = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Highway.png" />.
---
Font.Highway = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-IndieFlower.png" />.
---
Font.IndieFlower = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-JosefinSans.png" />.
---
Font.JosefinSans = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Jura.png" />.
---
Font.Jura = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Kalam.png" />.
---
Font.Kalam = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Legacy.png" />.
---
Font.Legacy = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-LuckiestGuy.png" />.
---
Font.LuckiestGuy = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Merriweather.png" />.
---
Font.Merriweather = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Michroma.png" />.
---
Font.Michroma = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Nunito.png" />.
---
Font.Nunito = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Oswald.png" />.
---
Font.Oswald = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-PatrickHand.png" />.
---
Font.PatrickHand = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-PermanentMarker.png" />.
---
Font.PermanentMarker = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Roboto.png" />.
---
Font.Roboto = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-RobotoCondensed.png" />.
---
Font.RobotoCondensed = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-RobotoMono.png" />.
---
Font.RobotoMono = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Sarpanch.png" />.
---
Font.Sarpanch = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-SciFi.png" />.
---
Font.SciFi = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-SourceSans.png" />.
---
Font.SourceSans = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-SourceSansBold.png" />.
---
Font.SourceSansBold = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-SourceSansItalic.png" />.
---
Font.SourceSansItalic = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-SourceSansLight.png" />.
---
Font.SourceSansLight = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-SourceSansSemibold.png" />.
---
Font.SourceSansSemibold = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-SpecialElite.png" />.
---
Font.SpecialElite = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-TitilliumWeb.png" />.
---
Font.TitilliumWeb = nil;
---<img width="80%" src="/assets/engine-api/enums/Font-Ubuntu.png" />.
---
Font.Ubuntu = nil;
---
Font.Unknown = nil;
Enum.Font = Font;
---@diagnostic disable-next-line
---@alias Font Enum.Font
---@class Enum.FontSize
---@field public Size8 number | '0'
---@field public Size9 number | '1'
---@field public Size10 number | '2'
---@field public Size11 number | '3'
---@field public Size12 number | '4'
---@field public Size14 number | '5'
---@field public Size18 number | '6'
---@field public Size24 number | '7'
---@field public Size36 number | '8'
---@field public Size48 number | '9'
---@field public Size28 number | '10'
---@field public Size32 number | '11'
---@field public Size42 number | '12'
---@field public Size60 number | '13'
---@field public Size96 number | '14'
---The FontSize Enum controls the font size of text in `TextBox`, `TextLabel`,
---and `TextButton` objects.
---
local FontSize;
---Font size 8.
---
FontSize.Size8 = nil;
---Font size 9.
---
FontSize.Size9 = nil;
---Font size 10.
---
FontSize.Size10 = nil;
---Font size 11.
---
FontSize.Size11 = nil;
---Font size 12.
---
FontSize.Size12 = nil;
---Font size 14.
---
FontSize.Size14 = nil;
---Font size 18.
---
FontSize.Size18 = nil;
---Font size 24.
---
FontSize.Size24 = nil;
---Font size 36.
---
FontSize.Size36 = nil;
---Font size 48.
---
FontSize.Size48 = nil;
---Font size 28.
---
FontSize.Size28 = nil;
---Font size 32.
---
FontSize.Size32 = nil;
---Font size 42.
---
FontSize.Size42 = nil;
---Font size 60.
---
FontSize.Size60 = nil;
---Font size 96.
---
FontSize.Size96 = nil;
Enum.FontSize = FontSize;
---@diagnostic disable-next-line
---@alias FontSize Enum.FontSize
---@class Enum.FontStyle
---@field public Normal number | '0'
---@field public Italic number | '1'
local FontStyle;
---
FontStyle.Normal = nil;
---
FontStyle.Italic = nil;
Enum.FontStyle = FontStyle;
---@diagnostic disable-next-line
---@alias FontStyle Enum.FontStyle
---@class Enum.FontWeight
---@field public Thin number | '100'
---@field public ExtraLight number | '200'
---@field public Light number | '300'
---@field public Regular number | '400'
---@field public Medium number | '500'
---@field public SemiBold number | '600'
---@field public Bold number | '700'
---@field public ExtraBold number | '800'
---@field public Heavy number | '900'
local FontWeight;
---
FontWeight.Thin = nil;
---
FontWeight.ExtraLight = nil;
---
FontWeight.Light = nil;
---
FontWeight.Regular = nil;
---
FontWeight.Medium = nil;
---
FontWeight.SemiBold = nil;
---
FontWeight.Bold = nil;
---
FontWeight.ExtraBold = nil;
---
FontWeight.Heavy = nil;
Enum.FontWeight = FontWeight;
---@diagnostic disable-next-line
---@alias FontWeight Enum.FontWeight
---@class Enum.FormFactor
---@field public Symmetric number | '0'
---@field public Brick number | '1'
---@field public Plate number | '2'
---@field public Custom number | '3'
---The FormFactor Enum for `FormFactorPart/FormFactor`.
---
---Minimum size along a given axis is 1 \* RateOfIncrease for that axis, except
---in the case of the "Custom" FormFactor, which has a minimum size of 0.2 along
---all axes.
---
local FormFactor;
---Increases by a rate of 1 along all axes.
---
FormFactor.Symmetric = nil;
---Increases by a rate of 1 along the x- and z- axes, 1.2 along the y-axis.
---
FormFactor.Brick = nil;
---Increases by a rate of 1 along the x- and z- axes, 0.4 along the y-axis.
---
FormFactor.Plate = nil;
---Increases by a rate as low as .001 along all axes.
---
FormFactor.Custom = nil;
Enum.FormFactor = FormFactor;
---@diagnostic disable-next-line
---@alias FormFactor Enum.FormFactor
---@class Enum.FrameStyle
---@field public Custom number | '0'
---@field public ChatBlue number | '1'
---@field public RobloxSquare number | '2'
---@field public RobloxRound number | '3'
---@field public ChatGreen number | '4'
---@field public ChatRed number | '5'
---@field public DropShadow number | '6'
---The FrameStyle Enum is used to set the style of a `Frame`. Below is a
---comparison of all seven frame styles. The TextLabels are positioned at the
---top-left corner of the frame (at the `DataType/UDim2` value of
---`{{0, 0}, {0, 0}}`).
---
---## Example
---
---Below is a screenshot containing all seven frame styles.
---![The seven frame styles][1]
---
---[1]: /assets/blte94588e14ec23e3c/FrameStyle.png
---
local FrameStyle;
---Uses the frame's `GuiObject/BackgroundColor3`, `GuiObject/BorderColor3`,
---and `GuiObject/BackgroundTransparency` properties to determine the frame's
---appearance. It has no padding; elements with the position
---`{{0, 0}, {0, 0}}` will appear at the frame's top-left corner.
---
FrameStyle.Custom = nil;
---Causes the frame to appear similar to a `Dialog` with its `Dialog/Tone`
---property set to `Enum/DialogTone` neutral. This has a padding of fifteen
---pixels on all sides.
---
FrameStyle.ChatBlue = nil;
---Causes the frame to appear as a translucent dark gray rectangle with a
---padding of five pixels on all sides.
---
FrameStyle.RobloxSquare = nil;
---Causes the frame to appear as a translucent dark gray rectangle with
---rounded edges. Like "RobloxSquare" this has a padding of five pixels on
---all sides.
---
FrameStyle.RobloxRound = nil;
---Causes the frame to appear similar to a Dialog with its Tone property set
---to "Friendly." Like "ChatBlue" this has a padding of fifteen pixels on all
---sides.
---
FrameStyle.ChatGreen = nil;
---Causes the frame to appear similar to a Dialog with its Tone property set
---to "Enemy." Like "ChatBlue" and "ChatGreen" this has a padding of fifteen
---pixels on all sides.
---
FrameStyle.ChatRed = nil;
---Causes the frame to appear as a translucent gray rectangle with blurred
---sides. The blur is more apparent on the bottom edge. It has a padding of
---eight pixels on all sides.
---
FrameStyle.DropShadow = nil;
Enum.FrameStyle = FrameStyle;
---@diagnostic disable-next-line
---@alias FrameStyle Enum.FrameStyle
---@class Enum.FramerateManagerMode
---@field public Automatic number | '0'
---@field public On number | '1'
---@field public Off number | '2'
local FramerateManagerMode;
---
FramerateManagerMode.Automatic = nil;
---
FramerateManagerMode.On = nil;
---
FramerateManagerMode.Off = nil;
Enum.FramerateManagerMode = FramerateManagerMode;
---@diagnostic disable-next-line
---@alias FramerateManagerMode Enum.FramerateManagerMode
---@class Enum.FriendRequestEvent
---@field public Issue number | '0'
---@field public Revoke number | '1'
---@field public Accept number | '2'
---@field public Deny number | '3'
---Describes the event when a player sends or responds to a friend request. This
---is used by the in-game friend request system.
---
local FriendRequestEvent;
---A player invokes (sends) a friend request.
---
FriendRequestEvent.Issue = nil;
---A player revokes (cancels) a previously invoked (sent) friend request.
---
FriendRequestEvent.Revoke = nil;
---A player accepts a friend request.
---
FriendRequestEvent.Accept = nil;
---A player denies a friend request.
---
FriendRequestEvent.Deny = nil;
Enum.FriendRequestEvent = FriendRequestEvent;
---@diagnostic disable-next-line
---@alias FriendRequestEvent Enum.FriendRequestEvent
---@class Enum.FriendStatus
---@field public Unknown number | '0'
---@field public NotFriend number | '1'
---@field public Friend number | '2'
---@field public FriendRequestSent number | '3'
---@field public FriendRequestReceived number | '4'
---Determines the friendship status between two players. This is used by the
---in-game friend request system.
---
local FriendStatus;
---The friendship status of two players is unknown.
---
FriendStatus.Unknown = nil;
---Two players are not friends.
---
FriendStatus.NotFriend = nil;
---Two players are friends.
---
FriendStatus.Friend = nil;
---At least one of two players has sent a friend request to the other player.
---
FriendStatus.FriendRequestSent = nil;
---At least one of two players has received a friend request sent by the
---other player.
---
FriendStatus.FriendRequestReceived = nil;
Enum.FriendStatus = FriendStatus;
---@diagnostic disable-next-line
---@alias FriendStatus Enum.FriendStatus
---@class Enum.FunctionalTestResult
---@field public Passed number | '0'
---@field public Warning number | '1'
---@field public Error number | '2'
---Represents the outcome of a single functional test run.
---
local FunctionalTestResult;
---The test run was successful.
---
FunctionalTestResult.Passed = nil;
---The test run is potentially unstable.
---
FunctionalTestResult.Warning = nil;
---The test run failed.
---
FunctionalTestResult.Error = nil;
Enum.FunctionalTestResult = FunctionalTestResult;
---@diagnostic disable-next-line
---@alias FunctionalTestResult Enum.FunctionalTestResult
---@class Enum.GameAvatarType
---@field public R6 number | '0'
---@field public R15 number | '1'
---@field public PlayerChoice number | '2'
---The value of this Enum indicates which type of avatar an experience uses. Some
---experiences may specify explicitly R6/R15, while some will allow the player's
---choice of avatar to be used.
---
local GameAvatarType;
---The R6 character rig.
---
GameAvatarType.R6 = nil;
---The R15 character rig.
---
GameAvatarType.R15 = nil;
---The rig (either R6 or R15) determined by a player's character settings set
---on the website in the 'Edit Avatar' page.
---
GameAvatarType.PlayerChoice = nil;
Enum.GameAvatarType = GameAvatarType;
---@diagnostic disable-next-line
---@alias GameAvatarType Enum.GameAvatarType
---@class Enum.GearGenreSetting
---@field public AllGenres number | '0'
---@field public MatchingGenreOnly number | '1'
---The GearGenreSetting Enum sets what types of gear are allowed in a place.
---
local GearGenreSetting;
---All gear genres are allowed.
---
GearGenreSetting.AllGenres = nil;
---Only gear genres matching the allowed genres specified in a place's
---configuration settings.
---
GearGenreSetting.MatchingGenreOnly = nil;
Enum.GearGenreSetting = GearGenreSetting;
---@diagnostic disable-next-line
---@alias GearGenreSetting Enum.GearGenreSetting
---@class Enum.GearType
---@field public MeleeWeapons number | '0'
---@field public RangedWeapons number | '1'
---@field public Explosives number | '2'
---@field public PowerUps number | '3'
---@field public NavigationEnhancers number | '4'
---@field public MusicalInstruments number | '5'
---@field public SocialItems number | '6'
---@field public BuildingTools number | '7'
---@field public Transport number | '8'
---The GearType Enum is used as an argument in `DataModel/IsGearTypeAllowed`.
---Gear may have more than one type/attribute.
---
local GearType;
---Gear with the 'Melee' attribute. ![Melee Attribute][1]
---
---[1]: /assets/bltb08afda60a136e61/GearType_Melee.png
---
---.
---
GearType.MeleeWeapons = nil;
---Gear with the 'Ranged' attribute. ![[Ranged Attribute][1]
---
---[1]: /assets/blt4aaa5534850ad583/GearType_Ranged.png
---
---.
---
GearType.RangedWeapons = nil;
---Gear with the 'Explosive' attribute. ![Explosive Attribute][1]
---
---[1]: /assets/blt9eee5ac8f58367c8/GearType_Explosive.png
---
---.
---
GearType.Explosives = nil;
---Gear with the 'Power Up' attribute. ![Power Up Attribute][1]
---
---[1]: /assets/blt0c97538d414a753b/GearType_PowerUp.png
---
---.
---
GearType.PowerUps = nil;
---Gear with the 'Navigation' attribute. ![Navigation Attribute][1]
---
---[1]: /assets/bltb4bbcb97611d3ab5/GearType_Navigation.png
---
---.
---
GearType.NavigationEnhancers = nil;
---Gear with the 'Musical' attribute. ![Musical Attribute][1]
---
---[1]: /assets/bltfc24574f48eb2125/GearType_Musical.png
---
---.
---
GearType.MusicalInstruments = nil;
---Gear with the 'Social' attribute. ![Social Attribute][1]
---
---[1]: /assets/bltd3ac42c4659a2371/GearType_Social.png
---
---.
---
GearType.SocialItems = nil;
---Gear with the 'Building' attribute. ![Building Attribute][1]
---
---[1]: /assets/blte36164ad978dbc99/GearType_Building.png
---
---.
---
GearType.BuildingTools = nil;
---Gear with the 'Transport' attribute. ![Transport Attribute][1]
---
---[1]: /assets/blt669c2a184782cd46/GearType_Transport.png
---
---.
---
GearType.Transport = nil;
Enum.GearType = GearType;
---@diagnostic disable-next-line
---@alias GearType Enum.GearType
---@class Enum.Genre
---@field public All number | '0'
---@field public TownAndCity number | '1'
---@field public Fantasy number | '2'
---@field public SciFi number | '3'
---@field public Ninja number | '4'
---@field public Scary number | '5'
---@field public Pirate number | '6'
---@field public Adventure number | '7'
---@field public Sports number | '8'
---@field public Funny number | '9'
---@field public WildWest number | '10'
---@field public War number | '11'
---@field public SkatePark number | '12'
---@field public Tutorial number | '13'
---Used to represent the type of game. This can be changed in the "Basic
---Settings" tab when configuring a place on the website.
---
local Genre;
---The game's genre is set to All. The game will be listed as all possible
---genres.
---
Genre.All = nil;
---The game's genre is set to Town and City.
---
Genre.TownAndCity = nil;
---The game's genre is set to Fantasy.
---
Genre.Fantasy = nil;
---The game's genre is set to SciFi (Science Fiction).
---
Genre.SciFi = nil;
---The game's genre is set to Ninja.
---
Genre.Ninja = nil;
---The game's genre is set to Scary.
---
Genre.Scary = nil;
---The game's genre is set to Pirate.
---
Genre.Pirate = nil;
---The game's genre is set to Adventure.
---
Genre.Adventure = nil;
---The game's genre is set to Sports.
---
Genre.Sports = nil;
---The game's genre is set to Funny.
---
Genre.Funny = nil;
---The game's genre is set to Wild West.
---
Genre.WildWest = nil;
---The game's genre is set to War.
---
Genre.War = nil;
---The game's genre is set to Skate Park.
---
Genre.SkatePark = nil;
---The game's genre is set to Tutorial.
---
Genre.Tutorial = nil;
Enum.Genre = Genre;
---@diagnostic disable-next-line
---@alias Genre Enum.Genre
---@class Enum.GraphicsMode
---@field public Automatic number | '1'
---@field public Direct3D11 number | '2'
---@field public OpenGL number | '4'
---@field public Metal number | '5'
---@field public Vulkan number | '6'
---@field public NoGraphics number | '7'
---Used to set the graphics API that Roblox uses to render the game.
---
local GraphicsMode;
---Roblox will automatically decide what graphics mode to use, depending on
---what best suits your device's specifications.
---
GraphicsMode.Automatic = nil;
---Direct3D Version 11 (Microsoft).
---
GraphicsMode.Direct3D11 = nil;
---OpenGL (Khronos Group).
---
GraphicsMode.OpenGL = nil;
---Metal (Apple).
---
GraphicsMode.Metal = nil;
---Vulkan (Khronos Group).
---
GraphicsMode.Vulkan = nil;
---Game will not be rendered, and instead a _Diagnostics_ window is rendered
---on screen.
---
GraphicsMode.NoGraphics = nil;
Enum.GraphicsMode = GraphicsMode;
---@diagnostic disable-next-line
---@alias GraphicsMode Enum.GraphicsMode
---@class Enum.HandlesStyle
---@field public Resize number | '0'
---@field public Movement number | '1'
local HandlesStyle;
---
HandlesStyle.Resize = nil;
---
HandlesStyle.Movement = nil;
Enum.HandlesStyle = HandlesStyle;
---@diagnostic disable-next-line
---@alias HandlesStyle Enum.HandlesStyle
---@class Enum.HighlightDepthMode
---@field public AlwaysOnTop number | '0'
---@field public Occluded number | '1'
local HighlightDepthMode;
---
HighlightDepthMode.AlwaysOnTop = nil;
---
HighlightDepthMode.Occluded = nil;
Enum.HighlightDepthMode = HighlightDepthMode;
---@diagnostic disable-next-line
---@alias HighlightDepthMode Enum.HighlightDepthMode
---@class Enum.HorizontalAlignment
---@field public Center number | '0'
---@field public Left number | '1'
---@field public Right number | '2'
---Used by `UIGridStyleLayout/HorizontalAlignment` to align the layout within its
---parent.
---
local HorizontalAlignment;
---The grid is placed at the center of its parent (x-direction), extending
---equally to the left and right of the center according to the size of the
---grid relative to the x-axis.
---
HorizontalAlignment.Center = nil;
---The grid is placed starting along the left edge of the parent, extending
---to the right according to the size of the grid relative to the x-axis.
---
HorizontalAlignment.Left = nil;
---The grid is placed starting along the left edge of the parent, extending
---to the left according to the size of the grid relative to the x-axis.
---
HorizontalAlignment.Right = nil;
Enum.HorizontalAlignment = HorizontalAlignment;
---@diagnostic disable-next-line
---@alias HorizontalAlignment Enum.HorizontalAlignment
---@class Enum.HoverAnimateSpeed
---@field public VerySlow number | '0'
---@field public Slow number | '1'
---@field public Medium number | '2'
---@field public Fast number | '3'
---@field public VeryFast number | '4'
---Specifies how frequently the hover animation flashes.
---
local HoverAnimateSpeed;
---2 seconds per cycle.
---
HoverAnimateSpeed.VerySlow = nil;
---1 second per cycle.
---
HoverAnimateSpeed.Slow = nil;
---0.5 seconds per cycle.
---
HoverAnimateSpeed.Medium = nil;
---0.25 seconds per cycle.
---
HoverAnimateSpeed.Fast = nil;
---0.1 seconds per cycle.
---
HoverAnimateSpeed.VeryFast = nil;
Enum.HoverAnimateSpeed = HoverAnimateSpeed;
---@diagnostic disable-next-line
---@alias HoverAnimateSpeed Enum.HoverAnimateSpeed
