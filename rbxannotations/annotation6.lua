---@class Enum.HttpCachePolicy
---@field public None number | '0'
---@field public Full number | '1'
---@field public DataOnly number | '2'
---@field public Default number | '3'
---@field public InternalRedirectRefresh number | '4'
local HttpCachePolicy;
---
HttpCachePolicy.None = nil;
---
HttpCachePolicy.Full = nil;
---
HttpCachePolicy.DataOnly = nil;
---
HttpCachePolicy.Default = nil;
---
HttpCachePolicy.InternalRedirectRefresh = nil;
Enum.HttpCachePolicy = HttpCachePolicy;
---@diagnostic disable-next-line
---@alias HttpCachePolicy Enum.HttpCachePolicy
---@class Enum.HttpContentType
---@field public ApplicationJson number | '0'
---@field public ApplicationXml number | '1'
---@field public ApplicationUrlEncoded number | '2'
---@field public TextPlain number | '3'
---@field public TextXml number | '4'
---Specifies the value of the HTTP Content-Type header which describes the HTTP
---request data type.
---
local HttpContentType;
---Represents the "application/json" Content-Type.
---
HttpContentType.ApplicationJson = nil;
---Represents the "application/xml" Content-Type.
---
HttpContentType.ApplicationXml = nil;
---Represents the "application/x-www-form-urlencoded" Content-Type.
---
HttpContentType.ApplicationUrlEncoded = nil;
---Represents the "text/plain" Content-Type.
---
HttpContentType.TextPlain = nil;
---Represents the "text/xml" Content-Type.
---
HttpContentType.TextXml = nil;
Enum.HttpContentType = HttpContentType;
---@diagnostic disable-next-line
---@alias HttpContentType Enum.HttpContentType
---@class Enum.HttpError
---@field public OK number | '0'
---@field public InvalidUrl number | '1'
---@field public DnsResolve number | '2'
---@field public ConnectFail number | '3'
---@field public OutOfMemory number | '4'
---@field public TimedOut number | '5'
---@field public TooManyRedirects number | '6'
---@field public InvalidRedirect number | '7'
---@field public NetFail number | '8'
---@field public Aborted number | '9'
---@field public SslConnectFail number | '10'
---@field public SslVerificationFail number | '11'
---@field public Unknown number | '12'
local HttpError;
---
HttpError.OK = nil;
---
HttpError.InvalidUrl = nil;
---
HttpError.DnsResolve = nil;
---
HttpError.ConnectFail = nil;
---
HttpError.OutOfMemory = nil;
---
HttpError.TimedOut = nil;
---
HttpError.TooManyRedirects = nil;
---
HttpError.InvalidRedirect = nil;
---
HttpError.NetFail = nil;
---
HttpError.Aborted = nil;
---
HttpError.SslConnectFail = nil;
---
HttpError.SslVerificationFail = nil;
---
HttpError.Unknown = nil;
Enum.HttpError = HttpError;
---@diagnostic disable-next-line
---@alias HttpError Enum.HttpError
---@class Enum.HttpRequestType
---@field public Default number | '0'
---@field public MarketplaceService number | '2'
---@field public Players number | '7'
---@field public Chat number | '15'
---@field public Avatar number | '16'
---@field public Analytics number | '23'
---@field public Localization number | '25'
local HttpRequestType;
---
HttpRequestType.Default = nil;
---
HttpRequestType.MarketplaceService = nil;
---
HttpRequestType.Players = nil;
---
HttpRequestType.Chat = nil;
---
HttpRequestType.Avatar = nil;
---
HttpRequestType.Analytics = nil;
---
HttpRequestType.Localization = nil;
Enum.HttpRequestType = HttpRequestType;
---@diagnostic disable-next-line
---@alias HttpRequestType Enum.HttpRequestType
---@class Enum.HumanoidCollisionType
---@field public OuterBox number | '0'
---@field public InnerBox number | '1'
---Enum to select the `Humanoid/CollisionType` for non-player
---`Humanoid|Humanoids`.
---
---For player `Player/Character|Characters` the CollisionType property will be
---decided by the Avatar Collision Option in Game Settings.
---
local HumanoidCollisionType;
---Dynamically sized collision boxes based on mesh sizes.
---
HumanoidCollisionType.OuterBox = nil;
---Fixed size collision boxes, similar to the classic avatar collision.
---
HumanoidCollisionType.InnerBox = nil;
Enum.HumanoidCollisionType = HumanoidCollisionType;
---@diagnostic disable-next-line
---@alias HumanoidCollisionType Enum.HumanoidCollisionType
---@class Enum.HumanoidDisplayDistanceType
---@field public Viewer number | '0'
---@field public Subject number | '1'
---@field public None number | '2'
---HumanoidDisplayDistanceType determines how `/Humanoid/HealthDisplayDistance`,
---and `/Humanoid/NameDisplayDistance` are used in determining whether a
---players's name and health are visible to other players.
---
local HumanoidDisplayDistanceType;
---A player selecting `Viewer` on their `Humanoid` will see the Name and
---healthbar of other players if those other players are within the distance
---settings set in the `Humanoid` selecting `Viewer` (this can be thought of
---as the lowest priority, and will not be taken into account if other
---players are selecting 'Subject' or 'None').
---
HumanoidDisplayDistanceType.Viewer = nil;
---A player selecting `Subject` on their `Humanoid` will allow other players
---to see their Name and healthbar if those other players are within the
---distance settings set in the `Humanoid` selecting `Subject` (this can be
---thought of as the second highest priority).
---
HumanoidDisplayDistanceType.Subject = nil;
---A player selecting `None` on their `Humanoid` will not have their Name and
---healthbar displayed to other players under any circumstance (this can be
---thought of as the highest priority).
---
HumanoidDisplayDistanceType.None = nil;
Enum.HumanoidDisplayDistanceType = HumanoidDisplayDistanceType;
---@diagnostic disable-next-line
---@alias HumanoidDisplayDistanceType Enum.HumanoidDisplayDistanceType
---@class Enum.HumanoidHealthDisplayType
---@field public DisplayWhenDamaged number | '0'
---@field public AlwaysOn number | '1'
---@field public AlwaysOff number | '2'
---Controls when the `Humanoid`'s health bar is displayed. This works in
---conjunction with the `Humanoid`'s `MaxHealth` property, which must have a
---value higher than zero or the health bar doesn't display.
---
local HumanoidHealthDisplayType;
---The humanoid's health bar is only visible when the humanoid is not at full
---health (assuming `MaxHealth` is greater than zero).
---
HumanoidHealthDisplayType.DisplayWhenDamaged = nil;
---The humanoid's health bar is always visible (assuming `MaxHealth` is
---greater than zero).
---
HumanoidHealthDisplayType.AlwaysOn = nil;
---The humanoid's health bar is never visible.
---
HumanoidHealthDisplayType.AlwaysOff = nil;
Enum.HumanoidHealthDisplayType = HumanoidHealthDisplayType;
---@diagnostic disable-next-line
---@alias HumanoidHealthDisplayType Enum.HumanoidHealthDisplayType
---@class Enum.HumanoidOnlySetCollisionsOnStateChange
---@field public Default number | '0'
---@field public Disabled number | '1'
---@field public Enabled number | '2'
---Specifies the behavior of the Humanoid when setting the collisions for parts
---with the Humanoid.
---
local HumanoidOnlySetCollisionsOnStateChange;
---Applies the default setting for the behavior. Initially, Disabled, but
---will be changed to Enabled in the future.
---
HumanoidOnlySetCollisionsOnStateChange.Default = nil;
---The collision value for all parts will be set every frame.
---
HumanoidOnlySetCollisionsOnStateChange.Disabled = nil;
---The collision value for all parts will only be set when the Humanoid state
---changes.
---
HumanoidOnlySetCollisionsOnStateChange.Enabled = nil;
Enum.HumanoidOnlySetCollisionsOnStateChange = HumanoidOnlySetCollisionsOnStateChange;
---@diagnostic disable-next-line
---@alias HumanoidOnlySetCollisionsOnStateChange Enum.HumanoidOnlySetCollisionsOnStateChange
---@class Enum.HumanoidRigType
---@field public R6 number | '0'
---@field public R15 number | '1'
---Describes whether or not a character is using the new R15 rig, or the legacy
---R6 rig. This is the type returned by Humanoid's RigType property, which
---indicates whether the Humanoid is R6 or R15.
---
local HumanoidRigType;
---Indicates that a character is using the legacy R6 rig.
---
HumanoidRigType.R6 = nil;
---Indicates that a character is using the new R15 rig.
---
HumanoidRigType.R15 = nil;
Enum.HumanoidRigType = HumanoidRigType;
---@diagnostic disable-next-line
---@alias HumanoidRigType Enum.HumanoidRigType
---@class Enum.HumanoidStateType
---@field public FallingDown number | '0'
---@field public Running number | '8'
---@field public RunningNoPhysics number | '10'
---@field public Climbing number | '12'
---@field public StrafingNoPhysics number | '11'
---@field public Ragdoll number | '1'
---@field public GettingUp number | '2'
---@field public Jumping number | '3'
---@field public Landed number | '7'
---@field public Flying number | '6'
---@field public Freefall number | '5'
---@field public Seated number | '13'
---@field public PlatformStanding number | '14'
---@field public Dead number | '15'
---@field public Swimming number | '4'
---@field public Physics number | '16'
---@field public None number | '18'
---Identifies, reads and sets the physics control state of a `Humanoid`.
---`Humanoid/GetState` and `Humanoid/ChangeState` methods, as well as the
---`Humanoid/StateChanged` event currently use this Enum.
---
---Some states only allow manual setting, and allow a developer to make the
---Humanoid relinquish control of its character.
---
---When altering the Humanoid of a player, this should be done from a
---`LocalScript` ran by that player on their local client. Certain states only
---work when set by the owner process (client or server). (Dead for example)
---
local HumanoidStateType;
---The Humanoid has been tripped, and will attempt to get up in a few
---moments.
---
HumanoidStateType.FallingDown = nil;
---Currently running while physics of parts in range are being calculated
---(e.g. After a jump, close to other players, and others).
---
HumanoidStateType.Running = nil;
---Currently running and not near other physical objects. (deprecated).
---
HumanoidStateType.RunningNoPhysics = nil;
---The Humanoid is climbing (e.g. up a `TrussPart|TrussPart` or ladder).
---
HumanoidStateType.Climbing = nil;
---Not currently used with default Humanoid. Cannot be set with
---`Humanoid/ChangeState`.
---
HumanoidStateType.StrafingNoPhysics = nil;
---The Humanoid has been hit by a fast moving object (uncontrolled falling).
---_The Humanoid can recover from this._
---
HumanoidStateType.Ragdoll = nil;
---The Humanoid is getting back on their feet after Ragdoll.
---
HumanoidStateType.GettingUp = nil;
---The Humanoid just jumped. (Check `Humanoid/Jump`). This state lasts only
---briefly. This state normally transitions into either Standing, if on the
---ground, or Freefall, if still in the air.
---
HumanoidStateType.Jumping = nil;
---The Humanoid touched the ground after a Freefall. This state lasts only
---briefly.
---
HumanoidStateType.Landed = nil;
---When set, the Humanoid won't be animated, as with the
---`Humanoid/PlatformStand` property. This state lasts as long as the player
---flies.
---
HumanoidStateType.Flying = nil;
---The Humanoid is currently freefalling (jumped from a height).
---
HumanoidStateType.Freefall = nil;
---The Humanoid is currently sitting in a Seat or VehicleSeat. Check the
---`Humanoid/Sit` property.
---
HumanoidStateType.Seated = nil;
---The Humanoid is platformstanding. Check the `Humanoid/PlatformStand`
---property.
---
HumanoidStateType.PlatformStanding = nil;
---The Humanoid died. Changing a Humanoid's state to this one will kill it.
---
HumanoidStateType.Dead = nil;
---The Humanoid is currently swimming in `Terrain` water.
---
HumanoidStateType.Swimming = nil;
---The Humanoid doesn't apply any force on its own and will not automatically
---transition to any other state. This state has to be set and unset manually
---using `Humanoid/ChangeState`.
---
HumanoidStateType.Physics = nil;
---Unusable placeholder in case an unknown state gets triggered internally.
---
HumanoidStateType.None = nil;
Enum.HumanoidStateType = HumanoidStateType;
---@diagnostic disable-next-line
---@alias HumanoidStateType Enum.HumanoidStateType
---@class Enum.IKCollisionsMode
---@field public NoCollisions number | '0'
---@field public OtherMechanismsAnchored number | '1'
---@field public IncludeContactedMechanisms number | '2'
local IKCollisionsMode;
---Only the part and any parts directly joined to it via
---joints/`Constraint|constraints` be be involved in the resolution,
---everything else in the workspace will be treated as though it doesn't
---exist.
---
IKCollisionsMode.NoCollisions = nil;
---Only the part and any parts directly jointed to it via
---joints/`Constraint|constraints` will be moved during resolution, but they
---will collide with other objects in the workspace.
---
IKCollisionsMode.OtherMechanismsAnchored = nil;
---The part, any parts directly joined to it via
---joints/`Constraint|constraints`, and any parts which it comes into contact
---with during the solve will be moved during the resolution. That is, the
---moved parts will be allowed to "push" other unanchored parts in the
---workspace out of the way in order to get to the target position.
---
IKCollisionsMode.IncludeContactedMechanisms = nil;
Enum.IKCollisionsMode = IKCollisionsMode;
---@diagnostic disable-next-line
---@alias IKCollisionsMode Enum.IKCollisionsMode
---@class Enum.IXPLoadingStatus
---@field public None number | '0'
---@field public Pending number | '1'
---@field public Initialized number | '2'
---@field public ShutOff number | '3'
---@field public ErrorTimedOut number | '7'
---@field public ErrorConnection number | '5'
---@field public ErrorJsonParse number | '6'
---@field public ErrorInvalidUser number | '4'
local IXPLoadingStatus;
---
IXPLoadingStatus.None = nil;
---
IXPLoadingStatus.Pending = nil;
---
IXPLoadingStatus.Initialized = nil;
---
IXPLoadingStatus.ShutOff = nil;
---
IXPLoadingStatus.ErrorTimedOut = nil;
---
IXPLoadingStatus.ErrorConnection = nil;
---
IXPLoadingStatus.ErrorJsonParse = nil;
---
IXPLoadingStatus.ErrorInvalidUser = nil;
Enum.IXPLoadingStatus = IXPLoadingStatus;
---@diagnostic disable-next-line
---@alias IXPLoadingStatus Enum.IXPLoadingStatus
---@class Enum.InOut
---@field public Edge number | '0'
---@field public Inset number | '1'
---@field public Center number | '2'
---The InOut Enum is used to set where the object is on the side of its parent.
---
local InOut;
---The object is located along an edge of its parent.
---
InOut.Edge = nil;
---The object's located is inset from its parent's location.
---
InOut.Inset = nil;
---The object's location is centered on it's parent.
---
InOut.Center = nil;
Enum.InOut = InOut;
---@diagnostic disable-next-line
---@alias InOut Enum.InOut
---@class Enum.InfoType
---@field public Asset number | '0'
---@field public Product number | '1'
---@field public GamePass number | '2'
---@field public Subscription number | '3'
---@field public Bundle number | '4'
---Used to represent the possible information formats returnable by
---`MarketplaceService/GetProductInfo`.
---
local InfoType;
---Asset format type - the product is an asset.
---
InfoType.Asset = nil;
---Product format type - the product is a produce (e.g. Developer product).
---
InfoType.Product = nil;
---GamePass format type - the product is a GamePass.
---
InfoType.GamePass = nil;
---
InfoType.Subscription = nil;
---
InfoType.Bundle = nil;
Enum.InfoType = InfoType;
---@diagnostic disable-next-line
---@alias InfoType Enum.InfoType
---@class Enum.InitialDockState
---@field public Top number | '0'
---@field public Bottom number | '1'
---@field public Left number | '2'
---@field public Right number | '3'
---@field public Float number | '4'
---Describes the initial docking state of a `DockWidgetPluginGui`.
---
local InitialDockState;
---The widget will appear docked above the game screen.
---
InitialDockState.Top = nil;
---The widget will appear docked below the game screen.
---
InitialDockState.Bottom = nil;
---The widget will appear docked to the left of the game screen.
---
InitialDockState.Left = nil;
---The widget will appear docked to the right of the game screen.
---
InitialDockState.Right = nil;
---The widget will not be docked to any side of the game screen, and instead
---can be freely dragged around.
---
InitialDockState.Float = nil;
Enum.InitialDockState = InitialDockState;
---@diagnostic disable-next-line
---@alias InitialDockState Enum.InitialDockState
---@class Enum.InputType
---@field public NoInput number | '0'
---@field public Constant number | '12'
---@field public Sin number | '13'
---The InputType Enum controls the SurfaceInputs of `Part`. Several parameters
---here are left-overs from 2005, before Roblox was a multiplayer game, and have
---no known functionality.
---
---The following animation is of the Sin InputType:
---
---![Animation of the Sin
---InputType](assets/bltf0a4aa99ce7d70e1/Enum_InputType_Sin.gif)
---
local InputType;
---Behaves like a weld and does nothing.
---
InputType.NoInput = nil;
---Rotate at a constant velocity of `BasePart` `ParamB`.
---
InputType.Constant = nil;
---Rotate at a velocity of:
---`ParamA * math.sin(game.Workspace.DistributedGameTime * ParamB)`, where
---`BasePart` `ParamA` determines the maximum speed at which the part spins,
---and `BasePart` `ParamB` determines how frequently it changes direction.
---
InputType.Sin = nil;
Enum.InputType = InputType;
---@diagnostic disable-next-line
---@alias InputType Enum.InputType
---@class Enum.InterpolationThrottlingMode
---@field public Default number | '0'
---@field public Disabled number | '1'
---@field public Enabled number | '2'
local InterpolationThrottlingMode;
---
InterpolationThrottlingMode.Default = nil;
---
InterpolationThrottlingMode.Disabled = nil;
---
InterpolationThrottlingMode.Enabled = nil;
Enum.InterpolationThrottlingMode = InterpolationThrottlingMode;
---@diagnostic disable-next-line
---@alias InterpolationThrottlingMode Enum.InterpolationThrottlingMode
---@class Enum.JointCreationMode
---@field public All number | '0'
---@field public Surface number | '1'
---@field public None number | '2'
---The way joints are created between two surfaces.
---
local JointCreationMode;
---Joints are created between any kind of surface. Functions identically to
---Surface.
---
JointCreationMode.All = nil;
---Joints are created between any kind of surface. Functions identically to
---All.
---
JointCreationMode.Surface = nil;
---Joints are never created, no matter what.
---
JointCreationMode.None = nil;
Enum.JointCreationMode = JointCreationMode;
---@diagnostic disable-next-line
---@alias JointCreationMode Enum.JointCreationMode
---@class Enum.KeyCode
---@field public Unknown number | '0'
---@field public Backspace number | '8'
---@field public Tab number | '9'
---@field public Clear number | '12'
---@field public Return number | '13'
---@field public Pause number | '19'
---@field public Escape number | '27'
---@field public Space number | '32'
---@field public QuotedDouble number | '34'
---@field public Hash number | '35'
---@field public Dollar number | '36'
---@field public Percent number | '37'
---@field public Ampersand number | '38'
---@field public Quote number | '39'
---@field public LeftParenthesis number | '40'
---@field public RightParenthesis number | '41'
---@field public Asterisk number | '42'
---@field public Plus number | '43'
---@field public Comma number | '44'
---@field public Minus number | '45'
---@field public Period number | '46'
---@field public Slash number | '47'
---@field public Zero number | '48'
---@field public One number | '49'
---@field public Two number | '50'
---@field public Three number | '51'
---@field public Four number | '52'
---@field public Five number | '53'
---@field public Six number | '54'
---@field public Seven number | '55'
---@field public Eight number | '56'
---@field public Nine number | '57'
---@field public Colon number | '58'
---@field public Semicolon number | '59'
---@field public LessThan number | '60'
---@field public Equals number | '61'
---@field public GreaterThan number | '62'
---@field public Question number | '63'
---@field public At number | '64'
---@field public LeftBracket number | '91'
---@field public BackSlash number | '92'
---@field public RightBracket number | '93'
---@field public Caret number | '94'
---@field public Underscore number | '95'
---@field public Backquote number | '96'
---@field public A number | '97'
---@field public B number | '98'
---@field public C number | '99'
---@field public D number | '100'
---@field public E number | '101'
---@field public F number | '102'
---@field public G number | '103'
---@field public H number | '104'
---@field public I number | '105'
---@field public J number | '106'
---@field public K number | '107'
---@field public L number | '108'
---@field public M number | '109'
---@field public N number | '110'
---@field public O number | '111'
---@field public P number | '112'
---@field public Q number | '113'
---@field public R number | '114'
---@field public S number | '115'
---@field public T number | '116'
---@field public U number | '117'
---@field public V number | '118'
---@field public W number | '119'
---@field public X number | '120'
---@field public Y number | '121'
---@field public Z number | '122'
---@field public LeftCurly number | '123'
---@field public Pipe number | '124'
---@field public RightCurly number | '125'
---@field public Tilde number | '126'
---@field public Delete number | '127'
---@field public KeypadZero number | '256'
---@field public KeypadOne number | '257'
---@field public KeypadTwo number | '258'
---@field public KeypadThree number | '259'
---@field public KeypadFour number | '260'
---@field public KeypadFive number | '261'
---@field public KeypadSix number | '262'
---@field public KeypadSeven number | '263'
---@field public KeypadEight number | '264'
---@field public KeypadNine number | '265'
---@field public KeypadPeriod number | '266'
---@field public KeypadDivide number | '267'
---@field public KeypadMultiply number | '268'
---@field public KeypadMinus number | '269'
---@field public KeypadPlus number | '270'
---@field public KeypadEnter number | '271'
---@field public KeypadEquals number | '272'
---@field public Up number | '273'
---@field public Down number | '274'
---@field public Right number | '275'
---@field public Left number | '276'
---@field public Insert number | '277'
---@field public Home number | '278'
---@field public End number | '279'
---@field public PageUp number | '280'
---@field public PageDown number | '281'
---@field public LeftShift number | '304'
---@field public RightShift number | '303'
---@field public LeftMeta number | '310'
---@field public RightMeta number | '309'
---@field public LeftAlt number | '308'
---@field public RightAlt number | '307'
---@field public LeftControl number | '306'
---@field public RightControl number | '305'
---@field public CapsLock number | '301'
---@field public NumLock number | '300'
---@field public ScrollLock number | '302'
---@field public LeftSuper number | '311'
---@field public RightSuper number | '312'
---@field public Mode number | '313'
---@field public Compose number | '314'
---@field public Help number | '315'
---@field public Print number | '316'
---@field public SysReq number | '317'
---@field public Break number | '318'
---@field public Menu number | '319'
---@field public Power number | '320'
---@field public Euro number | '321'
---@field public Undo number | '322'
---@field public F1 number | '282'
---@field public F2 number | '283'
---@field public F3 number | '284'
---@field public F4 number | '285'
---@field public F5 number | '286'
---@field public F6 number | '287'
---@field public F7 number | '288'
---@field public F8 number | '289'
---@field public F9 number | '290'
---@field public F10 number | '291'
---@field public F11 number | '292'
---@field public F12 number | '293'
---@field public F13 number | '294'
---@field public F14 number | '295'
---@field public F15 number | '296'
---@field public World0 number | '160'
---@field public World1 number | '161'
---@field public World2 number | '162'
---@field public World3 number | '163'
---@field public World4 number | '164'
---@field public World5 number | '165'
---@field public World6 number | '166'
---@field public World7 number | '167'
---@field public World8 number | '168'
---@field public World9 number | '169'
---@field public World10 number | '170'
---@field public World11 number | '171'
---@field public World12 number | '172'
---@field public World13 number | '173'
---@field public World14 number | '174'
---@field public World15 number | '175'
---@field public World16 number | '176'
---@field public World17 number | '177'
---@field public World18 number | '178'
---@field public World19 number | '179'
---@field public World20 number | '180'
---@field public World21 number | '181'
---@field public World22 number | '182'
---@field public World23 number | '183'
---@field public World24 number | '184'
---@field public World25 number | '185'
---@field public World26 number | '186'
---@field public World27 number | '187'
---@field public World28 number | '188'
---@field public World29 number | '189'
---@field public World30 number | '190'
---@field public World31 number | '191'
---@field public World32 number | '192'
---@field public World33 number | '193'
---@field public World34 number | '194'
---@field public World35 number | '195'
---@field public World36 number | '196'
---@field public World37 number | '197'
---@field public World38 number | '198'
---@field public World39 number | '199'
---@field public World40 number | '200'
---@field public World41 number | '201'
---@field public World42 number | '202'
---@field public World43 number | '203'
---@field public World44 number | '204'
---@field public World45 number | '205'
---@field public World46 number | '206'
---@field public World47 number | '207'
---@field public World48 number | '208'
---@field public World49 number | '209'
---@field public World50 number | '210'
---@field public World51 number | '211'
---@field public World52 number | '212'
---@field public World53 number | '213'
---@field public World54 number | '214'
---@field public World55 number | '215'
---@field public World56 number | '216'
---@field public World57 number | '217'
---@field public World58 number | '218'
---@field public World59 number | '219'
---@field public World60 number | '220'
---@field public World61 number | '221'
---@field public World62 number | '222'
---@field public World63 number | '223'
---@field public World64 number | '224'
---@field public World65 number | '225'
---@field public World66 number | '226'
---@field public World67 number | '227'
---@field public World68 number | '228'
---@field public World69 number | '229'
---@field public World70 number | '230'
---@field public World71 number | '231'
---@field public World72 number | '232'
---@field public World73 number | '233'
---@field public World74 number | '234'
---@field public World75 number | '235'
---@field public World76 number | '236'
---@field public World77 number | '237'
---@field public World78 number | '238'
---@field public World79 number | '239'
---@field public World80 number | '240'
---@field public World81 number | '241'
---@field public World82 number | '242'
---@field public World83 number | '243'
---@field public World84 number | '244'
---@field public World85 number | '245'
---@field public World86 number | '246'
---@field public World87 number | '247'
---@field public World88 number | '248'
---@field public World89 number | '249'
---@field public World90 number | '250'
---@field public World91 number | '251'
---@field public World92 number | '252'
---@field public World93 number | '253'
---@field public World94 number | '254'
---@field public World95 number | '255'
---@field public ButtonX number | '1000'
---@field public ButtonY number | '1001'
---@field public ButtonA number | '1002'
---@field public ButtonB number | '1003'
---@field public ButtonR1 number | '1004'
---@field public ButtonL1 number | '1005'
---@field public ButtonR2 number | '1006'
---@field public ButtonL2 number | '1007'
---@field public ButtonR3 number | '1008'
---@field public ButtonL3 number | '1009'
---@field public ButtonStart number | '1010'
---@field public ButtonSelect number | '1011'
---@field public DPadLeft number | '1012'
---@field public DPadRight number | '1013'
---@field public DPadUp number | '1014'
---@field public DPadDown number | '1015'
---@field public Thumbstick1 number | '1016'
---@field public Thumbstick2 number | '1017'
---The KeyCode Enum contains a list of Byte keycodes that represent the button
---used in a user input.
---
---Note, KeyCode keyboard values refer to the physical position of buttons on a
---standard QWERTY keyboard. This means that, provided the user's system is
---configured correctly, the location of keys (such as `WASD`) will remain the
---same on other keyboard types, such as Dvorak keyboards (where it would map to
---`,AOE`).
---
---This enum also includes buttons and axes present on gamepads, and 96 `World``
---values for non-standard buttons.
---
---The keypad is a cluster of keys that is present on many desktop keyboards, but
---is rare for laptops to have.
---
---See also:
---
---- `InputObject` - used for keyboard and gamepad input.
---
local KeyCode;
---Blank value that represents no key being pressed.
---
KeyCode.Unknown = nil;
---The `Backspace` key.
---
KeyCode.Backspace = nil;
---The `Tab` key.
---
KeyCode.Tab = nil;
---Only present on certain keyboards.
---
KeyCode.Clear = nil;
---Better known as enter.
---
KeyCode.Return = nil;
---Only present on certain keyboards.
---
KeyCode.Pause = nil;
---The `Escape` key.
---
KeyCode.Escape = nil;
---The `Space` key.
---
KeyCode.Space = nil;
---The `"` key.
---
KeyCode.QuotedDouble = nil;
---The `#` key.
---
KeyCode.Hash = nil;
---The `$` key.
---
KeyCode.Dollar = nil;
---The `%` key.
---
KeyCode.Percent = nil;
---The `&` key.
---
KeyCode.Ampersand = nil;
---The `'` key.
---
KeyCode.Quote = nil;
---The `(` key.
---
KeyCode.LeftParenthesis = nil;
---The `)` key.
---
KeyCode.RightParenthesis = nil;
---The `*` key.
---
KeyCode.Asterisk = nil;
---The `+` key.
---
KeyCode.Plus = nil;
---The `,` key.
---
KeyCode.Comma = nil;
---The `-` key.
---
KeyCode.Minus = nil;
---The `.` key.
---
KeyCode.Period = nil;
---The `` key.
---
KeyCode.Slash = nil;
---The `0` key.
---
KeyCode.Zero = nil;
---The `1` key.
---
KeyCode.One = nil;
---The `2` key.
---
KeyCode.Two = nil;
---The `3` key.
---
KeyCode.Three = nil;
---The `4` key.
---
KeyCode.Four = nil;
---The `5` key.
---
KeyCode.Five = nil;
---The `6` key.
---
KeyCode.Six = nil;
---The `7` key.
---
KeyCode.Seven = nil;
---The `8` key.
---
KeyCode.Eight = nil;
---The `9` key.
---
KeyCode.Nine = nil;
---The `:` key.
---
KeyCode.Colon = nil;
---The `;` key.
---
KeyCode.Semicolon = nil;
---The `<` key.
---
KeyCode.LessThan = nil;
---The `=` key.
---
KeyCode.Equals = nil;
---The `>` key.
---
KeyCode.GreaterThan = nil;
---The `?` key.
---
KeyCode.Question = nil;
---The `@` key.
---
KeyCode.At = nil;
---The `[` key.
---
KeyCode.LeftBracket = nil;
---The `\` key.
---
KeyCode.BackSlash = nil;
---The `]` key.
---
KeyCode.RightBracket = nil;
---The `^` key.
---
KeyCode.Caret = nil;
---The `_` key.
---
KeyCode.Underscore = nil;
---The `` ` `` key.
---
KeyCode.Backquote = nil;
---The `A` key.
---
KeyCode.A = nil;
---The `B` key.
---
KeyCode.B = nil;
---The `C` key.
---
KeyCode.C = nil;
---The `D` key.
---
KeyCode.D = nil;
---The `E` key.
---
KeyCode.E = nil;
---The `F` key.
---
KeyCode.F = nil;
---The `G` key.
---
KeyCode.G = nil;
---The `H` key.
---
KeyCode.H = nil;
---The `I` key.
---
KeyCode.I = nil;
---The `J` key.
---
KeyCode.J = nil;
---The `K` key.
---
KeyCode.K = nil;
---The `L` key.
---
KeyCode.L = nil;
---The `M` key.
---
KeyCode.M = nil;
---The `N` key.
---
KeyCode.N = nil;
---The `O` key.
---
KeyCode.O = nil;
---The `P` key.
---
KeyCode.P = nil;
---The `Q` key.
---
KeyCode.Q = nil;
---The `R` key.
---
KeyCode.R = nil;
---The `S` key.
---
KeyCode.S = nil;
---The `T` key.
---
KeyCode.T = nil;
---The `U` key.
---
KeyCode.U = nil;
---The `V` key.
---
KeyCode.V = nil;
---The `W` key.
---
KeyCode.W = nil;
---The `X` key.
---
KeyCode.X = nil;
---The `Y` key.
---
KeyCode.Y = nil;
---The `Z` key.
---
KeyCode.Z = nil;
---The `{` key.
---
KeyCode.LeftCurly = nil;
---The `|` key.
---
KeyCode.Pipe = nil;
---The `}` key.
---
KeyCode.RightCurly = nil;
---The `~` key.
---
KeyCode.Tilde = nil;
---The `Del` key.
---
KeyCode.Delete = nil;
---The `0` key on the keypad cluster.
---
KeyCode.KeypadZero = nil;
---The `1` key on the keypad cluster.
---
KeyCode.KeypadOne = nil;
---The `2` key on the keypad cluster.
---
KeyCode.KeypadTwo = nil;
---The `3` key on the keypad cluster.
---
KeyCode.KeypadThree = nil;
---The `4` key on the keypad cluster.
---
KeyCode.KeypadFour = nil;
---The `5` key on the keypad cluster.
---
KeyCode.KeypadFive = nil;
---The `6` key on the keypad cluster.
---
KeyCode.KeypadSix = nil;
---The `7` key on the keypad cluster.
---
KeyCode.KeypadSeven = nil;
---The `8` key on the keypad cluster.
---
KeyCode.KeypadEight = nil;
---The `9` key on the keypad cluster.
---
KeyCode.KeypadNine = nil;
---The `.` key on the keypad cluster.
---
KeyCode.KeypadPeriod = nil;
---The `` key on the keypad cluster.
---
KeyCode.KeypadDivide = nil;
---The `*` key on the keypad cluster.
---
KeyCode.KeypadMultiply = nil;
---The `-` key on the keypad cluster.
---
KeyCode.KeypadMinus = nil;
---The `+` key on the keypad cluster.
---
KeyCode.KeypadPlus = nil;
---The `Enter` key on the keypad cluster.
---
KeyCode.KeypadEnter = nil;
---The `=` key on the keypad cluster.
---
KeyCode.KeypadEquals = nil;
---The `↑` arrow key.
---
KeyCode.Up = nil;
---The `↓` arrow key.
---
KeyCode.Down = nil;
---The `→` arrow key.
---
KeyCode.Right = nil;
---The `←` arrow key.
---
KeyCode.Left = nil;
---The `Insert` key.
---
KeyCode.Insert = nil;
---The `Home` key.
---
KeyCode.Home = nil;
---The `End` key.
---
KeyCode.End = nil;
---The `PgUp` key.
---
KeyCode.PageUp = nil;
---The `PgDown` key.
---
KeyCode.PageDown = nil;
---The left side `Shift` key.
---
KeyCode.LeftShift = nil;
---The right side `Shift` key.
---
KeyCode.RightShift = nil;
---The left side `Meta` key.
---
KeyCode.LeftMeta = nil;
---The right side `Meta` key.
---
KeyCode.RightMeta = nil;
---The left side `Alt` key.
---
KeyCode.LeftAlt = nil;
---The right side `Alt` key.
---
KeyCode.RightAlt = nil;
---The left side `Ctrl` key.
---
KeyCode.LeftControl = nil;
---The right side `Ctrl` key.
---
KeyCode.RightControl = nil;
---The `Caps Lock` key.
---
KeyCode.CapsLock = nil;
---The `Num Lock` key on the keypad cluster.
---
KeyCode.NumLock = nil;
---The `Scr Lock` key.
---
KeyCode.ScrollLock = nil;
---The left side `Super` key. Better known as the Windows key or Cmd key.
---
KeyCode.LeftSuper = nil;
---The right side `Super` key. Better known as the Windows key or Cmd key.
---
KeyCode.RightSuper = nil;
---Only present on certain keyboards.
---
KeyCode.Mode = nil;
---Only present on certain keyboards.
---
KeyCode.Compose = nil;
---Only present on certain keyboards.
---
KeyCode.Help = nil;
---Only present on certain keyboards.
---
KeyCode.Print = nil;
---Only present on certain keyboards.
---
KeyCode.SysReq = nil;
---Only present on certain keyboards.
---
KeyCode.Break = nil;
---The `Menu` key.
---
KeyCode.Menu = nil;
---Only present on certain keyboards.
---
KeyCode.Power = nil;
---The `€` key. Only present on certain keyboards.
---
KeyCode.Euro = nil;
---Only present on certain keyboards.
---
KeyCode.Undo = nil;
---The `F1` key.
---
KeyCode.F1 = nil;
---The `F2` key.
---
KeyCode.F2 = nil;
---The `F3` key.
---
KeyCode.F3 = nil;
---The `F4` key.
---
KeyCode.F4 = nil;
---The `F5` key.
---
KeyCode.F5 = nil;
---The `F6` key.
---
KeyCode.F6 = nil;
---The `F7` key.
---
KeyCode.F7 = nil;
---The `F8` key.
---
KeyCode.F8 = nil;
---The `F9` key.
---
KeyCode.F9 = nil;
---The `F10` key.
---
KeyCode.F10 = nil;
---The `F11` key.
---
KeyCode.F11 = nil;
---The `F12` key.
---
KeyCode.F12 = nil;
---The `F13` key. Only present on certain keyboards.
---
KeyCode.F13 = nil;
---The `F14` key. Only present on certain keyboards.
---
KeyCode.F14 = nil;
---The `F15` key. Only present on certain keyboards.
---
KeyCode.F15 = nil;
---Generally not used.
---
KeyCode.World0 = nil;
---Generally not used.
---
KeyCode.World1 = nil;
---Generally not used.
---
KeyCode.World2 = nil;
---Generally not used.
---
KeyCode.World3 = nil;
---Generally not used.
---
KeyCode.World4 = nil;
---Generally not used.
---
KeyCode.World5 = nil;
---Generally not used.
---
KeyCode.World6 = nil;
---Generally not used.
---
KeyCode.World7 = nil;
---Generally not used.
---
KeyCode.World8 = nil;
---Generally not used.
---
KeyCode.World9 = nil;
---Generally not used.
---
KeyCode.World10 = nil;
---Generally not used.
---
KeyCode.World11 = nil;
---Generally not used.
---
KeyCode.World12 = nil;
---Generally not used.
---
KeyCode.World13 = nil;
---Generally not used.
---
KeyCode.World14 = nil;
---Generally not used.
---
KeyCode.World15 = nil;
---Generally not used.
---
KeyCode.World16 = nil;
---Generally not used.
---
KeyCode.World17 = nil;
---Generally not used.
---
KeyCode.World18 = nil;
---Generally not used.
---
KeyCode.World19 = nil;
---Generally not used.
---
KeyCode.World20 = nil;
---Generally not used.
---
KeyCode.World21 = nil;
---Generally not used.
---
KeyCode.World22 = nil;
---Generally not used.
---
KeyCode.World23 = nil;
---Generally not used.
---
KeyCode.World24 = nil;
---Generally not used.
---
KeyCode.World25 = nil;
---Generally not used.
---
KeyCode.World26 = nil;
---Generally not used.
---
KeyCode.World27 = nil;
---Generally not used.
---
KeyCode.World28 = nil;
---Generally not used.
---
KeyCode.World29 = nil;
---Generally not used.
---
KeyCode.World30 = nil;
---Generally not used.
---
KeyCode.World31 = nil;
---Generally not used.
---
KeyCode.World32 = nil;
---Generally not used.
---
KeyCode.World33 = nil;
---Generally not used.
---
KeyCode.World34 = nil;
---Generally not used.
---
KeyCode.World35 = nil;
---Generally not used.
---
KeyCode.World36 = nil;
---Generally not used.
---
KeyCode.World37 = nil;
---Generally not used.
---
KeyCode.World38 = nil;
---Generally not used.
---
KeyCode.World39 = nil;
---Generally not used.
---
KeyCode.World40 = nil;
---Generally not used.
---
KeyCode.World41 = nil;
---Generally not used.
---
KeyCode.World42 = nil;
---Generally not used.
---
KeyCode.World43 = nil;
---Generally not used.
---
KeyCode.World44 = nil;
---Generally not used.
---
KeyCode.World45 = nil;
---Generally not used.
---
KeyCode.World46 = nil;
---Generally not used.
---
KeyCode.World47 = nil;
---Generally not used.
---
KeyCode.World48 = nil;
---Generally not used.
---
KeyCode.World49 = nil;
---Generally not used.
---
KeyCode.World50 = nil;
---Generally not used.
---
KeyCode.World51 = nil;
---Generally not used.
---
KeyCode.World52 = nil;
---Generally not used.
---
KeyCode.World53 = nil;
---Generally not used.
---
KeyCode.World54 = nil;
---Generally not used.
---
KeyCode.World55 = nil;
---Generally not used.
---
KeyCode.World56 = nil;
---Generally not used.
---
KeyCode.World57 = nil;
---Generally not used.
---
KeyCode.World58 = nil;
---Generally not used.
---
KeyCode.World59 = nil;
---Generally not used.
---
KeyCode.World60 = nil;
---Generally not used.
---
KeyCode.World61 = nil;
---Generally not used.
---
KeyCode.World62 = nil;
---Generally not used.
---
KeyCode.World63 = nil;
---Generally not used.
---
KeyCode.World64 = nil;
---Generally not used.
---
KeyCode.World65 = nil;
---Generally not used.
---
KeyCode.World66 = nil;
---Generally not used.
---
KeyCode.World67 = nil;
---Generally not used.
---
KeyCode.World68 = nil;
---Generally not used.
---
KeyCode.World69 = nil;
---Generally not used.
---
KeyCode.World70 = nil;
---Generally not used.
---
KeyCode.World71 = nil;
---Generally not used.
---
KeyCode.World72 = nil;
---Generally not used.
---
KeyCode.World73 = nil;
---Generally not used.
---
KeyCode.World74 = nil;
---Generally not used.
---
KeyCode.World75 = nil;
---Generally not used.
---
KeyCode.World76 = nil;
---Generally not used.
---
KeyCode.World77 = nil;
---Generally not used.
---
KeyCode.World78 = nil;
---Generally not used.
---
KeyCode.World79 = nil;
---Generally not used.
---
KeyCode.World80 = nil;
---Generally not used.
---
KeyCode.World81 = nil;
---Generally not used.
---
KeyCode.World82 = nil;
---Generally not used.
---
KeyCode.World83 = nil;
---Generally not used.
---
KeyCode.World84 = nil;
---Generally not used.
---
KeyCode.World85 = nil;
---Generally not used.
---
KeyCode.World86 = nil;
---Generally not used.
---
KeyCode.World87 = nil;
---Generally not used.
---
KeyCode.World88 = nil;
---Generally not used.
---
KeyCode.World89 = nil;
---Generally not used.
---
KeyCode.World90 = nil;
---Generally not used.
---
KeyCode.World91 = nil;
---Generally not used.
---
KeyCode.World92 = nil;
---Generally not used.
---
KeyCode.World93 = nil;
---Generally not used.
---
KeyCode.World94 = nil;
---Generally not used.
---
KeyCode.World95 = nil;
---Gamepad X button.
---
KeyCode.ButtonX = nil;
---Gamepad Y button.
---
KeyCode.ButtonY = nil;
---Gamepad A button.
---
KeyCode.ButtonA = nil;
---Gamepad B button.
---
KeyCode.ButtonB = nil;
---Gamepad R1 button.
---
KeyCode.ButtonR1 = nil;
---Gamepad L1 button.
---
KeyCode.ButtonL1 = nil;
---Gamepad R2 button.
---
KeyCode.ButtonR2 = nil;
---Gamepad L2 button.
---
KeyCode.ButtonL2 = nil;
---Gamepad R3 button.
---
KeyCode.ButtonR3 = nil;
---Gamepad L3 button.
---
KeyCode.ButtonL3 = nil;
---Gamepad Start button.
---
KeyCode.ButtonStart = nil;
---Gamepad Select button.
---
KeyCode.ButtonSelect = nil;
---Left arrow on a gamepad D-pad.
---
KeyCode.DPadLeft = nil;
---Right arrow on a gamepad D-pad.
---
KeyCode.DPadRight = nil;
---Up arrow on a gamepad D-pad.
---
KeyCode.DPadUp = nil;
---Down arrow on a gamepad D-pad.
---
KeyCode.DPadDown = nil;
---Gamepad primary thumbstick.
---
KeyCode.Thumbstick1 = nil;
---Gamepad secondary thumbstick.
---
KeyCode.Thumbstick2 = nil;
Enum.KeyCode = KeyCode;
---@diagnostic disable-next-line
---@alias KeyCode Enum.KeyCode
---@class Enum.KeyInterpolationMode
---@field public Constant number | '0'
---@field public Linear number | '1'
---@field public Cubic number | '2'
---Describes the interpolation method for a FloatCurve or RotationCurve segment
---between the key for which this mode is set and the next key in the curve.
---
local KeyInterpolationMode;
---The segment starting at this key will constantly evaluate to the value set
---at this key.
---
KeyInterpolationMode.Constant = nil;
---The segment starting at this key will evaluate using a linear
---interpolation at this key and the value at the next key.
---
KeyInterpolationMode.Linear = nil;
---The segment starting at this key will evaluate using cubic interpolation
---of this key value using its right tangent and the next key value and its
---left tangent.
---
KeyInterpolationMode.Cubic = nil;
Enum.KeyInterpolationMode = KeyInterpolationMode;
---@diagnostic disable-next-line
---@alias KeyInterpolationMode Enum.KeyInterpolationMode
---@class Enum.KeywordFilterType
---@field public Include number | '0'
---@field public Exclude number | '1'
---Determines if a filter is 'inclusive' or 'exclusive'.
---
local KeywordFilterType;
---Include the matched content.
---
KeywordFilterType.Include = nil;
---Exclude the matched content.
---
KeywordFilterType.Exclude = nil;
Enum.KeywordFilterType = KeywordFilterType;
---@diagnostic disable-next-line
---@alias KeywordFilterType Enum.KeywordFilterType
---@class Enum.LSPMethodType
---@field public Initialize number | '1'
---@field public Initialized number | '2'
---@field public CancelRequest number | '3'
---@field public TextDocument_didOpen number | '4'
---@field public TextDocument_didChange number | '5'
---@field public TextDocument_didClose number | '6'
---@field public TextDocument_foldingRange number | '7'
---@field public TextDocument_onTypeFormatting number | '8'
---@field public TextDocument_formatting number | '9'
---@field public TextDocument_rangeFormatting number | '10'
---@field public TextDocument_hover number | '11'
---@field public TextDocument_signatureHelp number | '12'
---@field public Workspace_DidChangeConfiguration number | '13'
---@field public ShutdownRequest number | '14'
---@field public Completion number | '15'
---@field public Declaration number | '16'
---@field public DocumentSymbols number | '17'
---@field public TextDocument_publishDiagnostics number | '18'
---@field public Window_showMessage number | '19'
---@field public Window_showMessageRequest number | '20'
---@field public Roblox_registerSyntaxCategories number | '21'
---@field public Roblox_signalQuiescence number | '22'
---@field public Roblox_syntaxHighlight number | '23'
---@field public Roblox_suggestExtraSelections number | '24'
---@field public Roblox_findExecutablePosition number | '25'
---@field public Roblox_findColor3 number | '26'
local LSPMethodType;
---
LSPMethodType.Initialize = nil;
---
LSPMethodType.Initialized = nil;
---
LSPMethodType.CancelRequest = nil;
---
LSPMethodType.TextDocument_didOpen = nil;
---
LSPMethodType.TextDocument_didChange = nil;
---
LSPMethodType.TextDocument_didClose = nil;
---
LSPMethodType.TextDocument_foldingRange = nil;
---
LSPMethodType.TextDocument_onTypeFormatting = nil;
---
LSPMethodType.TextDocument_formatting = nil;
---
LSPMethodType.TextDocument_rangeFormatting = nil;
---
LSPMethodType.TextDocument_hover = nil;
---
LSPMethodType.TextDocument_signatureHelp = nil;
---
LSPMethodType.Workspace_DidChangeConfiguration = nil;
---
LSPMethodType.ShutdownRequest = nil;
---
LSPMethodType.Completion = nil;
---
LSPMethodType.Declaration = nil;
---
LSPMethodType.DocumentSymbols = nil;
---
LSPMethodType.TextDocument_publishDiagnostics = nil;
---
LSPMethodType.Window_showMessage = nil;
---
LSPMethodType.Window_showMessageRequest = nil;
---
LSPMethodType.Roblox_registerSyntaxCategories = nil;
---
LSPMethodType.Roblox_signalQuiescence = nil;
---
LSPMethodType.Roblox_syntaxHighlight = nil;
---
LSPMethodType.Roblox_suggestExtraSelections = nil;
---
LSPMethodType.Roblox_findExecutablePosition = nil;
---
LSPMethodType.Roblox_findColor3 = nil;
Enum.LSPMethodType = LSPMethodType;
---@diagnostic disable-next-line
---@alias LSPMethodType Enum.LSPMethodType
---@class Enum.Language
---@field public Default number | '0'
local Language;
---
Language.Default = nil;
Enum.Language = Language;
---@diagnostic disable-next-line
---@alias Language Enum.Language
---@class Enum.LeftRight
---@field public Left number | '0'
---@field public Center number | '1'
---@field public Right number | '2'
---The LeftRight Enum is used to set where the object is on the side of its
---parent.
---
local LeftRight;
---The object is on the left side of it's parent (x-axis).
---
LeftRight.Left = nil;
---The object is centered on the center of it's parent (x-axis), expanding
---equally to the left and right of the parent's center.
---
LeftRight.Center = nil;
---The object is on the right side of it's parent (x-axis).
---
LeftRight.Right = nil;
Enum.LeftRight = LeftRight;
---@diagnostic disable-next-line
---@alias LeftRight Enum.LeftRight
---@class Enum.LevelOfDetailSetting
---@field public Low number | '0'
---@field public Medium number | '1'
---@field public High number | '2'
local LevelOfDetailSetting;
---
LevelOfDetailSetting.Low = nil;
---
LevelOfDetailSetting.Medium = nil;
---
LevelOfDetailSetting.High = nil;
Enum.LevelOfDetailSetting = LevelOfDetailSetting;
---@diagnostic disable-next-line
---@alias LevelOfDetailSetting Enum.LevelOfDetailSetting
---@class Enum.Limb
---@field public Head number | '0'
---@field public Torso number | '1'
---@field public LeftArm number | '2'
---@field public RightArm number | '3'
---@field public LeftLeg number | '4'
---@field public RightLeg number | '5'
---@field public Unknown number | '6'
---Describes which limb a particular Instance belongs to (assuming the Instance
---is part of a Humanoid). Passing an Instance to the Humanoid:GetLimb() function
---will return the Limb for the Instance.
---
local Limb;
---If the limb is a part of the Humanoid's Head.
---
Limb.Head = nil;
---If the limb is a part of the Humanoid's Torso. This includes UpperTorso
---and LowerTorso for R15 rigs.
---
Limb.Torso = nil;
---If the limb is a part of the Humanoid's Left Arm. This includes
---UpperLeftArm, LowerLeftArm, and LeftHand for R15 rigs.
---
Limb.LeftArm = nil;
---If the limb is a part of the Humanoid's Right Arm. This includes
---UpperRightArm, LowerRightArm and RightHand for R15 rigs.
---
Limb.RightArm = nil;
---If the limb is a part of the Humanoid's Left Leg. This includes
---UpperLeftLeg, LowerLeftLeg and LeftFoot for R15 rigs.
---
Limb.LeftLeg = nil;
---If the limb is a part of the Humanoid's Right Leg. This includes
---UpperRightLeg, LowerRightLeg, and RightFoot for R15 rigs.
---
Limb.RightLeg = nil;
---If a part is not a limb (e.g. running the `Humanoid/GetLimb` function and
---passing it an accessory which is a sibling of the Humanoid will return
---this value).
---
Limb.Unknown = nil;
Enum.Limb = Limb;
---@diagnostic disable-next-line
---@alias Limb Enum.Limb
---@class Enum.LineJoinMode
---@field public Round number | '0'
---@field public Bevel number | '1'
---@field public Miter number | '2'
---This enum is used by `UIStroke/LineJoinMode` to determine how corners are
---interpreted.
---
---See also:
---
---For a more detailed walkthrough of the UIStroke object, take a look at the
---Applying Strokes article.
---
local LineJoinMode;
---The corners are rounded (see image above).
---
LineJoinMode.Round = nil;
---The corners are beveled (see image above).
---
LineJoinMode.Bevel = nil;
---The corners are mitered (see image above).
---
LineJoinMode.Miter = nil;
Enum.LineJoinMode = LineJoinMode;
---@diagnostic disable-next-line
---@alias LineJoinMode Enum.LineJoinMode
---@class Enum.ListDisplayMode
---@field public Horizontal number | '0'
---@field public Vertical number | '1'
---Used to set the scrolling mode of the Advanced Objects tab.
---
local ListDisplayMode;
---Scrolling along the X-axis (fixed Y-Axis).
---
ListDisplayMode.Horizontal = nil;
---Scrolling along the Y-axis (fixed X-Axis).
---
ListDisplayMode.Vertical = nil;
Enum.ListDisplayMode = ListDisplayMode;
---@diagnostic disable-next-line
---@alias ListDisplayMode Enum.ListDisplayMode
---@class Enum.ListenerType
---@field public Camera number | '0'
---@field public CFrame number | '1'
---@field public ObjectPosition number | '2'
---@field public ObjectCFrame number | '3'
local ListenerType;
---
ListenerType.Camera = nil;
---
ListenerType.CFrame = nil;
---
ListenerType.ObjectPosition = nil;
---
ListenerType.ObjectCFrame = nil;
Enum.ListenerType = ListenerType;
---@diagnostic disable-next-line
---@alias ListenerType Enum.ListenerType
---@class Enum.LoadCharacterLayeredClothing
---@field public Default number | '0'
---@field public Disabled number | '1'
---@field public Enabled number | '2'
---Indicates whether characters spawning into an experience will have layered
---clothing accessories equipped on them (Although `MeshPartHeadsAndAccessories`
---also need to be enabled). This is set in
---`StarterPlayer.LoadCharacterLayeredClothing`.
---
local LoadCharacterLayeredClothing;
---The behavior of the default setting is not constant. It can mean Disabled
---or Enabled depending on what the global back-end flag settings are
---currently.
---
LoadCharacterLayeredClothing.Default = nil;
---This means layered clothing will not be equipped on characters in the
---experience.
---
LoadCharacterLayeredClothing.Disabled = nil;
---This means layered clothing will be equipped on characters in the
---experience (Although `MeshPartHeadsAndAccessories` also need to be enabled
---for the experience).
---
LoadCharacterLayeredClothing.Enabled = nil;
Enum.LoadCharacterLayeredClothing = LoadCharacterLayeredClothing;
---@diagnostic disable-next-line
---@alias LoadCharacterLayeredClothing Enum.LoadCharacterLayeredClothing
---@class Enum.Material
---@field public Plastic number | '256'
---@field public SmoothPlastic number | '272'
---@field public Neon number | '288'
---@field public Wood number | '512'
---@field public WoodPlanks number | '528'
---@field public Marble number | '784'
---@field public Basalt number | '788'
---@field public Slate number | '800'
---@field public CrackedLava number | '804'
---@field public Concrete number | '816'
---@field public Limestone number | '820'
---@field public Granite number | '832'
---@field public Pavement number | '836'
---@field public Brick number | '848'
---@field public Pebble number | '864'
---@field public Cobblestone number | '880'
---@field public Rock number | '896'
---@field public Sandstone number | '912'
---@field public CorrodedMetal number | '1040'
---@field public DiamondPlate number | '1056'
---@field public Foil number | '1072'
---@field public Metal number | '1088'
---@field public Grass number | '1280'
---@field public LeafyGrass number | '1284'
---@field public Sand number | '1296'
---@field public Fabric number | '1312'
---@field public Snow number | '1328'
---@field public Mud number | '1344'
---@field public Ground number | '1360'
---@field public Asphalt number | '1376'
---@field public Salt number | '1392'
---@field public Ice number | '1536'
---@field public Glacier number | '1552'
---@field public Glass number | '1568'
---@field public ForceField number | '1584'
---@field public Air number | '1792'
---@field public Water number | '2048'
local Material;
---Applies to `BasePart` only.
---
Material.Plastic = nil;
---Applies to `BasePart` only.
---
Material.SmoothPlastic = nil;
---Applies to `BasePart` only.
---
Material.Neon = nil;
---Applies to `BasePart` only.
---
Material.Wood = nil;
---Applies to `BasePart` and `Terrain`.
---
Material.WoodPlanks = nil;
---Applies to `BasePart` only.
---
Material.Marble = nil;
---Applies to `Terrain` only.
---
Material.Basalt = nil;
---Applies to `BasePart` and `Terrain`.
---
Material.Slate = nil;
---Applies to `Terrain` only.
---
Material.CrackedLava = nil;
---Applies to `BasePart` and `Terrain`.
---
Material.Concrete = nil;
---Applies to `Terrain` only.
---
Material.Limestone = nil;
---Applies to `BasePart` only.
---
Material.Granite = nil;
---Applies to `Terrain` only.
---
Material.Pavement = nil;
---Applies to `BasePart` and `Terrain`.
---
Material.Brick = nil;
---Applies to `BasePart` only.
---
Material.Pebble = nil;
---Applies to `BasePart` and `Terrain`.
---
Material.Cobblestone = nil;
---Applies to `Terrain` only.
---
Material.Rock = nil;
---Applies to `Terrain` only.
---
Material.Sandstone = nil;
---Applies to `BasePart` only.
---
Material.CorrodedMetal = nil;
---Applies to `BasePart` only.
---
Material.DiamondPlate = nil;
---Applies to `BasePart` only.
---
Material.Foil = nil;
---Applies to `BasePart` only.
---
Material.Metal = nil;
---Applies to `BasePart` and `Terrain`.
---
Material.Grass = nil;
---Applies to `Terrain` only.
---
Material.LeafyGrass = nil;
---Applies to `BasePart` and `Terrain`.
---
Material.Sand = nil;
---Applies to `BasePart` only.
---
Material.Fabric = nil;
---Applies to `Terrain` only.
---
Material.Snow = nil;
---Applies to `Terrain` only.
---
Material.Mud = nil;
---Applies to `Terrain` only.
---
Material.Ground = nil;
---Applies to `Terrain` only.
---
Material.Asphalt = nil;
---Applies to `Terrain` only.
---
Material.Salt = nil;
---Applies to `BasePart` and `Terrain`.
---
Material.Ice = nil;
---Applies to `Terrain` only.
---
Material.Glacier = nil;
---Applies to `BasePart` only.
---
Material.Glass = nil;
---Applies to `BasePart` only.
---
Material.ForceField = nil;
---Applies to `Terrain` only.
---
Material.Air = nil;
---Applies to `Terrain` only.
---
Material.Water = nil;
Enum.Material = Material;
---@diagnostic disable-next-line
---@alias Material Enum.Material
---@class Enum.MaterialPattern
---@field public Regular number | '0'
---@field public Organic number | '1'
---Describes the pattern of material. Affects texture tiling method.
---
local MaterialPattern;
---Material has ordered pattern, usually man-made, like brick or wood planks.
---
MaterialPattern.Regular = nil;
---Material pattern has less repetition, like stone or dirt.
---
MaterialPattern.Organic = nil;
Enum.MaterialPattern = MaterialPattern;
---@diagnostic disable-next-line
---@alias MaterialPattern Enum.MaterialPattern
---@class Enum.MembershipType
---@field public None number | '0'
---@field public BuildersClub number | '1'
---@field public TurboBuildersClub number | '2'
---@field public OutrageousBuildersClub number | '3'
---@field public Premium number | '4'
---The membership type of a Player.
---
local MembershipType;
---The player does not have an active paid membership.
---
MembershipType.None = nil;
---(no longer available).
---
MembershipType.BuildersClub = nil;
---(no longer available).
---
MembershipType.TurboBuildersClub = nil;
---(no longer available).
---
MembershipType.OutrageousBuildersClub = nil;
---The player has an active
---[Premium](https://www.roblox.com/premium/membership) membership.
---
MembershipType.Premium = nil;
Enum.MembershipType = MembershipType;
---@diagnostic disable-next-line
---@alias MembershipType Enum.MembershipType
---@class Enum.MeshPartDetailLevel
---@field public DistanceBased number | '0'
---@field public Level01 number | '1'
---@field public Level02 number | '2'
---@field public Level03 number | '3'
---@field public Level04 number | '4'
---The level of detail of `MeshParts` displayed in Studio. Used to visually
---verify the quality of MeshParts at lower level of detail at close range.
---Level01 being the highest detail and Level04 being the lowest detail.
---
local MeshPartDetailLevel;
---Select level of detail based on distance (default behavior as in game).
---
MeshPartDetailLevel.DistanceBased = nil;
---Highest level of detail.
---
MeshPartDetailLevel.Level01 = nil;
---Second highest level of detail.
---
MeshPartDetailLevel.Level02 = nil;
---Third highest level of detail.
---
MeshPartDetailLevel.Level03 = nil;
---Lowest level of detail.
---
MeshPartDetailLevel.Level04 = nil;
Enum.MeshPartDetailLevel = MeshPartDetailLevel;
---@diagnostic disable-next-line
---@alias MeshPartDetailLevel Enum.MeshPartDetailLevel
---@class Enum.MeshPartHeadsAndAccessories
---@field public Default number | '0'
---@field public Disabled number | '1'
---@field public Enabled number | '2'
---Controls the `Workspace/MeshPartHeadsAndAccessories` feature.
---
local MeshPartHeadsAndAccessories;
---The default option to control the `Workspace/MeshPartHeadsAndAccessories`
---feature. This currently has the same meaning as "Enabled".
---
MeshPartHeadsAndAccessories.Default = nil;
---Disables the `Workspace/MeshPartHeadsAndAccessories` feature.
---
MeshPartHeadsAndAccessories.Disabled = nil;
---Enables the `Workspace/MeshPartHeadsAndAccessories` feature.
---
MeshPartHeadsAndAccessories.Enabled = nil;
Enum.MeshPartHeadsAndAccessories = MeshPartHeadsAndAccessories;
---@diagnostic disable-next-line
---@alias MeshPartHeadsAndAccessories Enum.MeshPartHeadsAndAccessories
---@class Enum.MeshScaleUnit
---@field public Stud number | '0'
---@field public Meter number | '1'
---@field public CM number | '2'
---@field public MM number | '3'
---@field public Foot number | '4'
---@field public Inch number | '5'
local MeshScaleUnit;
---
MeshScaleUnit.Stud = nil;
---
MeshScaleUnit.Meter = nil;
---
MeshScaleUnit.CM = nil;
---
MeshScaleUnit.MM = nil;
---
MeshScaleUnit.Foot = nil;
---
MeshScaleUnit.Inch = nil;
Enum.MeshScaleUnit = MeshScaleUnit;
---@diagnostic disable-next-line
---@alias MeshScaleUnit Enum.MeshScaleUnit
---@class Enum.MeshType
---@field public Head number | '0'
---@field public Torso number | '1'
---@field public Wedge number | '2'
---@field public Sphere number | '3'
---@field public Cylinder number | '4'
---@field public FileMesh number | '5'
---@field public Brick number | '6'
---@field public Prism number | '7'
---@field public Pyramid number | '8'
---@field public ParallelRamp number | '9'
---@field public RightAngleRamp number | '10'
---@field public CornerWedge number | '11'
---The MeshType Enum is used to set what type of mesh the `SpecialMesh` is.
---
local MeshType;
---The mesh is the default `Humanoid` head mesh.
---
MeshType.Head = nil;
---The mesh is the default Humanoid torso mesh.
---
MeshType.Torso = nil;
---The mesh is a wedge.
---
MeshType.Wedge = nil;
---The mesh is a sphere.
---
MeshType.Sphere = nil;
---The mesh is a cylinder.
---
MeshType.Cylinder = nil;
---The mesh is determined by the Roblox mesh asset id provided.
---
MeshType.FileMesh = nil;
---The mesh is a brick (just like the shape of a default `BasePart`).
---
MeshType.Brick = nil;
---The mesh is a prism.
---
MeshType.Prism = nil;
---The mesh is a pyramid.
---
MeshType.Pyramid = nil;
---The mesh is a parallel ramp.
---
MeshType.ParallelRamp = nil;
---The mesh is a right angle ramp.
---
MeshType.RightAngleRamp = nil;
---The mesh is a corner wedge.
---
MeshType.CornerWedge = nil;
Enum.MeshType = MeshType;
---@diagnostic disable-next-line
---@alias MeshType Enum.MeshType
---@class Enum.MessageType
---@field public MessageOutput number | '0'
---@field public MessageInfo number | '1'
---@field public MessageWarning number | '2'
---@field public MessageError number | '3'
---A message can be a simple diagnostic or a sign of a system instability or
---failure. The channel that the message appears in indicates its severity. The
---MessageType indicates which channel the message displays in.
---
local MessageType;
---The message is from the standard output channel.
---
MessageType.MessageOutput = nil;
---The message is from the information channel.
---
MessageType.MessageInfo = nil;
---The message is from the warning channel.
---
MessageType.MessageWarning = nil;
---The message is from the error channel.
---
MessageType.MessageError = nil;
Enum.MessageType = MessageType;
---@diagnostic disable-next-line
---@alias MessageType Enum.MessageType
---@class Enum.ModelLevelOfDetail
---@field public Automatic number | '0'
---@field public StreamingMesh number | '1'
---@field public Disabled number | '2'
local ModelLevelOfDetail;
---
ModelLevelOfDetail.Automatic = nil;
---
ModelLevelOfDetail.StreamingMesh = nil;
---
ModelLevelOfDetail.Disabled = nil;
Enum.ModelLevelOfDetail = ModelLevelOfDetail;
---@diagnostic disable-next-line
---@alias ModelLevelOfDetail Enum.ModelLevelOfDetail
---@class Enum.ModifierKey
---@field public Alt number | '2'
---@field public Ctrl number | '1'
---@field public Meta number | '3'
---@field public Shift number | '0'
local ModifierKey;
---
ModifierKey.Alt = nil;
---
ModifierKey.Ctrl = nil;
---
ModifierKey.Meta = nil;
---
ModifierKey.Shift = nil;
Enum.ModifierKey = ModifierKey;
---@diagnostic disable-next-line
---@alias ModifierKey Enum.ModifierKey
---@class Enum.MouseBehavior
---@field public Default number | '0'
---@field public LockCenter number | '1'
---@field public LockCurrentPosition number | '2'
---Used with the `UserInputService/MouseBehavior` property of `UserInputService`
---to set how the user's mouse behaves.
---
local MouseBehavior;
---The mouse moves freely around the user's screen.
---
MouseBehavior.Default = nil;
---The mouse is locked, and cannot move from, the center of the user's
---screen.
---
MouseBehavior.LockCenter = nil;
---The mouse is locked, and cannot move from, it's current position on the
---user's screen at the time of locking.
---
MouseBehavior.LockCurrentPosition = nil;
Enum.MouseBehavior = MouseBehavior;
---@diagnostic disable-next-line
---@alias MouseBehavior Enum.MouseBehavior
---@class Enum.MoveState
---@field public Stopped number | '0'
---@field public Coasting number | '1'
---@field public Pushing number | '2'
---@field public Stopping number | '3'
---@field public AirFree number | '4'
---Represents the state of a `SkateboardPlatform`.
---
local MoveState;
---Skateboard is stopped (not moving).
---
MoveState.Stopped = nil;
---Skateboard is coasting (not actively speeding up / being pushed).
---
MoveState.Coasting = nil;
---Skateboard is being pushed (speeding up).
---
MoveState.Pushing = nil;
---Skateboard is stopping, but still moving.
---
MoveState.Stopping = nil;
---Skateboard is in the air.
---
MoveState.AirFree = nil;
Enum.MoveState = MoveState;
---@diagnostic disable-next-line
---@alias MoveState Enum.MoveState
---@class Enum.NameOcclusion
---@field public OccludeAll number | '2'
---@field public EnemyOcclusion number | '1'
---@field public NoOcclusion number | '0'
---The NameOcclusion Enum is used to set the `Humanoid/NameOcclusion` property.
---
local NameOcclusion;
---Occlude (hide) all humanoid names.
---
NameOcclusion.OccludeAll = nil;
---Occlude (hide) all enemy humanoid names.
---
NameOcclusion.EnemyOcclusion = nil;
---Do not occlude (hide) any humanoid names.
---
NameOcclusion.NoOcclusion = nil;
Enum.NameOcclusion = NameOcclusion;
---@diagnostic disable-next-line
---@alias NameOcclusion Enum.NameOcclusion
---@class Enum.NetworkOwnership
---@field public Automatic number | '0'
---@field public Manual number | '1'
---@field public OnContact number | '2'
---Defines how to determine which client has ownership of a part for a server
---(network).
---
local NetworkOwnership;
---Network ownership is determined automatically by the server.
---
NetworkOwnership.Automatic = nil;
---Network ownership is set manually by the developer.
---
NetworkOwnership.Manual = nil;
---The first player to touch a part is given ownership of that part for the
---server (network). Ownership will not change if another player touches that
---part unless network ownership has been released by the owner.
---
NetworkOwnership.OnContact = nil;
Enum.NetworkOwnership = NetworkOwnership;
---@diagnostic disable-next-line
---@alias NetworkOwnership Enum.NetworkOwnership
---@class Enum.NewAnimationRuntimeSetting
---@field public Default number | '0'
---@field public Disabled number | '1'
---@field public Enabled number | '2'
local NewAnimationRuntimeSetting;
---
NewAnimationRuntimeSetting.Default = nil;
---
NewAnimationRuntimeSetting.Disabled = nil;
---
NewAnimationRuntimeSetting.Enabled = nil;
Enum.NewAnimationRuntimeSetting = NewAnimationRuntimeSetting;
---@diagnostic disable-next-line
---@alias NewAnimationRuntimeSetting Enum.NewAnimationRuntimeSetting
---@class Enum.NormalId
---@field public Top number | '1'
---@field public Bottom number | '4'
---@field public Back number | '2'
---@field public Front number | '5'
---@field public Right number | '0'
---@field public Left number | '3'
---The NormalId Enum sets which side/face of a Part is used.
---
local NormalId;
---The top face of a Part.
---
NormalId.Top = nil;
---The bottom face of a Part.
---
NormalId.Bottom = nil;
---The back face of a Part.
---
NormalId.Back = nil;
---The front face of a Part.
---
NormalId.Front = nil;
---The right face of a Part.
---
NormalId.Right = nil;
---The left face of a Part.
---
NormalId.Left = nil;
Enum.NormalId = NormalId;
---@diagnostic disable-next-line
---@alias NormalId Enum.NormalId
---@class Enum.OrientationAlignmentMode
---@field public OneAttachment number | '0'
---@field public TwoAttachment number | '1'
---The OrientationAlignmentMode Enum is used to select the number of
---`Attachment`s used in an alignment.
---
local OrientationAlignmentMode;
---Use one attachment.
---
OrientationAlignmentMode.OneAttachment = nil;
---Use two attachments.
---
OrientationAlignmentMode.TwoAttachment = nil;
Enum.OrientationAlignmentMode = OrientationAlignmentMode;
---@diagnostic disable-next-line
---@alias OrientationAlignmentMode Enum.OrientationAlignmentMode
---@class Enum.OutfitSource
---@field public All number | '1'
---@field public Created number | '2'
---@field public Purchased number | '3'
local OutfitSource;
---
OutfitSource.All = nil;
---
OutfitSource.Created = nil;
---
OutfitSource.Purchased = nil;
Enum.OutfitSource = OutfitSource;
---@diagnostic disable-next-line
---@alias OutfitSource Enum.OutfitSource
---@class Enum.OutputLayoutMode
---@field public Horizontal number | '0'
---@field public Vertical number | '1'
---Sets the layout mode of the output.
---
local OutputLayoutMode;
---The output layout is horizontal (x-axis).
---
OutputLayoutMode.Horizontal = nil;
---The output layout is vertical (y-axis).
---
OutputLayoutMode.Vertical = nil;
Enum.OutputLayoutMode = OutputLayoutMode;
---@diagnostic disable-next-line
---@alias OutputLayoutMode Enum.OutputLayoutMode
---@class Enum.OverrideMouseIconBehavior
---@field public None number | '0'
---@field public ForceShow number | '1'
---@field public ForceHide number | '2'
---Overrides the behavior of the mouse icon to either force that it is always
---shown or force that it is always hidden.
---
local OverrideMouseIconBehavior;
---The mouse icon behavior is not overridden - default behavior is used.
---
OverrideMouseIconBehavior.None = nil;
---The mouse icon is forced to always remain shown/visible.
---
OverrideMouseIconBehavior.ForceShow = nil;
---The mouse icon is forced to always remain hidden/invisible.
---
OverrideMouseIconBehavior.ForceHide = nil;
Enum.OverrideMouseIconBehavior = OverrideMouseIconBehavior;
---@diagnostic disable-next-line
---@alias OverrideMouseIconBehavior Enum.OverrideMouseIconBehavior
---@class Enum.PackagePermission
---@field public None number | '0'
---@field public NoAccess number | '1'
---@field public Revoked number | '2'
---@field public UseView number | '3'
---@field public Edit number | '4'
---@field public Own number | '5'
---The `PackagePermission` indicates the current user's or group roleset's
---permission to the package.
---
local PackagePermission;
---Permission data is not available for the current user or group roleset.
---
PackagePermission.None = nil;
---The current user or group roleset doesn't have access.
---
PackagePermission.NoAccess = nil;
---The current user's or group roleset's permission is revoked.
---
PackagePermission.Revoked = nil;
---The current user or group roleset can download a copy of the package from
---Roblox.
---
PackagePermission.UseView = nil;
---The current user or group roleset can download a copy of the package from
---Roblox and publish package changes to Roblox.
---
PackagePermission.Edit = nil;
---The current user or group roleset can download a copy of the page from
---Roblox, publish package changes to Roblox, and manage who has access to
---the package.
---
PackagePermission.Own = nil;
Enum.PackagePermission = PackagePermission;
---@diagnostic disable-next-line
---@alias PackagePermission Enum.PackagePermission
---@class Enum.PartType
---@field public Ball number | '0'
---@field public Block number | '1'
---@field public Cylinder number | '2'
---The PartType Enum controls the `Part/Shape` of an object.
---
---<img alt="Block, sphere, and cylinder parts" src="/assets/bltcb9ef55958be7a0e/PartTypes.jpg" width="40%"/>
---
local PartType;
---A ball shaped part.
---
PartType.Ball = nil;
---A block shaped part.
---
PartType.Block = nil;
---A cylinder shaped part.
---
PartType.Cylinder = nil;
Enum.PartType = PartType;
---@diagnostic disable-next-line
---@alias PartType Enum.PartType
---@class Enum.ParticleEmitterShape
---@field public Box number | '0'
---@field public Sphere number | '1'
---@field public Cylinder number | '2'
---@field public Disc number | '3'
local ParticleEmitterShape;
---
ParticleEmitterShape.Box = nil;
---
ParticleEmitterShape.Sphere = nil;
---
ParticleEmitterShape.Cylinder = nil;
---
ParticleEmitterShape.Disc = nil;
Enum.ParticleEmitterShape = ParticleEmitterShape;
---@diagnostic disable-next-line
---@alias ParticleEmitterShape Enum.ParticleEmitterShape
---@class Enum.ParticleEmitterShapeInOut
---@field public Outward number | '0'
---@field public Inward number | '1'
---@field public InAndOut number | '2'
local ParticleEmitterShapeInOut;
---
ParticleEmitterShapeInOut.Outward = nil;
---
ParticleEmitterShapeInOut.Inward = nil;
---
ParticleEmitterShapeInOut.InAndOut = nil;
Enum.ParticleEmitterShapeInOut = ParticleEmitterShapeInOut;
---@diagnostic disable-next-line
---@alias ParticleEmitterShapeInOut Enum.ParticleEmitterShapeInOut
---@class Enum.ParticleEmitterShapeStyle
---@field public Volume number | '0'
---@field public Surface number | '1'
local ParticleEmitterShapeStyle;
---
ParticleEmitterShapeStyle.Volume = nil;
---
ParticleEmitterShapeStyle.Surface = nil;
Enum.ParticleEmitterShapeStyle = ParticleEmitterShapeStyle;
---@diagnostic disable-next-line
---@alias ParticleEmitterShapeStyle Enum.ParticleEmitterShapeStyle
---@class Enum.ParticleFlipbookLayout
---@field public None number | '0'
---@field public TwoByTwo number | '1'
---@field public FourByFour number | '2'
---@field public EightByEight number | '3'
local ParticleFlipbookLayout;
---
ParticleFlipbookLayout.None = nil;
---
ParticleFlipbookLayout.TwoByTwo = nil;
---
ParticleFlipbookLayout.FourByFour = nil;
---
ParticleFlipbookLayout.EightByEight = nil;
Enum.ParticleFlipbookLayout = ParticleFlipbookLayout;
---@diagnostic disable-next-line
---@alias ParticleFlipbookLayout Enum.ParticleFlipbookLayout
---@class Enum.ParticleFlipbookMode
---@field public Loop number | '0'
---@field public OneShot number | '1'
---@field public PingPong number | '2'
---@field public Random number | '3'
local ParticleFlipbookMode;
---
ParticleFlipbookMode.Loop = nil;
---
ParticleFlipbookMode.OneShot = nil;
---
ParticleFlipbookMode.PingPong = nil;
---
ParticleFlipbookMode.Random = nil;
Enum.ParticleFlipbookMode = ParticleFlipbookMode;
---@diagnostic disable-next-line
---@alias ParticleFlipbookMode Enum.ParticleFlipbookMode
---@class Enum.ParticleOrientation
---@field public FacingCamera number | '0'
---@field public FacingCameraWorldUp number | '1'
---@field public VelocityParallel number | '2'
---@field public VelocityPerpendicular number | '3'
local ParticleOrientation;
---
ParticleOrientation.FacingCamera = nil;
---
ParticleOrientation.FacingCameraWorldUp = nil;
---
ParticleOrientation.VelocityParallel = nil;
---
ParticleOrientation.VelocityPerpendicular = nil;
Enum.ParticleOrientation = ParticleOrientation;
---@diagnostic disable-next-line
---@alias ParticleOrientation Enum.ParticleOrientation
---@class Enum.PathStatus
---@field public Success number | '0'
---@field public ClosestNoPath number | '1'
---@field public ClosestOutOfRange number | '2'
---@field public FailStartNotEmpty number | '3'
---@field public FailFinishNotEmpty number | '4'
---@field public NoPath number | '5'
---The success of a `Path` generated by `PathfindingService`.
---
local PathStatus;
---Path found successfully.
---
PathStatus.Success = nil;
---Path doesn't exist, returns path to closest point.
---
PathStatus.ClosestNoPath = nil;
---Goal is out of MaxDistance range, returns path to closest point you can
---reach within MaxDistance.
---
PathStatus.ClosestOutOfRange = nil;
---Failed to compute path; the starting point is not empty.
---
PathStatus.FailStartNotEmpty = nil;
---Failed to compute path; the finish point is not empty.
---
PathStatus.FailFinishNotEmpty = nil;
---Path doesn't exist.
---
PathStatus.NoPath = nil;
Enum.PathStatus = PathStatus;
---@diagnostic disable-next-line
---@alias PathStatus Enum.PathStatus
---@class Enum.PathWaypointAction
---@field public Walk number | '0'
---@field public Jump number | '1'
---@field public Custom number | '2'
---Describes the action to take when a `PathWaypoint` is reached.
---
local PathWaypointAction;
---Walk action needed to reach the next waypoint.
---
PathWaypointAction.Walk = nil;
---Jump action needed to reach the next waypoint.
---
PathWaypointAction.Jump = nil;
---
PathWaypointAction.Custom = nil;
Enum.PathWaypointAction = PathWaypointAction;
---@diagnostic disable-next-line
---@alias PathWaypointAction Enum.PathWaypointAction
---@class Enum.PermissionLevelShown
---@field public Game number | '0'
---@field public RobloxGame number | '1'
---@field public RobloxScript number | '2'
---@field public Studio number | '3'
---@field public Roblox number | '4'
---Used to set the highest permission level that APIs have to have in order to be
---shown in the Object Browser.
---
local PermissionLevelShown;
---Member must have no security permissions in order to be shown.
---
PermissionLevelShown.Game = nil;
---Member must have security permissions less than or equal to
---**RobloxPlaceSecurity** to be shown.
---
PermissionLevelShown.RobloxGame = nil;
---Member must have security permissions less than or equal to
---**RobloxScriptSecurity** to be shown.
---
PermissionLevelShown.RobloxScript = nil;
---Member must have security permissions less than or equal to
---**LocalUserSecurity** to be shown.
---
PermissionLevelShown.Studio = nil;
---Member is shown no matter what security it has.
---
PermissionLevelShown.Roblox = nil;
Enum.PermissionLevelShown = PermissionLevelShown;
---@diagnostic disable-next-line
---@alias PermissionLevelShown Enum.PermissionLevelShown
---@class Enum.PhysicsSimulationRate
---@field public Fixed240Hz number | '0'
---@field public Fixed120Hz number | '1'
---@field public Fixed60Hz number | '2'
local PhysicsSimulationRate;
---
PhysicsSimulationRate.Fixed240Hz = nil;
---
PhysicsSimulationRate.Fixed120Hz = nil;
---
PhysicsSimulationRate.Fixed60Hz = nil;
Enum.PhysicsSimulationRate = PhysicsSimulationRate;
---@diagnostic disable-next-line
---@alias PhysicsSimulationRate Enum.PhysicsSimulationRate
---@class Enum.PhysicsSteppingMethod
---@field public Default number | '0'
---@field public Fixed number | '1'
---@field public Adaptive number | '2'
local PhysicsSteppingMethod;
---The current default is Fixed.
---
PhysicsSteppingMethod.Default = nil;
---All simulated assemblies inside the workspace will advance forward at 240
---Hz. This option is best for optimal stability and simulation accuracy.
---
PhysicsSteppingMethod.Fixed = nil;
---The engine attempts to assign optimal simulation rates for individual
---assemblies of either 240 Hz, 120 Hz, or 60 Hz. This setting is optimized
---for performance.
---
PhysicsSteppingMethod.Adaptive = nil;
Enum.PhysicsSteppingMethod = PhysicsSteppingMethod;
---@diagnostic disable-next-line
---@alias PhysicsSteppingMethod Enum.PhysicsSteppingMethod
---@class Enum.Platform
---@field public Windows number | '0'
---@field public OSX number | '1'
---@field public IOS number | '2'
---@field public Android number | '3'
---@field public XBoxOne number | '4'
---@field public PS4 number | '5'
---@field public PS3 number | '6'
---@field public XBox360 number | '7'
---@field public WiiU number | '8'
---@field public NX number | '9'
---@field public Ouya number | '10'
---@field public AndroidTV number | '11'
---@field public Chromecast number | '12'
---@field public Linux number | '13'
---@field public SteamOS number | '14'
---@field public WebOS number | '15'
---@field public DOS number | '16'
---@field public BeOS number | '17'
---@field public UWP number | '18'
---@field public None number | '19'
---The Platform Enum is used to determine the operating system of the client.
---Currently this can only be used in `CoreScript`s.
---
local Platform;
---The client is running on a Windows Operating System.
---
Platform.Windows = nil;
---The client is running on OSX (Apple desktop).
---
Platform.OSX = nil;
---The client is running on IOS (Apple mobile).
---
Platform.IOS = nil;
---The client is running on Android (Google mobile).
---
Platform.Android = nil;
---The client is running on an XBox One (console).
---
Platform.XBoxOne = nil;
---The client is running on a PS4 (console).
---
Platform.PS4 = nil;
---The client is running on a PS3 (console).
---
Platform.PS3 = nil;
---The client is running on an XBox 360 (console).
---
Platform.XBox360 = nil;
---The client is running on a Wii U (console).
---
Platform.WiiU = nil;
---The client is running on an NX Operating System (Cisco Nexus).
---
Platform.NX = nil;
---The client is running on an Ouya Operating System (Android-Based).
---
Platform.Ouya = nil;
---The client is running on an Android TV.
---
Platform.AndroidTV = nil;
---The client is running on Chromecast.
---
Platform.Chromecast = nil;
---The client is running on a Linux Operating System (desktop).
---
Platform.Linux = nil;
---The client is running on Steam.
---
Platform.SteamOS = nil;
---The client is running on WebOS.
---
Platform.WebOS = nil;
---The client is running on DOS.
---
Platform.DOS = nil;
---The client is running on BeOS.
---
Platform.BeOS = nil;
---The client is running on UWP.
---
Platform.UWP = nil;
---The client's operating system is unknown.
---
Platform.None = nil;
Enum.Platform = Platform;
---@diagnostic disable-next-line
---@alias Platform Enum.Platform
---@class Enum.PlaybackState
---@field public Begin number | '0'
---@field public Delayed number | '1'
---@field public Playing number | '2'
---@field public Paused number | '3'
---@field public Completed number | '4'
---@field public Cancelled number | '5'
---Used by the `Tween/PlaybackState` property to describe the current state of
---the playback of a `Tween`.
---
local PlaybackState;
---The tween is beginning to play.
---
PlaybackState.Begin = nil;
---The tween is delayed.
---
PlaybackState.Delayed = nil;
---The tween is currently in progress.
---
PlaybackState.Playing = nil;
---The tween is paused in the middle of playing.
---
PlaybackState.Paused = nil;
---The tween completed successfully.
---
PlaybackState.Completed = nil;
---The tween was cancelled before completion.
---
PlaybackState.Cancelled = nil;
Enum.PlaybackState = PlaybackState;
---@diagnostic disable-next-line
---@alias PlaybackState Enum.PlaybackState
---@class Enum.PlayerActions
---@field public CharacterForward number | '0'
---@field public CharacterBackward number | '1'
---@field public CharacterLeft number | '2'
---@field public CharacterRight number | '3'
---@field public CharacterJump number | '4'
---References a movement action taken by a player.
---
local PlayerActions;
---The player moved forward.
---
PlayerActions.CharacterForward = nil;
---The player moved backward.
---
PlayerActions.CharacterBackward = nil;
---The player moved left.
---
PlayerActions.CharacterLeft = nil;
---The player moved right.
---
PlayerActions.CharacterRight = nil;
---The player jumped.
---
PlayerActions.CharacterJump = nil;
Enum.PlayerActions = PlayerActions;
---@diagnostic disable-next-line
---@alias PlayerActions Enum.PlayerActions
---@class Enum.PlayerChatType
---@field public All number | '0'
---@field public Team number | '1'
---@field public Whisper number | '2'
---Used by Roblox's Chat to determine the style of a chat message. If you want to
---check for this kind of stuff, see `Player/Chatted`.
---
local PlayerChatType;
---A global message that everyone can receive.
---
PlayerChatType.All = nil;
---A team message only players in the same team can receive.
---
PlayerChatType.Team = nil;
---A whispered message only the person it's whispered to can receive.
---
PlayerChatType.Whisper = nil;
Enum.PlayerChatType = PlayerChatType;
---@diagnostic disable-next-line
---@alias PlayerChatType Enum.PlayerChatType
---@class Enum.PoseEasingDirection
---@field public Out number | '1'
---@field public InOut number | '2'
---@field public In number | '0'
local PoseEasingDirection;
---
PoseEasingDirection.Out = nil;
---
PoseEasingDirection.InOut = nil;
---
PoseEasingDirection.In = nil;
Enum.PoseEasingDirection = PoseEasingDirection;
---@diagnostic disable-next-line
---@alias PoseEasingDirection Enum.PoseEasingDirection
---@class Enum.PoseEasingStyle
---@field public Linear number | '0'
---@field public Constant number | '1'
---@field public Elastic number | '2'
---@field public Cubic number | '3'
---@field public Bounce number | '4'
local PoseEasingStyle;
---
PoseEasingStyle.Linear = nil;
---
PoseEasingStyle.Constant = nil;
---
PoseEasingStyle.Elastic = nil;
---
PoseEasingStyle.Cubic = nil;
---
PoseEasingStyle.Bounce = nil;
Enum.PoseEasingStyle = PoseEasingStyle;
---@diagnostic disable-next-line
---@alias PoseEasingStyle Enum.PoseEasingStyle
---@class Enum.PositionAlignmentMode
---@field public OneAttachment number | '0'
---@field public TwoAttachment number | '1'
---The PositionAlignmentMode Enum is used to select the number of `Attachment`s
---used in an alignment.
---
local PositionAlignmentMode;
---Use one attachment.
---
PositionAlignmentMode.OneAttachment = nil;
---Use two attachments.
---
PositionAlignmentMode.TwoAttachment = nil;
Enum.PositionAlignmentMode = PositionAlignmentMode;
---@diagnostic disable-next-line
---@alias PositionAlignmentMode Enum.PositionAlignmentMode
---@class Enum.PrivilegeType
---@field public Banned number | '0'
---@field public Visitor number | '10'
---@field public Member number | '128'
---@field public Admin number | '240'
---@field public Owner number | '255'
local PrivilegeType;
---
PrivilegeType.Banned = nil;
---
PrivilegeType.Visitor = nil;
---
PrivilegeType.Member = nil;
---
PrivilegeType.Admin = nil;
---
PrivilegeType.Owner = nil;
Enum.PrivilegeType = PrivilegeType;
---@diagnostic disable-next-line
---@alias PrivilegeType Enum.PrivilegeType
---@class Enum.ProductLocationRestriction
---@field public AvatarShop number | '0'
---@field public AllowedGames number | '1'
---@field public AllGames number | '2'
local ProductLocationRestriction;
---Item is purchasable only in the Avatar Shop.
---
ProductLocationRestriction.AvatarShop = nil;
---Item is purchasable in the Avatar Shop and experiences owned by the item
---creator.
---
ProductLocationRestriction.AllowedGames = nil;
---(Default) Item is purchasable in the Avatar Shop and all experiences.
---
ProductLocationRestriction.AllGames = nil;
Enum.ProductLocationRestriction = ProductLocationRestriction;
---@diagnostic disable-next-line
---@alias ProductLocationRestriction Enum.ProductLocationRestriction
---@class Enum.ProductPurchaseDecision
---@field public NotProcessedYet number | '0'
---@field public PurchaseGranted number | '1'
---The `ProductPurchaseDecisionEnum` is used to work with `MarketplaceService`,
---and the sale of developer products.
---
local ProductPurchaseDecision;
---The purchase request has been sent but not yet processed.
---
ProductPurchaseDecision.NotProcessedYet = nil;
---The purchase has been processed and granted to the user who initiated the
---purchase request.
---
ProductPurchaseDecision.PurchaseGranted = nil;
Enum.ProductPurchaseDecision = ProductPurchaseDecision;
---@diagnostic disable-next-line
---@alias ProductPurchaseDecision Enum.ProductPurchaseDecision
---@class Enum.ProximityPromptExclusivity
---@field public OnePerButton number | '0'
---@field public OneGlobally number | '1'
---@field public AlwaysShow number | '2'
local ProximityPromptExclusivity;
---Only one prompt will be shown with this setting.
---
ProximityPromptExclusivity.OnePerButton = nil;
---One prompt will be shown per input `enum/KeyCode`.
---
ProximityPromptExclusivity.OneGlobally = nil;
---This prompt will always show when in range and visible.
---
ProximityPromptExclusivity.AlwaysShow = nil;
Enum.ProximityPromptExclusivity = ProximityPromptExclusivity;
---@diagnostic disable-next-line
---@alias ProximityPromptExclusivity Enum.ProximityPromptExclusivity
---@class Enum.ProximityPromptInputType
---@field public Keyboard number | '0'
---@field public Gamepad number | '1'
---@field public Touch number | '2'
local ProximityPromptInputType;
---
ProximityPromptInputType.Keyboard = nil;
---
ProximityPromptInputType.Gamepad = nil;
---
ProximityPromptInputType.Touch = nil;
Enum.ProximityPromptInputType = ProximityPromptInputType;
---@diagnostic disable-next-line
---@alias ProximityPromptInputType Enum.ProximityPromptInputType
---@class Enum.ProximityPromptStyle
---@field public Default number | '0'
---@field public Custom number | '1'
local ProximityPromptStyle;
---The default prompt UI style.
---
ProximityPromptStyle.Default = nil;
---Custom prompt UI style as set by the developer. For more information, see
---`ProximityPrompt/Style`.
---
ProximityPromptStyle.Custom = nil;
Enum.ProximityPromptStyle = ProximityPromptStyle;
---@diagnostic disable-next-line
---@alias ProximityPromptStyle Enum.ProximityPromptStyle
---@class Enum.QualityLevel
---@field public Automatic number | '0'
---@field public Level01 number | '1'
---@field public Level02 number | '2'
---@field public Level03 number | '3'
---@field public Level04 number | '4'
---@field public Level05 number | '5'
---@field public Level06 number | '6'
---@field public Level07 number | '7'
---@field public Level08 number | '8'
---@field public Level09 number | '9'
---@field public Level10 number | '10'
---@field public Level11 number | '11'
---@field public Level12 number | '12'
---@field public Level13 number | '13'
---@field public Level14 number | '14'
---@field public Level15 number | '15'
---@field public Level16 number | '16'
---@field public Level17 number | '17'
---@field public Level18 number | '18'
---@field public Level19 number | '19'
---@field public Level20 number | '20'
---@field public Level21 number | '21'
---Controls the rendering quality of the game. Higher levels correspond to higher
---quality graphics.
---
---As QualityLevel increases, Roblox rendering engine increases the rendering
---distance, shading quality, apparent geometry and texture resolution, limits on
---particles that are being rendered, fidelity of trail effects, post-effect
---quality and more. On low quality levels some post effects may be completely
---disabled and objects that are far away will not be rendered.
---
---The specific effects of quality level on the individual elements of the scene
---or individual rendering features are platform- and device- specific and can
---not be relied upon.
---
local QualityLevel;
---The quality level of graphics is determined automatically depending on the
---client's setting for either game performance or graphic quality.
---
QualityLevel.Automatic = nil;
---Graphic quality level 1 - the lowest quality level.
---
QualityLevel.Level01 = nil;
---Graphic quality level 2.
---
QualityLevel.Level02 = nil;
---Graphic quality level 3.
---
QualityLevel.Level03 = nil;
---Graphic quality level 4.
---
QualityLevel.Level04 = nil;
---Graphic quality level 5.
---
QualityLevel.Level05 = nil;
---Graphic quality level 6.
---
QualityLevel.Level06 = nil;
---Graphic quality level 7.
---
QualityLevel.Level07 = nil;
---Graphic quality level 8.
---
QualityLevel.Level08 = nil;
---Graphic quality level 9.
---
QualityLevel.Level09 = nil;
---Graphic quality level 10.
---
QualityLevel.Level10 = nil;
---Graphic quality level 11.
---
QualityLevel.Level11 = nil;
---Graphic quality level 12.
---
QualityLevel.Level12 = nil;
---Graphic quality level 13.
---
QualityLevel.Level13 = nil;
---Graphic quality level 14.
---
QualityLevel.Level14 = nil;
---Graphic quality level 15.
---
QualityLevel.Level15 = nil;
---Graphic quality level 16.
---
QualityLevel.Level16 = nil;
---Graphic quality level 17.
---
QualityLevel.Level17 = nil;
---Graphic quality level 18.
---
QualityLevel.Level18 = nil;
---Graphic quality level 19.
---
QualityLevel.Level19 = nil;
---Graphic quality level 20.
---
QualityLevel.Level20 = nil;
---Graphic quality level 21, the highest quality level.
---
QualityLevel.Level21 = nil;
Enum.QualityLevel = QualityLevel;
---@diagnostic disable-next-line
---@alias QualityLevel Enum.QualityLevel
---@class Enum.R15CollisionType
---@field public OuterBox number | '0'
---@field public InnerBox number | '1'
---Internal enum used to save the the collision behavior setting for R15
---characters.
---
local R15CollisionType;
---Dynamically sized collision boxes based on mesh sizes.
---
R15CollisionType.OuterBox = nil;
---Fixed size collision boxes, similar to the classic avatar collision.
---
R15CollisionType.InnerBox = nil;
Enum.R15CollisionType = R15CollisionType;
---@diagnostic disable-next-line
---@alias R15CollisionType Enum.R15CollisionType
---@class Enum.RaycastFilterType
---@field public Blacklist number | '0'
---@field public Whitelist number | '1'
---Used in a `datatype/RaycastParams` object to determine how its
---`FilterDescendantsInstances` list will be used.
---
local RaycastFilterType;
---Every `BasePart` in the game will be considered except those that are
---descendants of objects in the filter list.
---
RaycastFilterType.Blacklist = nil;
---Only `BasePart|BaseParts` which are descendants of objects in the filter
---list will be considered in the raycast operation.
---
RaycastFilterType.Whitelist = nil;
Enum.RaycastFilterType = RaycastFilterType;
---@diagnostic disable-next-line
---@alias RaycastFilterType Enum.RaycastFilterType
---@class Enum.RenderFidelity
---@field public Automatic number | '0'
---@field public Precise number | '1'
---@field public Performance number | '2'
---This enum determines the level of detail that solid-modeled and mesh parts
---will be shown in.
---
---By default, solid-modeled and mesh parts will always be shown in precise
---fidelity, no matter how far they are from the game camera. This improves their
---appearance when viewed from any distance, but if a place has a large number of
---detailed solid-modeled or mesh parts, it may reduce overall game performance.
---
---<table>
---    <thead>
---        <tr>
---            <th>Distance From Camera</th>
---            <th>Render Fidelity</th>
---        </tr>
---    </thead>
---    <tbody>
---        <tr>
---            <td>Less than 250 studs</td>
---            <td>Highest</td>
---        </tr>
---        <tr>
---            <td>250 to 500 studs</td>
---            <td>Medium</td>
---        </tr>
---        <tr>
---            <td>500 or more studs</td>
---            <td>Lowest</td>
---        </tr>
---    </tbody>
---</table>
---
---See also:
---
---- Improving Performance, an article discussing tips for analyzing and
---  improving game performance.
---
local RenderFidelity;
---Dynamically control a solid-modeled and mesh part's level of detail
---depending on its distance from the camera (see table above).
---
RenderFidelity.Automatic = nil;
---Specifically set a solid-modeled and mesh part's level of detail
---regardless of its distance from the camera (lowest, medium, or highest).
---
RenderFidelity.Precise = nil;
---Push performance as much as possible, trying to maintain quality if
---possible, and discarding appearance if that's necessary to reach
---performance. This means that the performance will always be excellent, but
---mesh visuals may be affected negatively.
---
RenderFidelity.Performance = nil;
Enum.RenderFidelity = RenderFidelity;
---@diagnostic disable-next-line
---@alias RenderFidelity Enum.RenderFidelity
---@class Enum.RenderPriority
---@field public First number | '0'
---@field public Input number | '100'
---@field public Camera number | '200'
---@field public Character number | '300'
---@field public Last number | '2000'
---A list of standard reserved values in BindToRenderStep.
---
---See `RunService/BindToRenderStep` for the proper usage, as the enum itself
---isn't used.
---
local RenderPriority;
---This should run first.
---
RenderPriority.First = nil;
---This should run as second.
---
RenderPriority.Input = nil;
---This should run after Input.
---
RenderPriority.Camera = nil;
---This should run after Camera.
---
RenderPriority.Character = nil;
---This should run as last, after Character.
---
RenderPriority.Last = nil;
Enum.RenderPriority = RenderPriority;
---@diagnostic disable-next-line
---@alias RenderPriority Enum.RenderPriority
---@class Enum.RenderingTestComparisonMethod
---@field public psnr number | '0'
---@field public diff number | '1'
local RenderingTestComparisonMethod;
---
RenderingTestComparisonMethod.psnr = nil;
---
RenderingTestComparisonMethod.diff = nil;
Enum.RenderingTestComparisonMethod = RenderingTestComparisonMethod;
---@diagnostic disable-next-line
---@alias RenderingTestComparisonMethod Enum.RenderingTestComparisonMethod
---@class Enum.ReplicateInstanceDestroySetting
---@field public Default number | '0'
---@field public Disabled number | '1'
---@field public Enabled number | '2'
local ReplicateInstanceDestroySetting;
---
ReplicateInstanceDestroySetting.Default = nil;
---
ReplicateInstanceDestroySetting.Disabled = nil;
---
ReplicateInstanceDestroySetting.Enabled = nil;
Enum.ReplicateInstanceDestroySetting = ReplicateInstanceDestroySetting;
---@diagnostic disable-next-line
---@alias ReplicateInstanceDestroySetting Enum.ReplicateInstanceDestroySetting
---@class Enum.ResamplerMode
---@field public Default number | '0'
---@field public Pixelated number | '1'
---Determines the image filtering used.
---
local ResamplerMode;
---Bilinear filtering of the four near pixels in the image.
---
ResamplerMode.Default = nil;
---Nearest neighbor filtering of the closest pixel in the image.
---
ResamplerMode.Pixelated = nil;
Enum.ResamplerMode = ResamplerMode;
---@diagnostic disable-next-line
---@alias ResamplerMode Enum.ResamplerMode
---@class Enum.ReturnKeyType
---@field public Default number | '0'
---@field public Done number | '1'
---@field public Go number | '2'
---@field public Next number | '3'
---@field public Search number | '4'
---@field public Send number | '5'
local ReturnKeyType;
---
ReturnKeyType.Default = nil;
---
ReturnKeyType.Done = nil;
---
ReturnKeyType.Go = nil;
---
ReturnKeyType.Next = nil;
---
ReturnKeyType.Search = nil;
---
ReturnKeyType.Send = nil;
Enum.ReturnKeyType = ReturnKeyType;
---@diagnostic disable-next-line
---@alias ReturnKeyType Enum.ReturnKeyType
---@class Enum.ReverbType
---@field public NoReverb number | '0'
---@field public GenericReverb number | '1'
---@field public PaddedCell number | '2'
---@field public Room number | '3'
---@field public Bathroom number | '4'
---@field public LivingRoom number | '5'
---@field public StoneRoom number | '6'
---@field public Auditorium number | '7'
---@field public ConcertHall number | '8'
---@field public Cave number | '9'
---@field public Arena number | '10'
---@field public Hangar number | '11'
---@field public CarpettedHallway number | '12'
---@field public Hallway number | '13'
---@field public StoneCorridor number | '14'
---@field public Alley number | '15'
---@field public Forest number | '16'
---@field public City number | '17'
---@field public Mountains number | '18'
---@field public Quarry number | '19'
---@field public Plain number | '20'
---@field public ParkingLot number | '21'
---@field public SewerPipe number | '22'
---@field public UnderWater number | '23'
---The ReverbType Enum allows you to make audio in your game sound different,
---depending on what "area" the sounds are in.
---
---Note that some of these do not appear to have any effect on the sound.
---
local ReverbType;
---No sound reverb. Audio is not changed from default.
---
ReverbType.NoReverb = nil;
---Sound reverb is changed to a generic reverb effect.
---
ReverbType.GenericReverb = nil;
---Sound reverb is changed to sound like the player is in a padded cell.
---
ReverbType.PaddedCell = nil;
---Sound reverb is changed to sound like the player is in a room.
---
ReverbType.Room = nil;
---Sound reverb is changed to sound like the player is a bathroom.
---
ReverbType.Bathroom = nil;
---Sound reverb is changed to sound like the player is in a living room.
---
ReverbType.LivingRoom = nil;
---Sound reverb is changed to sound like the player is in a stone room.
---
ReverbType.StoneRoom = nil;
---Sound reverb is changed to sound like the player is in an auditorium.
---
ReverbType.Auditorium = nil;
---Sound reverb is changed to sound like the player is in a concert hall.
---
ReverbType.ConcertHall = nil;
---Sound reverb is changed to sound like the player is in a cave.
---
ReverbType.Cave = nil;
---Sound reverb is changed to sound like the player is in an arena.
---
ReverbType.Arena = nil;
---Sound reverb is changed to sound like the player is in a hangar.
---
ReverbType.Hangar = nil;
---Sound reverb is changed to sound like the player is in a carpeted hallway.
---
ReverbType.CarpettedHallway = nil;
---Sound reverb is changed to sound like the player is in a hallway.
---
ReverbType.Hallway = nil;
---Sound reverb is changed to sound like the player is a stone corridor.
---
ReverbType.StoneCorridor = nil;
---Sound reverb is changed to sound like the player is in an alley.
---
ReverbType.Alley = nil;
---Sound reverb is changed to sound like the player is in a forest.
---
ReverbType.Forest = nil;
---Sound reverb is changed to sound like the player is in city.
---
ReverbType.City = nil;
---Sound reverb is changed to sound like the player is in the mountains.
---
ReverbType.Mountains = nil;
---Sound reverb is changed to sound like the player is in a quarry.
---
ReverbType.Quarry = nil;
---Sound reverb is changed to sound like the player is an open plain.
---
ReverbType.Plain = nil;
---Sound reverb is changed to sound like the player is in a parking lot.
---
ReverbType.ParkingLot = nil;
---Sound reverb is changed to sound like the player is in a sewer pipe.
---
ReverbType.SewerPipe = nil;
---Sound reverb makes it sound like the player is under water.
---
ReverbType.UnderWater = nil;
Enum.ReverbType = ReverbType;
---@diagnostic disable-next-line
---@alias ReverbType Enum.ReverbType
---@class Enum.RibbonTool
---@field public Select number | '0'
---@field public Scale number | '1'
---@field public Rotate number | '2'
---@field public Move number | '3'
---@field public Transform number | '4'
---@field public ColorPicker number | '5'
---@field public MaterialPicker number | '6'
---@field public Group number | '7'
---@field public Ungroup number | '8'
---@field public None number | '9'
local RibbonTool;
---
RibbonTool.Select = nil;
---
RibbonTool.Scale = nil;
---
RibbonTool.Rotate = nil;
---
RibbonTool.Move = nil;
---
RibbonTool.Transform = nil;
---
RibbonTool.ColorPicker = nil;
---
RibbonTool.MaterialPicker = nil;
---
RibbonTool.Group = nil;
---
RibbonTool.Ungroup = nil;
---
RibbonTool.None = nil;
Enum.RibbonTool = RibbonTool;
---@diagnostic disable-next-line
---@alias RibbonTool Enum.RibbonTool
---@class Enum.RigType
---@field public R15 number | '0'
---@field public Rthro number | '1'
---@field public RthroNarrow number | '2'
---@field public Custom number | '3'
---@field public None number | '4'
---The type of rig being imported with the Avatar Importer
---
local RigType;
---A rig type of R15.
---
RigType.R15 = nil;
---A rig type of Rthro.
---
RigType.Rthro = nil;
---A rig type of RthroNarrow.
---
RigType.RthroNarrow = nil;
---A rig type of Custom.
---
RigType.Custom = nil;
---A rig type of None.
---
RigType.None = nil;
Enum.RigType = RigType;
---@diagnostic disable-next-line
---@alias RigType Enum.RigType
---@class Enum.RollOffMode
---@field public Inverse number | '0'
---@field public Linear number | '1'
---@field public InverseTapered number | '3'
---@field public LinearSquare number | '2'
---How 3D `Sound|Sounds` attenuate (fade out) as the distance between the
---listener and the Sound's parent increases.
---
---## What is Attenuation?
---
---Acoustic attenuation refers to how sound diminishes as it travels through a
---medium or across increasing distances.
---
---## Inverse vs Linear Distance Attenuation
---
---Inverse distance attenuation (Enum.RollOffMode.Inverse) mirrors how sounds
---attenuate in the real world. Under inverse distance attenuation, sounds will
---begin to attenuate once the distance between the listener and the Sound's
---parent exceeds `Sound/EmitterSize`. The rate of attenuation depends on the
---emitter size, as sounds with larger EmitterSize's will attenuate at a slower
---rate. Inverse rate of inverse distance attenuation is further influenced by
---`SoundService/RolloffScale`.
---
---Note, `Sound/MaxDistance` will not effect attenuation under the inverse model
---but will cause the sound to cut off completely once this distance is reached.
---This can be particularly abrupt when using low values for max distance.
---
---Linear distance attenuation works differently. Under linear distance
---attenuation the sound will attenuate between EmitterSize and MaxDistance,
---falling silent once MaxDistance is reached. EmitterSize still denotes the
---point at which the sound will begin attenuating. However, the audible volume
---at any point now depends on the point the listener is at between EmitterSize
---and MaxDistance. This means, in contrast to the inverse distance attenuation
---model, the audible volume of the sound will approach silence at MaxDistance
---point. This is less realistic, but may be more desirable in some cases.
---
local RollOffMode;
---Volume attenuates from `Sound/EmitterSize` in an inverse manner.
---
RollOffMode.Inverse = nil;
---A hybrid model. Follows the Inverse model when close to
---`Sound/EmitterSize` and the Linear Square model when close to
---`Sound/MaxDistance`.
---
RollOffMode.Linear = nil;
---Volume attenuates between `Sound/EmitterSize` and `Sound/MaxDistance` with
---a linear relationship.
---
RollOffMode.InverseTapered = nil;
---Volume attenuates between `Sound/EmitterSize` and `Sound/MaxDistance` with
---a linear squared relationship.
---
RollOffMode.LinearSquare = nil;
Enum.RollOffMode = RollOffMode;
---@diagnostic disable-next-line
---@alias RollOffMode Enum.RollOffMode
---@class Enum.RotationOrder
---@field public XYZ number | '0'
---@field public XZY number | '1'
---@field public YZX number | '2'
---@field public YXZ number | '3'
---@field public ZXY number | '4'
---@field public ZYX number | '5'
---Euler Angles encode a rotation in 3D space via a sequence of 3 rotations along
---the 3 axis X Y Z. The RotationOrder Enum specifies the order in which the 3
---rotations are applied.
---
local RotationOrder;
---Applies rotations in order X, Y, Z.
---
RotationOrder.XYZ = nil;
---Applies rotations in order X, Z, Y.
---
RotationOrder.XZY = nil;
---Applies rotations in order Y, Z, X.
---
RotationOrder.YZX = nil;
---Applies rotations in order Y, X, Z.
---
RotationOrder.YXZ = nil;
---Applies rotations in order Z, X, Y.
---
RotationOrder.ZXY = nil;
---Applies rotations in order Z, Y, X.
---
RotationOrder.ZYX = nil;
Enum.RotationOrder = RotationOrder;
---@diagnostic disable-next-line
---@alias RotationOrder Enum.RotationOrder
---@class Enum.RotationType
---@field public MovementRelative number | '0'
---@field public CameraRelative number | '1'
local RotationType;
---
RotationType.MovementRelative = nil;
---
RotationType.CameraRelative = nil;
Enum.RotationType = RotationType;
---@diagnostic disable-next-line
---@alias RotationType Enum.RotationType
---@class Enum.RuntimeUndoBehavior
---@field public Aggregate number | '0'
---@field public Snapshot number | '1'
---@field public Hybrid number | '2'
local RuntimeUndoBehavior;
---
RuntimeUndoBehavior.Aggregate = nil;
---
RuntimeUndoBehavior.Snapshot = nil;
---
RuntimeUndoBehavior.Hybrid = nil;
Enum.RuntimeUndoBehavior = RuntimeUndoBehavior;
---@diagnostic disable-next-line
---@alias RuntimeUndoBehavior Enum.RuntimeUndoBehavior
---@class Enum.SaveFilter
---@field public SaveAll number | '2'
---@field public SaveWorld number | '0'
---@field public SaveGame number | '1'
local SaveFilter;
---
SaveFilter.SaveAll = nil;
---
SaveFilter.SaveWorld = nil;
---
SaveFilter.SaveGame = nil;
Enum.SaveFilter = SaveFilter;
---@diagnostic disable-next-line
---@alias SaveFilter Enum.SaveFilter
---@class Enum.SavedQualitySetting
---@field public Automatic number | '0'
---@field public QualityLevel1 number | '1'
---@field public QualityLevel2 number | '2'
---@field public QualityLevel3 number | '3'
---@field public QualityLevel4 number | '4'
---@field public QualityLevel5 number | '5'
---@field public QualityLevel6 number | '6'
---@field public QualityLevel7 number | '7'
---@field public QualityLevel8 number | '8'
---@field public QualityLevel9 number | '9'
---@field public QualityLevel10 number | '10'
local SavedQualitySetting;
---
SavedQualitySetting.Automatic = nil;
---
SavedQualitySetting.QualityLevel1 = nil;
---
SavedQualitySetting.QualityLevel2 = nil;
---
SavedQualitySetting.QualityLevel3 = nil;
---
SavedQualitySetting.QualityLevel4 = nil;
---
SavedQualitySetting.QualityLevel5 = nil;
---
SavedQualitySetting.QualityLevel6 = nil;
---
SavedQualitySetting.QualityLevel7 = nil;
---
SavedQualitySetting.QualityLevel8 = nil;
---
SavedQualitySetting.QualityLevel9 = nil;
---
SavedQualitySetting.QualityLevel10 = nil;
Enum.SavedQualitySetting = SavedQualitySetting;
---@diagnostic disable-next-line
---@alias SavedQualitySetting Enum.SavedQualitySetting
---@class Enum.ScaleType
---@field public Stretch number | '0'
---@field public Slice number | '1'
---@field public Tile number | '2'
---@field public Fit number | '3'
---@field public Crop number | '4'
---Determines how an image (of a `ImageLabel` or `ImageButton`) is scaled. Below
---is an example of different `ScaleType`s applied to the same `ImageLabel` or
---`ImageButton`:
---
---![ScaleType Example](assets/bltf55b26f47aa4ae56/ScaleType_Comparison.png)
---
local ScaleType;
---The image is stretched to fit within the element.
---
ScaleType.Stretch = nil;
---9-Slice scaling: slice the image into 9 regions and apply different
---scaling rules to each region. The slice boundaries are determined by
---`ImageLabel/SliceCenter` or `ImageButton/SliceCenter`. See UI 9 Slice
---Design for more information.
---
ScaleType.Slice = nil;
---The image is is tiled to fit within the element. For example, if the
---element is twice the X dimension of the image, the image will appear twice
---(2 tiles).
---
ScaleType.Tile = nil;
---The image is scaled fit within the element X or Y dimension (whichever
---fits first).
---
ScaleType.Fit = nil;
---The image is cropped to fit within the element.
---
ScaleType.Crop = nil;
Enum.ScaleType = ScaleType;
---@diagnostic disable-next-line
---@alias ScaleType Enum.ScaleType
---@class Enum.ScreenOrientation
---@field public LandscapeLeft number | '0'
---@field public LandscapeRight number | '1'
---@field public LandscapeSensor number | '2'
---@field public Portrait number | '3'
---@field public Sensor number | '4'
---Indicates what orientation the game prefers to be played on mobile devices.
---
local ScreenOrientation;
---A preference where the game is displayed landscape (horizontally) with the
---bottom of the device on the left side of the screen.
---
ScreenOrientation.LandscapeLeft = nil;
---A preference where the game is displayed landscape (horizontally) with the
---bottom of the device on the right side of the screen.
---
ScreenOrientation.LandscapeRight = nil;
---A preference where the game is displayed landscape (horizontally) with the
---bottom of the device on the left of right side of the screen depending on
---the device's orientation (the sensor determines which side allows for the
---game to be displayed right-side-up).
---
ScreenOrientation.LandscapeSensor = nil;
---A preference where the game is displayed portrait (vertically) with the
---bottom of the device on the bottom of the screen.
---
ScreenOrientation.Portrait = nil;
---A preference where the game is displayed depending on the best match to
---the device's current orientation - either landscape (left/right) or
---portrait.
---
ScreenOrientation.Sensor = nil;
Enum.ScreenOrientation = ScreenOrientation;
---@diagnostic disable-next-line
---@alias ScreenOrientation Enum.ScreenOrientation
---@class Enum.ScrollBarInset
---@field public None number | '0'
---@field public ScrollBar number | '1'
---@field public Always number | '2'
---Indicates when the `ScrollingFrame` should be insetted by the space needed to
---show the scroll bar.
---
local ScrollBarInset;
---The ScrollingFrame will never be insetted for this scrolling bar.
---
ScrollBarInset.None = nil;
---The ScrollingFrame will only be insetted if this scrollbar is being shown.
---
ScrollBarInset.ScrollBar = nil;
---The ScrollingFrame will always be insetted regardless if the scrollbar is
---being shown or not.
---
ScrollBarInset.Always = nil;
Enum.ScrollBarInset = ScrollBarInset;
---@diagnostic disable-next-line
---@alias ScrollBarInset Enum.ScrollBarInset
---@class Enum.ScrollingDirection
---@field public X number | '1'
---@field public Y number | '2'
---@field public XY number | '4'
---This enum is used by `ScrollingFrame/ScrollingDirection` to specify the
---direction scrolling is allowed.
---
local ScrollingDirection;
---Canvas can only be scrolled along the X axis.
---
ScrollingDirection.X = nil;
---Canvas can only be scrolled along the Y axis.
---
ScrollingDirection.Y = nil;
---Canvas can be scrolled along both X and Y axes.
---
ScrollingDirection.XY = nil;
Enum.ScrollingDirection = ScrollingDirection;
---@diagnostic disable-next-line
---@alias ScrollingDirection Enum.ScrollingDirection
---@class Enum.ServerAudioBehavior
---@field public Enabled number | '0'
---@field public Muted number | '1'
---@field public OnlineGame number | '2'
local ServerAudioBehavior;
---
ServerAudioBehavior.Enabled = nil;
---
ServerAudioBehavior.Muted = nil;
---
ServerAudioBehavior.OnlineGame = nil;
Enum.ServerAudioBehavior = ServerAudioBehavior;
---@diagnostic disable-next-line
---@alias ServerAudioBehavior Enum.ServerAudioBehavior
---@class Enum.SignalBehavior
---@field public Default number | '0'
---@field public Immediate number | '1'
---@field public Deferred number | '2'
---@field public AncestryDeferred number | '3'
local SignalBehavior;
---
SignalBehavior.Default = nil;
---
SignalBehavior.Immediate = nil;
---
SignalBehavior.Deferred = nil;
---
SignalBehavior.AncestryDeferred = nil;
Enum.SignalBehavior = SignalBehavior;
---@diagnostic disable-next-line
---@alias SignalBehavior Enum.SignalBehavior
---@class Enum.SizeConstraint
---@field public RelativeXY number | '0'
---@field public RelativeXX number | '1'
---@field public RelativeYY number | '2'
---Used to constrain the scale of a GUI object.
---
local SizeConstraint;
---The scale of X and Y are independent.
---
SizeConstraint.RelativeXY = nil;
---The scale of X is shared with Y.
---
SizeConstraint.RelativeXX = nil;
---The scale of Y is shared with X.
---
SizeConstraint.RelativeYY = nil;
Enum.SizeConstraint = SizeConstraint;
---@diagnostic disable-next-line
---@alias SizeConstraint Enum.SizeConstraint
---@class Enum.SortDirection
---@field public Ascending number | '0'
---@field public Descending number | '1'
local SortDirection;
---
SortDirection.Ascending = nil;
---
SortDirection.Descending = nil;
Enum.SortDirection = SortDirection;
---@diagnostic disable-next-line
---@alias SortDirection Enum.SortDirection
---@class Enum.SortOrder
---@field public Name number | '0'
---@field public Custom number | '1'
---@field public LayoutOrder number | '2'
---Used by `UIGridStyleLayout/SortOrder` to order the elements in the layout.
---
local SortOrder;
---Elements will be ordered by their `Instance/Name` in alphabetical order
---(e.g. Apple will be placed before Banana).
---
SortOrder.Name = nil;
---Deprecated. Elements are ordered by the function passed to
---`UIGridStyleLayout/SetCustomSortFunction`.
---
SortOrder.Custom = nil;
---Elements will be ordered by `GuiObject/LayoutOrder` in ascending order
---(e.g. 0 will be placed before 1).
---
SortOrder.LayoutOrder = nil;
Enum.SortOrder = SortOrder;
---@diagnostic disable-next-line
---@alias SortOrder Enum.SortOrder
---@class Enum.SpecialKey
---@field public Insert number | '0'
---@field public Home number | '1'
---@field public End number | '2'
---@field public PageUp number | '3'
---@field public PageDown number | '4'
---@field public ChatHotkey number | '5'
local SpecialKey;
---
SpecialKey.Insert = nil;
---
SpecialKey.Home = nil;
---
SpecialKey.End = nil;
---
SpecialKey.PageUp = nil;
---
SpecialKey.PageDown = nil;
---
SpecialKey.ChatHotkey = nil;
Enum.SpecialKey = SpecialKey;
---@diagnostic disable-next-line
---@alias SpecialKey Enum.SpecialKey
---@class Enum.StartCorner
---@field public TopLeft number | '0'
---@field public TopRight number | '1'
---@field public BottomLeft number | '2'
---@field public BottomRight number | '3'
---Used by `UIGridLayout/StartCorner` to decide where the first element is
---placed.
---
local StartCorner;
---Grid starts in top left corner.
---
StartCorner.TopLeft = nil;
---Grid starts in top right corner.
---
StartCorner.TopRight = nil;
---Grid starts in bottom left corner.
---
StartCorner.BottomLeft = nil;
---Grid starts in bottom right corner.
---
StartCorner.BottomRight = nil;
Enum.StartCorner = StartCorner;
---@diagnostic disable-next-line
---@alias StartCorner Enum.StartCorner
---@class Enum.Status
---@field public Poison number | '0'
---@field public Confusion number | '1'
---The purpose of this Enum is unknown. It may have been used with the unfinished
---RbxStatus library which would have allowed you to add conditions to a
---Humanoid.
---
local Status;
---
Status.Poison = nil;
---
Status.Confusion = nil;
Enum.Status = Status;
---@diagnostic disable-next-line
---@alias Status Enum.Status
---@class Enum.StreamOutBehavior
---@field public Default number | '0'
---@field public LowMemory number | '1'
---@field public Opportunistic number | '2'
---Determines how content is streamed out from Player clients. This is a
---temporary rollout API. In the future, streaming will always run on
---Opportunistic mode.
---
local StreamOutBehavior;
---Currently equivalent to LowMemory. This will eventually change to
---Opportunistic.
---
StreamOutBehavior.Default = nil;
---Only stream out when memory is low.
---
StreamOutBehavior.LowMemory = nil;
---Stream out content that is significantly outside of the current
---StreamingRadius.
---
StreamOutBehavior.Opportunistic = nil;
Enum.StreamOutBehavior = StreamOutBehavior;
---@diagnostic disable-next-line
---@alias StreamOutBehavior Enum.StreamOutBehavior
---@class Enum.StreamingPauseMode
---@field public Default number | '0'
---@field public Disabled number | '1'
---@field public ClientPhysicsPause number | '2'
---The StreamingPauseMode enum is used to control `Workspace/StreamingPauseMode`
---behavior.
---
---Default behavior is currently equivalent to disabled, but may change in the
---future.
---
---The disabled mode indicates that gameplay continues unchanged even if player
---does not have the minimum streaming radius available.
---
---In ClientPhysicsPause mode client-side physics is paused when the player
---doesn't have the minimum radius present, and resumed when the minimum radius
---is available.
---
---See also:
---
---- `Workspace/StreamingEnabled`, controls whether network streaming is enabled
---  for the place or not
---- `Workspace/StreamingMinRadius`, the minimum distance that parts will be
---  streamed to players with high priority
---- `Workspace/StreamingTargetRadius`, the maximum distance that parts will be
---  streamed to players
---
local StreamingPauseMode;
---Default behavior (currently no change to gameplay).
---
StreamingPauseMode.Default = nil;
---No change to gameplay due to streaming region availability.
---
StreamingPauseMode.Disabled = nil;
---Client owned physics is paused.
---
StreamingPauseMode.ClientPhysicsPause = nil;
Enum.StreamingPauseMode = StreamingPauseMode;
---@diagnostic disable-next-line
---@alias StreamingPauseMode Enum.StreamingPauseMode
---@class Enum.StudioCloseMode
---@field public None number | '0'
---@field public CloseStudio number | '1'
---@field public CloseDoc number | '2'
local StudioCloseMode;
---
StudioCloseMode.None = nil;
---
StudioCloseMode.CloseStudio = nil;
---
StudioCloseMode.CloseDoc = nil;
Enum.StudioCloseMode = StudioCloseMode;
---@diagnostic disable-next-line
---@alias StudioCloseMode Enum.StudioCloseMode
---@class Enum.StudioDataModelType
---@field public Edit number | '0'
---@field public PlayClient number | '1'
---@field public PlayServer number | '2'
---@field public Standalone number | '3'
---@field public None number | '4'
local StudioDataModelType;
---
StudioDataModelType.Edit = nil;
---
StudioDataModelType.PlayClient = nil;
---
StudioDataModelType.PlayServer = nil;
---
StudioDataModelType.Standalone = nil;
---
StudioDataModelType.None = nil;
Enum.StudioDataModelType = StudioDataModelType;
---@diagnostic disable-next-line
---@alias StudioDataModelType Enum.StudioDataModelType
---@class Enum.StudioScriptEditorColorCategories
---@field public Default number | '0'
---@field public Operator number | '1'
---@field public Number number | '2'
---@field public String number | '3'
---@field public Comment number | '4'
---@field public Keyword number | '5'
---@field public Builtin number | '6'
---@field public Method number | '7'
---@field public Property number | '8'
---@field public Nil number | '9'
---@field public Bool number | '10'
---@field public Function number | '11'
---@field public Local number | '12'
---@field public Self number | '13'
---@field public LuauKeyword number | '14'
---@field public FunctionName number | '15'
---@field public TODO number | '16'
---@field public Background number | '17'
---@field public SelectionText number | '18'
---@field public SelectionBackground number | '19'
---@field public FindSelectionBackground number | '20'
---@field public MatchingWordBackground number | '21'
---@field public Warning number | '22'
---@field public Error number | '23'
---@field public Whitespace number | '24'
---@field public ActiveLine number | '25'
---@field public DebuggerCurrentLine number | '26'
---@field public DebuggerErrorLine number | '27'
---@field public Ruler number | '28'
---@field public Bracket number | '29'
---@field public MenuPrimaryText number | '30'
---@field public MenuSecondaryText number | '31'
---@field public MenuSelectedText number | '32'
---@field public MenuBackground number | '33'
---@field public MenuSelectedBackground number | '34'
---@field public MenuScrollbarBackground number | '35'
---@field public MenuScrollbarHandle number | '36'
---@field public MenuBorder number | '37'
---@field public DocViewCodeBackground number | '38'
local StudioScriptEditorColorCategories;
---
StudioScriptEditorColorCategories.Default = nil;
---
StudioScriptEditorColorCategories.Operator = nil;
---
StudioScriptEditorColorCategories.Number = nil;
---
StudioScriptEditorColorCategories.String = nil;
---
StudioScriptEditorColorCategories.Comment = nil;
---
StudioScriptEditorColorCategories.Keyword = nil;
---
StudioScriptEditorColorCategories.Builtin = nil;
---
StudioScriptEditorColorCategories.Method = nil;
---
StudioScriptEditorColorCategories.Property = nil;
---
StudioScriptEditorColorCategories.Nil = nil;
---
StudioScriptEditorColorCategories.Bool = nil;
---
StudioScriptEditorColorCategories.Function = nil;
---
StudioScriptEditorColorCategories.Local = nil;
---
StudioScriptEditorColorCategories.Self = nil;
---
StudioScriptEditorColorCategories.LuauKeyword = nil;
---
StudioScriptEditorColorCategories.FunctionName = nil;
---
StudioScriptEditorColorCategories.TODO = nil;
---
StudioScriptEditorColorCategories.Background = nil;
---
StudioScriptEditorColorCategories.SelectionText = nil;
---
StudioScriptEditorColorCategories.SelectionBackground = nil;
---
StudioScriptEditorColorCategories.FindSelectionBackground = nil;
---
StudioScriptEditorColorCategories.MatchingWordBackground = nil;
---
StudioScriptEditorColorCategories.Warning = nil;
---
StudioScriptEditorColorCategories.Error = nil;
---
StudioScriptEditorColorCategories.Whitespace = nil;
---
StudioScriptEditorColorCategories.ActiveLine = nil;
---
StudioScriptEditorColorCategories.DebuggerCurrentLine = nil;
---
StudioScriptEditorColorCategories.DebuggerErrorLine = nil;
---
StudioScriptEditorColorCategories.Ruler = nil;
---
StudioScriptEditorColorCategories.Bracket = nil;
---
StudioScriptEditorColorCategories.MenuPrimaryText = nil;
---
StudioScriptEditorColorCategories.MenuSecondaryText = nil;
---
StudioScriptEditorColorCategories.MenuSelectedText = nil;
---
StudioScriptEditorColorCategories.MenuBackground = nil;
---
StudioScriptEditorColorCategories.MenuSelectedBackground = nil;
---
StudioScriptEditorColorCategories.MenuScrollbarBackground = nil;
---
StudioScriptEditorColorCategories.MenuScrollbarHandle = nil;
---
StudioScriptEditorColorCategories.MenuBorder = nil;
---
StudioScriptEditorColorCategories.DocViewCodeBackground = nil;
Enum.StudioScriptEditorColorCategories = StudioScriptEditorColorCategories;
---@diagnostic disable-next-line
---@alias StudioScriptEditorColorCategories Enum.StudioScriptEditorColorCategories
---@class Enum.StudioScriptEditorColorPresets
---@field public RobloxDefault number | '0'
---@field public Extra1 number | '1'
---@field public Extra2 number | '2'
---@field public Custom number | '3'
local StudioScriptEditorColorPresets;
---
StudioScriptEditorColorPresets.RobloxDefault = nil;
---
StudioScriptEditorColorPresets.Extra1 = nil;
---
StudioScriptEditorColorPresets.Extra2 = nil;
---
StudioScriptEditorColorPresets.Custom = nil;
Enum.StudioScriptEditorColorPresets = StudioScriptEditorColorPresets;
---@diagnostic disable-next-line
---@alias StudioScriptEditorColorPresets Enum.StudioScriptEditorColorPresets
---@class Enum.StudioStyleGuideColor
---@field public MainBackground number | '0'
---@field public Titlebar number | '1'
---@field public Dropdown number | '2'
---@field public Tooltip number | '3'
---@field public Notification number | '4'
---@field public ScrollBar number | '5'
---@field public ScrollBarBackground number | '6'
---@field public TabBar number | '7'
---@field public Tab number | '8'
---@field public FilterButtonDefault number | '9'
---@field public FilterButtonHover number | '10'
---@field public FilterButtonChecked number | '11'
---@field public FilterButtonAccent number | '12'
---@field public FilterButtonBorder number | '13'
---@field public FilterButtonBorderAlt number | '14'
---@field public RibbonTab number | '15'
---@field public RibbonTabTopBar number | '16'
---@field public Button number | '17'
---@field public MainButton number | '18'
---@field public RibbonButton number | '19'
---@field public ViewPortBackground number | '20'
---@field public InputFieldBackground number | '21'
---@field public Item number | '22'
---@field public TableItem number | '23'
---@field public CategoryItem number | '24'
---@field public GameSettingsTableItem number | '25'
---@field public GameSettingsTooltip number | '26'
---@field public EmulatorBar number | '27'
---@field public EmulatorDropDown number | '28'
---@field public ColorPickerFrame number | '29'
---@field public CurrentMarker number | '30'
---@field public Border number | '31'
---@field public DropShadow number | '32'
---@field public Shadow number | '33'
---@field public Light number | '34'
---@field public Dark number | '35'
---@field public Mid number | '36'
---@field public MainText number | '37'
---@field public SubText number | '38'
---@field public TitlebarText number | '39'
---@field public BrightText number | '40'
---@field public DimmedText number | '41'
---@field public LinkText number | '42'
---@field public WarningText number | '43'
---@field public ErrorText number | '44'
---@field public InfoText number | '45'
---@field public SensitiveText number | '46'
---@field public ScriptSideWidget number | '47'
---@field public ScriptBackground number | '48'
---@field public ScriptText number | '49'
---@field public ScriptSelectionText number | '50'
---@field public ScriptSelectionBackground number | '51'
---@field public ScriptFindSelectionBackground number | '52'
---@field public ScriptMatchingWordSelectionBackground number | '53'
---@field public ScriptOperator number | '54'
---@field public ScriptNumber number | '55'
---@field public ScriptString number | '56'
---@field public ScriptComment number | '57'
---@field public ScriptKeyword number | '58'
---@field public ScriptBuiltInFunction number | '59'
---@field public ScriptWarning number | '60'
---@field public ScriptError number | '61'
---@field public ScriptWhitespace number | '62'
---@field public ScriptRuler number | '63'
---@field public DocViewCodeBackground number | '64'
---@field public DebuggerCurrentLine number | '65'
---@field public DebuggerErrorLine number | '66'
---@field public DiffFilePathText number | '67'
---@field public DiffTextHunkInfo number | '68'
---@field public DiffTextNoChange number | '69'
---@field public DiffTextAddition number | '70'
---@field public DiffTextDeletion number | '71'
---@field public DiffTextSeparatorBackground number | '72'
---@field public DiffTextNoChangeBackground number | '73'
---@field public DiffTextAdditionBackground number | '74'
---@field public DiffTextDeletionBackground number | '75'
---@field public DiffLineNum number | '76'
---@field public DiffLineNumSeparatorBackground number | '77'
---@field public DiffLineNumNoChangeBackground number | '78'
---@field public DiffLineNumAdditionBackground number | '79'
---@field public DiffLineNumDeletionBackground number | '80'
---@field public DiffFilePathBackground number | '81'
---@field public DiffFilePathBorder number | '82'
---@field public ChatIncomingBgColor number | '83'
---@field public ChatIncomingTextColor number | '84'
---@field public ChatOutgoingBgColor number | '85'
---@field public ChatOutgoingTextColor number | '86'
---@field public ChatModeratedMessageColor number | '87'
---@field public Separator number | '88'
---@field public ButtonBorder number | '89'
---@field public ButtonText number | '90'
---@field public InputFieldBorder number | '91'
---@field public CheckedFieldBackground number | '92'
---@field public CheckedFieldBorder number | '93'
---@field public CheckedFieldIndicator number | '94'
---@field public HeaderSection number | '95'
---@field public Midlight number | '96'
---@field public StatusBar number | '97'
---@field public DialogButton number | '98'
---@field public DialogButtonText number | '99'
---@field public DialogButtonBorder number | '100'
---@field public DialogMainButton number | '101'
---@field public DialogMainButtonText number | '102'
---@field public InfoBarWarningBackground number | '103'
---@field public InfoBarWarningText number | '104'
---@field public ScriptEditorCurrentLine number | '105'
---@field public ScriptMethod number | '106'
---@field public ScriptProperty number | '107'
---@field public ScriptNil number | '108'
---@field public ScriptBool number | '109'
---@field public ScriptFunction number | '110'
---@field public ScriptLocal number | '111'
---@field public ScriptSelf number | '112'
---@field public ScriptLuauKeyword number | '113'
---@field public ScriptFunctionName number | '114'
---@field public ScriptTodo number | '115'
---@field public ScriptBracket number | '116'
---@field public AttributeCog number | '117'
local StudioStyleGuideColor;
---The primary background color used by the ribbon bar and windows.
---
StudioStyleGuideColor.MainBackground = nil;
---The color of windows' title bars.
---
StudioStyleGuideColor.Titlebar = nil;
---The color of dropdown menus, like those found in the Properties window.
---
StudioStyleGuideColor.Dropdown = nil;
---The background color of tooltips, like those seen when hovering over
---buttons on the ribbon bar or properties in the Properties window.
---
StudioStyleGuideColor.Tooltip = nil;
---
StudioStyleGuideColor.Notification = nil;
---The color of scrollbar handles, like those seen in the Explorer window.
---
StudioStyleGuideColor.ScrollBar = nil;
---The background color of scrollbars, like those seen in the Explorer
---window.
---
StudioStyleGuideColor.ScrollBarBackground = nil;
---The background color of the tab bar, like the one where the script editor
---is opened.
---
StudioStyleGuideColor.TabBar = nil;
---The color of tabs on the tab bar, like the ones opened when the script
---editor is opened.
---
StudioStyleGuideColor.Tab = nil;
---
StudioStyleGuideColor.FilterButtonDefault = nil;
---
StudioStyleGuideColor.FilterButtonHover = nil;
---
StudioStyleGuideColor.FilterButtonChecked = nil;
---
StudioStyleGuideColor.FilterButtonAccent = nil;
---
StudioStyleGuideColor.FilterButtonBorder = nil;
---
StudioStyleGuideColor.FilterButtonBorderAlt = nil;
---The color of a tab on the ribbon menu (e.g. Home, Model, Test).
---
StudioStyleGuideColor.RibbonTab = nil;
---The background color of the ribbon menu.
---
StudioStyleGuideColor.RibbonTabTopBar = nil;
---The background color of clickable buttons.
---
StudioStyleGuideColor.Button = nil;
---The background color of clickable buttons that are the primary action.
---
StudioStyleGuideColor.MainButton = nil;
---The background color of buttons on the ribbon menu.
---
StudioStyleGuideColor.RibbonButton = nil;
---The background color of the game viewport.
---
StudioStyleGuideColor.ViewPortBackground = nil;
---The background color of input fields, like those found in the Explorer
---window.
---
StudioStyleGuideColor.InputFieldBackground = nil;
---
StudioStyleGuideColor.Item = nil;
---
StudioStyleGuideColor.TableItem = nil;
---
StudioStyleGuideColor.CategoryItem = nil;
---The color of items within tables in the game settings window.
---
StudioStyleGuideColor.GameSettingsTableItem = nil;
---The color of tooltips in the game settings window.
---
StudioStyleGuideColor.GameSettingsTooltip = nil;
---The color of the bar shown when the mobile emulator is active.
---
StudioStyleGuideColor.EmulatorBar = nil;
---The color of the device and physical size dropdowns in the emulator bar.
---
StudioStyleGuideColor.EmulatorDropDown = nil;
---The background color of the color picker.
---
StudioStyleGuideColor.ColorPickerFrame = nil;
---
StudioStyleGuideColor.CurrentMarker = nil;
---The color of borders, like those found in the Properties window.
---
StudioStyleGuideColor.Border = nil;
---
StudioStyleGuideColor.DropShadow = nil;
---The color of shadows rendered under floating items like dropdowns.
---
StudioStyleGuideColor.Shadow = nil;
---
StudioStyleGuideColor.Light = nil;
---
StudioStyleGuideColor.Dark = nil;
---
StudioStyleGuideColor.Mid = nil;
---
StudioStyleGuideColor.MainText = nil;
---
StudioStyleGuideColor.SubText = nil;
---
StudioStyleGuideColor.TitlebarText = nil;
---
StudioStyleGuideColor.BrightText = nil;
---
StudioStyleGuideColor.DimmedText = nil;
---
StudioStyleGuideColor.LinkText = nil;
---
StudioStyleGuideColor.WarningText = nil;
---
StudioStyleGuideColor.ErrorText = nil;
---
StudioStyleGuideColor.InfoText = nil;
---
StudioStyleGuideColor.SensitiveText = nil;
---
StudioStyleGuideColor.ScriptSideWidget = nil;
---
StudioStyleGuideColor.ScriptBackground = nil;
---
StudioStyleGuideColor.ScriptText = nil;
---
StudioStyleGuideColor.ScriptSelectionText = nil;
---
StudioStyleGuideColor.ScriptSelectionBackground = nil;
---
StudioStyleGuideColor.ScriptFindSelectionBackground = nil;
---
StudioStyleGuideColor.ScriptMatchingWordSelectionBackground = nil;
---
StudioStyleGuideColor.ScriptOperator = nil;
---
StudioStyleGuideColor.ScriptNumber = nil;
---
StudioStyleGuideColor.ScriptString = nil;
---
StudioStyleGuideColor.ScriptComment = nil;
---
StudioStyleGuideColor.ScriptKeyword = nil;
---
StudioStyleGuideColor.ScriptBuiltInFunction = nil;
---
StudioStyleGuideColor.ScriptWarning = nil;
---
StudioStyleGuideColor.ScriptError = nil;
---
StudioStyleGuideColor.ScriptWhitespace = nil;
---
StudioStyleGuideColor.ScriptRuler = nil;
---
StudioStyleGuideColor.DocViewCodeBackground = nil;
---
StudioStyleGuideColor.DebuggerCurrentLine = nil;
---
StudioStyleGuideColor.DebuggerErrorLine = nil;
---
StudioStyleGuideColor.DiffFilePathText = nil;
---
StudioStyleGuideColor.DiffTextHunkInfo = nil;
---
StudioStyleGuideColor.DiffTextNoChange = nil;
---
StudioStyleGuideColor.DiffTextAddition = nil;
---
StudioStyleGuideColor.DiffTextDeletion = nil;
---
StudioStyleGuideColor.DiffTextSeparatorBackground = nil;
---
StudioStyleGuideColor.DiffTextNoChangeBackground = nil;
---
StudioStyleGuideColor.DiffTextAdditionBackground = nil;
---
StudioStyleGuideColor.DiffTextDeletionBackground = nil;
---
StudioStyleGuideColor.DiffLineNum = nil;
---
StudioStyleGuideColor.DiffLineNumSeparatorBackground = nil;
---
StudioStyleGuideColor.DiffLineNumNoChangeBackground = nil;
---
StudioStyleGuideColor.DiffLineNumAdditionBackground = nil;
---
StudioStyleGuideColor.DiffLineNumDeletionBackground = nil;
---
StudioStyleGuideColor.DiffFilePathBackground = nil;
---
StudioStyleGuideColor.DiffFilePathBorder = nil;
---
StudioStyleGuideColor.ChatIncomingBgColor = nil;
---
StudioStyleGuideColor.ChatIncomingTextColor = nil;
---
StudioStyleGuideColor.ChatOutgoingBgColor = nil;
---
StudioStyleGuideColor.ChatOutgoingTextColor = nil;
---
StudioStyleGuideColor.ChatModeratedMessageColor = nil;
---
StudioStyleGuideColor.Separator = nil;
---
StudioStyleGuideColor.ButtonBorder = nil;
---
StudioStyleGuideColor.ButtonText = nil;
---
StudioStyleGuideColor.InputFieldBorder = nil;
---
StudioStyleGuideColor.CheckedFieldBackground = nil;
---
StudioStyleGuideColor.CheckedFieldBorder = nil;
---
StudioStyleGuideColor.CheckedFieldIndicator = nil;
---
StudioStyleGuideColor.HeaderSection = nil;
---
StudioStyleGuideColor.Midlight = nil;
---The color of the status bar shown at the bottom of Studio, if it is
---visible.
---
StudioStyleGuideColor.StatusBar = nil;
---
StudioStyleGuideColor.DialogButton = nil;
---
StudioStyleGuideColor.DialogButtonText = nil;
---
StudioStyleGuideColor.DialogButtonBorder = nil;
---
StudioStyleGuideColor.DialogMainButton = nil;
---
StudioStyleGuideColor.DialogMainButtonText = nil;
---
StudioStyleGuideColor.InfoBarWarningBackground = nil;
---
StudioStyleGuideColor.InfoBarWarningText = nil;
---
StudioStyleGuideColor.ScriptEditorCurrentLine = nil;
---
StudioStyleGuideColor.ScriptMethod = nil;
---
StudioStyleGuideColor.ScriptProperty = nil;
---
StudioStyleGuideColor.ScriptNil = nil;
---
StudioStyleGuideColor.ScriptBool = nil;
---
StudioStyleGuideColor.ScriptFunction = nil;
---
StudioStyleGuideColor.ScriptLocal = nil;
---
StudioStyleGuideColor.ScriptSelf = nil;
---
StudioStyleGuideColor.ScriptLuauKeyword = nil;
---
StudioStyleGuideColor.ScriptFunctionName = nil;
---
StudioStyleGuideColor.ScriptTodo = nil;
---
StudioStyleGuideColor.ScriptBracket = nil;
---
StudioStyleGuideColor.AttributeCog = nil;
Enum.StudioStyleGuideColor = StudioStyleGuideColor;
---@diagnostic disable-next-line
---@alias StudioStyleGuideColor Enum.StudioStyleGuideColor
---@class Enum.StudioStyleGuideModifier
---@field public Default number | '0'
---@field public Selected number | '1'
---@field public Pressed number | '2'
---@field public Disabled number | '3'
---@field public Hover number | '4'
local StudioStyleGuideModifier;
---
StudioStyleGuideModifier.Default = nil;
---
StudioStyleGuideModifier.Selected = nil;
---
StudioStyleGuideModifier.Pressed = nil;
---
StudioStyleGuideModifier.Disabled = nil;
---
StudioStyleGuideModifier.Hover = nil;
Enum.StudioStyleGuideModifier = StudioStyleGuideModifier;
---@diagnostic disable-next-line
---@alias StudioStyleGuideModifier Enum.StudioStyleGuideModifier
---@class Enum.Style
---@field public AlternatingSupports number | '0'
---@field public BridgeStyleSupports number | '1'
---@field public NoSupports number | '2'
---The Style Enum is used to set what style of supports the `TrussPart` has.
---
local Style;
---Truss beams contain alternating supports.
---
Style.AlternatingSupports = nil;
---Truss beams contain bridge style supports.
---
Style.BridgeStyleSupports = nil;
---Truss beams do not contain supports.
---
Style.NoSupports = nil;
Enum.Style = Style;
---@diagnostic disable-next-line
---@alias Style Enum.Style
---@class Enum.SurfaceConstraint
---@field public None number | '0'
---@field public Hinge number | '1'
---@field public SteppingMotor number | '2'
---@field public Motor number | '3'
---This item is deprecated and is replaced by the `Enum/SurfaceType` enum.
---
local SurfaceConstraint;
---No surface constraint.
---
SurfaceConstraint.None = nil;
---Makes the side appear with a yellow hinge. Any part connected to this
---hinge will stick to the side and rotate using physics.
---
SurfaceConstraint.Hinge = nil;
---Functions identically to a motor. It may have functioned differently in
---the past, but that functionality no longer seems to exist.
---
SurfaceConstraint.SteppingMotor = nil;
---Acts the same as a Hinge, but has a grey ring around it and automatically
---rotates any part connected to it.
---
SurfaceConstraint.Motor = nil;
Enum.SurfaceConstraint = SurfaceConstraint;
---@diagnostic disable-next-line
---@alias SurfaceConstraint Enum.SurfaceConstraint
---@class Enum.SurfaceGuiSizingMode
---@field public FixedSize number | '0'
---@field public PixelsPerStud number | '1'
---Used by `SurfaceGui/SizingMode` to control the sizing behavior of a
---`SurfaceGui`.
---
local SurfaceGuiSizingMode;
---Renders with a fixed size set using `SurfaceGui/CanvasSize`.
---
SurfaceGuiSizingMode.FixedSize = nil;
---Renders with a variable size based on `SurfaceGui/PixelsPerStud` and the
---SurfaceGui's size in studs.
---
SurfaceGuiSizingMode.PixelsPerStud = nil;
Enum.SurfaceGuiSizingMode = SurfaceGuiSizingMode;
---@diagnostic disable-next-line
---@alias SurfaceGuiSizingMode Enum.SurfaceGuiSizingMode
---@class Enum.SurfaceType
---@field public Smooth number | '0'
---@field public Glue number | '1'
---@field public Weld number | '2'
---@field public Studs number | '3'
---@field public Inlet number | '4'
---@field public Universal number | '5'
---@field public Hinge number | '6'
---@field public Motor number | '7'
---@field public SteppingMotor number | '8'
---@field public SmoothNoOutlines number | '10'
---Used to determine how a surface should be displayed on a part and how
---automatic surface joints should behave.
---
---## Surface behavior
---
---When surface joining is on, all planar touching flat sides of parts will weld
---together, regardless of SurfaceType. This does not affect Hinge, Motor,
---SteppingMotor.
---
---- Glue, Studs, Inlets, Universal, Weld, and Smooth surfaces will all create
---  Weld instances
---- Spheres will not surface-weld to anything. The rounded sides of cylinders
---  will not surface-weld, but the flat end sides will.
---
---## Surface appearance
---
---Stud, Inlet, Universal, Weld, and Glue Surface textures only appear on plastic
---material parts, both in-game and in Studio.
---
---See also:
---
---- `Workspace/JoinToOutsiders`, creates joints between the specified parts and
---  any touching parts depending on the parts' surfaces and the specified joint
---  creation mode
---- `Enum/JointCreationMode`, the way joints are created between two surfaces
---
local SurfaceType;
---Makes the side appear without any surface detail (except for _outlines_).
---
SurfaceType.Smooth = nil;
---Makes the side appear with thick diagonal "X"s.
---
SurfaceType.Glue = nil;
---Makes the side appear with thick diagonal "X"s.
---
SurfaceType.Weld = nil;
---Makes the side appear with square studs.
---
SurfaceType.Studs = nil;
---Makes the side appear with holes where studs would be.
---
SurfaceType.Inlet = nil;
---Makes the side appear with both Studs and Inlets in a checker pattern.
---
SurfaceType.Universal = nil;
---Makes the side appear with a yellow hinge. Any part connected to this
---hinge will stick to the side and rotate using physics, however, using
---`HingeConstraint` to join parts is preferred.
---
SurfaceType.Hinge = nil;
---Acts the same as a Hinge, but has a grey ring around it and automatically
---rotates any part connected to it, however, using `HingeConstraint` to join
---parts is preferred.
---
SurfaceType.Motor = nil;
---Functions identically to a motor. It may have functioned differently in
---the past, but that functionality no longer seems to exist.
---
SurfaceType.SteppingMotor = nil;
---Same as Smooth, but removes the _outlines_ of the surface.
---
SurfaceType.SmoothNoOutlines = nil;
Enum.SurfaceType = SurfaceType;
---@diagnostic disable-next-line
---@alias SurfaceType Enum.SurfaceType
---@class Enum.SwipeDirection
---@field public Right number | '0'
---@field public Left number | '1'
---@field public Up number | '2'
---@field public Down number | '3'
---@field public None number | '4'
---The SwipeDirection Enum represents the direction in which a user swipes on a
---`UserInputService/TouchEnabled` device.
---
---The `GuiObject/TouchSwipe|GuiObject.TouchSwipe` and
---`UserInputService/TouchSwipe|UserInputService.TouchSwipe` events pass this
---enum as an argument.
---
local SwipeDirection;
---The user swiped right.
---
SwipeDirection.Right = nil;
---The user swiped left.
---
SwipeDirection.Left = nil;
---The user swiped up.
---
SwipeDirection.Up = nil;
---The user swiped down.
---
SwipeDirection.Down = nil;
---The user did not swipe in a certain direction.
---
SwipeDirection.None = nil;
Enum.SwipeDirection = SwipeDirection;
---@diagnostic disable-next-line
---@alias SwipeDirection Enum.SwipeDirection
---@class Enum.TableMajorAxis
---@field public RowMajor number | '0'
---@field public ColumnMajor number | '1'
---Used to indicate whether the direct siblings of a `UITableLayout` are
---considered the rows or the columns. The children of the direct siblings are
---the columns or rows, respectively.
---
local TableMajorAxis;
---The direct siblings are considered rows.
---
TableMajorAxis.RowMajor = nil;
---The direct siblings are considered columns.
---
TableMajorAxis.ColumnMajor = nil;
Enum.TableMajorAxis = TableMajorAxis;
---@diagnostic disable-next-line
---@alias TableMajorAxis Enum.TableMajorAxis
---@class Enum.Technology
---@field public Legacy number | '0'
---@field public Voxel number | '1'
---@field public Compatibility number | '2'
---@field public ShadowMap number | '3'
---@field public Future number | '4'
---The Technology enum represents the different lighting systems available for
---rendering the 3D world. It is used by the `Lighting/Technology` property.
---
local Technology;
---Lighting technology that predates Future-Is-Bright. It is no longer
---available.
---
Technology.Legacy = nil;
---Future-Is-Bright lighting features. Shadows are created using a 4x4x4
---voxel map.
---
---![Voxel](assets/blt87d45df6d6aacbdc/Technology.Voxel.jpg)
---
Technology.Voxel = nil;
---An approximation of Legacy rendering using newer Future is Bright
---technology.
---[More details](https://devforum.roblox.com/t/deprecating-lighting-legacy-introducing-lighting-compatibility/232667).
---
---![Compatibility](assets/bltb74b240924f43951/Technology.Compatibility.jpg)
---
Technology.Compatibility = nil;
---Future-Is-Bright lighting features. Features crisp shadows.
---
---![ShadowMap](assets/blt5d79df0c0af20ab8/Technology.ShadowMap.jpg)
---
Technology.ShadowMap = nil;
---Latest Future-Is-Bright lighting features.
---
Technology.Future = nil;
Enum.Technology = Technology;
---@diagnostic disable-next-line
---@alias Technology Enum.Technology
---@class Enum.TeleportMethod
---@field public TeleportToSpawnByName number | '0'
---@field public TeleportToPlaceInstance number | '1'
---@field public TeleportToPrivateServer number | '2'
---@field public TeleportPartyAsync number | '3'
---@field public TeleportUnknown number | '4'
local TeleportMethod;
---
TeleportMethod.TeleportToSpawnByName = nil;
---
TeleportMethod.TeleportToPlaceInstance = nil;
---
TeleportMethod.TeleportToPrivateServer = nil;
---
TeleportMethod.TeleportPartyAsync = nil;
---
TeleportMethod.TeleportUnknown = nil;
Enum.TeleportMethod = TeleportMethod;
---@diagnostic disable-next-line
---@alias TeleportMethod Enum.TeleportMethod
---@class Enum.TeleportResult
---@field public Success number | '0'
---@field public Failure number | '1'
---@field public GameNotFound number | '2'
---@field public GameEnded number | '3'
---@field public GameFull number | '4'
---@field public Unauthorized number | '5'
---@field public Flooded number | '6'
---@field public IsTeleporting number | '7'
---Describes the result of a teleport.
---
local TeleportResult;
---The teleport was successful!.
---
TeleportResult.Success = nil;
---The teleport failed for an unknown reason!.
---
TeleportResult.Failure = nil;
---The game that this player attempted to teleport to could not be found.
---
TeleportResult.GameNotFound = nil;
---The game that this player attempted to teleport to has ended.
---
TeleportResult.GameEnded = nil;
---The game that this player attempted to teleport to is full.
---
TeleportResult.GameFull = nil;
---The player is not authorized to complete this teleport.
---
TeleportResult.Unauthorized = nil;
---Too many teleport requests have been made recently.
---
TeleportResult.Flooded = nil;
---The player is currently being teleported.
---
TeleportResult.IsTeleporting = nil;
Enum.TeleportResult = TeleportResult;
---@diagnostic disable-next-line
---@alias TeleportResult Enum.TeleportResult
---@class Enum.TeleportState
---@field public RequestedFromServer number | '0'
---@field public Started number | '1'
---@field public WaitingForServer number | '2'
---@field public Failed number | '3'
---@field public InProgress number | '4'
---Determines the current teleportation state of a player.
---
local TeleportState;
---The server has requested that the client teleport.
---
TeleportState.RequestedFromServer = nil;
---The client has started attempting to teleport.
---
TeleportState.Started = nil;
---The client is waiting for the server to respond to the teleport request.
---
TeleportState.WaitingForServer = nil;
---The teleport failed.
---
TeleportState.Failed = nil;
---The teleport is currently in progress. The player usually disconnects and
---teleports to the destination after this.
---
TeleportState.InProgress = nil;
Enum.TeleportState = TeleportState;
---@diagnostic disable-next-line
---@alias TeleportState Enum.TeleportState
---@class Enum.TeleportType
---@field public ToPlace number | '0'
---@field public ToInstance number | '1'
---@field public ToReservedServer number | '2'
---Determines the type of teleport destination for a `TeleportService` teleport
---call.
---
local TeleportType;
---The teleport destination is a place (no specific instance).
---
TeleportType.ToPlace = nil;
---The teleport destination is an instance of a place.
---
TeleportType.ToInstance = nil;
---The destination of the teleport is a reserved server (a place instance
---that is reserved for a select group of players).
---
TeleportType.ToReservedServer = nil;
Enum.TeleportType = TeleportType;
---@diagnostic disable-next-line
---@alias TeleportType Enum.TeleportType
---@class Enum.TerrainAcquisitionMethod
---@field public None number | '0'
---@field public Legacy number | '1'
---@field public Template number | '2'
---@field public Generate number | '3'
---@field public Import number | '4'
---@field public Convert number | '5'
---@field public EditAddTool number | '6'
---@field public EditSeaLevelTool number | '7'
---@field public EditReplaceTool number | '8'
---@field public RegionFillTool number | '9'
---@field public RegionPasteTool number | '10'
---@field public Other number | '11'
local TerrainAcquisitionMethod;
---
TerrainAcquisitionMethod.None = nil;
---
TerrainAcquisitionMethod.Legacy = nil;
---
TerrainAcquisitionMethod.Template = nil;
---
TerrainAcquisitionMethod.Generate = nil;
---
TerrainAcquisitionMethod.Import = nil;
---
TerrainAcquisitionMethod.Convert = nil;
---
TerrainAcquisitionMethod.EditAddTool = nil;
---
TerrainAcquisitionMethod.EditSeaLevelTool = nil;
---
TerrainAcquisitionMethod.EditReplaceTool = nil;
---
TerrainAcquisitionMethod.RegionFillTool = nil;
---
TerrainAcquisitionMethod.RegionPasteTool = nil;
---
TerrainAcquisitionMethod.Other = nil;
Enum.TerrainAcquisitionMethod = TerrainAcquisitionMethod;
---@diagnostic disable-next-line
---@alias TerrainAcquisitionMethod Enum.TerrainAcquisitionMethod
---@class Enum.TerrainFace
---@field public Top number | '0'
---@field public Side number | '1'
---@field public Bottom number | '2'
local TerrainFace;
---
TerrainFace.Top = nil;
---
TerrainFace.Side = nil;
---
TerrainFace.Bottom = nil;
Enum.TerrainFace = TerrainFace;
---@diagnostic disable-next-line
---@alias TerrainFace Enum.TerrainFace
---@class Enum.TextChatMessageStatus
---@field public Unknown number | '1'
---@field public Success number | '2'
---@field public Sending number | '3'
---@field public TextFilterFailed number | '4'
---@field public Floodchecked number | '5'
---@field public InvalidPrivacySettings number | '6'
---@field public InvalidTextChannelPermissions number | '7'
---@field public MessageTooLong number | '8'
---Indicates the status of a `TextChatMessage`.
---
local TextChatMessageStatus;
---Generic failed status for any other `TextChannel.SendAsync` failures.
---
TextChatMessageStatus.Unknown = nil;
---Message has no issues.
---
TextChatMessageStatus.Success = nil;
---Message is sending.
---
TextChatMessageStatus.Sending = nil;
---Text filter failed to process the message.
---
TextChatMessageStatus.TextFilterFailed = nil;
---Message is from a user sending messages too frequently.
---
TextChatMessageStatus.Floodchecked = nil;
---Message can't be sent because of user's
---[chat privacy settings](https://developer.roblox.com/en-us/articles/Chat-Privacy-Settings).
---
TextChatMessageStatus.InvalidPrivacySettings = nil;
---Message's `TextSource` is either not in the intended `TextChannel` or
---`TextSource.CanSend` is `false`.
---
TextChatMessageStatus.InvalidTextChannelPermissions = nil;
---Message is too long.
---
TextChatMessageStatus.MessageTooLong = nil;
Enum.TextChatMessageStatus = TextChatMessageStatus;
---@diagnostic disable-next-line
---@alias TextChatMessageStatus Enum.TextChatMessageStatus
---@class Enum.TextFilterContext
---@field public PublicChat number | '1'
---@field public PrivateChat number | '2'
local TextFilterContext;
---
TextFilterContext.PublicChat = nil;
---
TextFilterContext.PrivateChat = nil;
Enum.TextFilterContext = TextFilterContext;
---@diagnostic disable-next-line
---@alias TextFilterContext Enum.TextFilterContext
---@class Enum.TextInputType
---@field public Default number | '0'
---@field public NoSuggestions number | '1'
---@field public Number number | '2'
---@field public Email number | '3'
---@field public Phone number | '4'
---@field public Password number | '5'
---@field public PasswordShown number | '6'
---@field public Username number | '7'
---@field public OneTimePassword number | '8'
local TextInputType;
---
TextInputType.Default = nil;
---
TextInputType.NoSuggestions = nil;
---
TextInputType.Number = nil;
---
TextInputType.Email = nil;
---
TextInputType.Phone = nil;
---
TextInputType.Password = nil;
---
TextInputType.PasswordShown = nil;
---
TextInputType.Username = nil;
---
TextInputType.OneTimePassword = nil;
Enum.TextInputType = TextInputType;
---@diagnostic disable-next-line
---@alias TextInputType Enum.TextInputType
---@class Enum.TextTruncate
---@field public None number | '0'
---@field public AtEnd number | '1'
---Controls the truncation of text when using the TextTruncate property.
---
local TextTruncate;
---Text is not truncated.
---
TextTruncate.None = nil;
---Text is truncated at the end of the text, extra graphemes that cannot fit
---into the space are replaced with '...'.
---
TextTruncate.AtEnd = nil;
Enum.TextTruncate = TextTruncate;
---@diagnostic disable-next-line
---@alias TextTruncate Enum.TextTruncate
---@class Enum.TextXAlignment
---@field public Left number | '0'
---@field public Center number | '2'
---@field public Right number | '1'
---Determines horizontal alignment of text.
---
---Used by `TextLabel/TextXAlignment|TextLabel`,
---`TextButton/TextXAlignment|TextButton`, and `TextBox/TextXAlignment|TextBox`.
---
local TextXAlignment;
---Alignment starts at the left side of the GUI object.
---
TextXAlignment.Left = nil;
---Aligned starts at the center of the GUI object and spreads equally left
---and right.
---
TextXAlignment.Center = nil;
---Alignment starts at the right side of the GUI object.
---
TextXAlignment.Right = nil;
Enum.TextXAlignment = TextXAlignment;
---@diagnostic disable-next-line
---@alias TextXAlignment Enum.TextXAlignment
---@class Enum.TextYAlignment
---@field public Top number | '0'
---@field public Center number | '1'
---@field public Bottom number | '2'
---Determines vertical alignment of text.
---
---Used by `TextLabel/TextYAlignment|TextLabel`,
---`TextButton/TextYAlignment|TextButton`, and `TextBox/TextYAlignment|TextBox`.
---
local TextYAlignment;
---Alignment starts at the top of the GUI object.
---
TextYAlignment.Top = nil;
---Aligned starts at the center of the GUI object and spreads equally toward
---the top and bottom.
---
TextYAlignment.Center = nil;
---Alignment starts at the bottom of the GUI object.
---
TextYAlignment.Bottom = nil;
Enum.TextYAlignment = TextYAlignment;
---@diagnostic disable-next-line
---@alias TextYAlignment Enum.TextYAlignment
---@class Enum.TextureMode
---@field public Stretch number | '0'
---@field public Wrap number | '1'
---@field public Static number | '2'
---Describes how the texture of a `Trail` or `Beam` behaves.
---
local TextureMode;
---The texture will be stretched out based on the lifetime of the trail, and
---will shrink inwards if the trail stops moving.
---
TextureMode.Stretch = nil;
---The texture will be tiled as the length of the trail changes, but the
---textures will remain stationary relative to their attachments.
---
TextureMode.Wrap = nil;
---The texture will be rolled out as the attachments move, and they will
---remain in place until their lifetime is met.
---
TextureMode.Static = nil;
Enum.TextureMode = TextureMode;
---@diagnostic disable-next-line
---@alias TextureMode Enum.TextureMode
---@class Enum.TextureQueryType
---@field public NonHumanoid number | '0'
---@field public NonHumanoidOrphaned number | '1'
---@field public Humanoid number | '2'
---@field public HumanoidOrphaned number | '3'
---Used to get memory information about textures.
---
local TextureQueryType;
---Texture memory for objects other than `Humanoid`.
---
TextureQueryType.NonHumanoid = nil;
---Unreferenced texture memory for objects other than `Humanoid`.
---
TextureQueryType.NonHumanoidOrphaned = nil;
---Texture memory for `Humanoid`.
---
TextureQueryType.Humanoid = nil;
---Unreferenced texture memory for `Humanoid`.
---
TextureQueryType.HumanoidOrphaned = nil;
Enum.TextureQueryType = TextureQueryType;
---@diagnostic disable-next-line
---@alias TextureQueryType Enum.TextureQueryType
---@class Enum.ThreadPoolConfig
---@field public Auto number | '0'
---@field public PerCore1 number | '101'
---@field public PerCore2 number | '102'
---@field public PerCore3 number | '103'
---@field public PerCore4 number | '104'
---@field public Threads1 number | '1'
---@field public Threads2 number | '2'
---@field public Threads3 number | '3'
---@field public Threads4 number | '4'
---@field public Threads8 number | '8'
---@field public Threads16 number | '16'
---Controls the thread pooling scheme of the underlying 'TaskScheduler'.
---
---See TaskScheduler for details.
---
local ThreadPoolConfig;
---Let task scheduler make a decision internally.
---
ThreadPoolConfig.Auto = nil;
---Utilize 1 worker thread per available physical CPU core.
---
ThreadPoolConfig.PerCore1 = nil;
---Utilize 2 worker threads per available physical CPU core.
---
ThreadPoolConfig.PerCore2 = nil;
---Utilize 3 worker threads per available physical CPU core.
---
ThreadPoolConfig.PerCore3 = nil;
---Utilize 4 worker threads per available physical CPU core.
---
ThreadPoolConfig.PerCore4 = nil;
---Utilize 1 worker thread, ignore the physical CPU core count.
---
ThreadPoolConfig.Threads1 = nil;
---Utilize 2 worker threads, ignore the physical CPU core count.
---
ThreadPoolConfig.Threads2 = nil;
---Utilize 3 worker threads, ignore the physical CPU core count.
---
ThreadPoolConfig.Threads3 = nil;
---Utilize 4 worker threads, ignore the physical CPU core count.
---
ThreadPoolConfig.Threads4 = nil;
---Utilize 8 worker threads, ignore the physical CPU core count.
---
ThreadPoolConfig.Threads8 = nil;
---Utilize 16 worker threads, ignore the physical CPU core count.
---
ThreadPoolConfig.Threads16 = nil;
Enum.ThreadPoolConfig = ThreadPoolConfig;
---@diagnostic disable-next-line
---@alias ThreadPoolConfig Enum.ThreadPoolConfig
---@class Enum.ThrottlingPriority
---@field public Extreme number | '2'
---@field public ElevatedOnServer number | '1'
---@field public Default number | '0'
---Controls the amount of throttling under the `HttpRbxApiService`.
---
local ThrottlingPriority;
---No throttling, absolutely no exceptions.
---
ThrottlingPriority.Extreme = nil;
---Less throttling if on the server.
---
ThrottlingPriority.ElevatedOnServer = nil;
---Standard throttling.
---
ThrottlingPriority.Default = nil;
Enum.ThrottlingPriority = ThrottlingPriority;
---@diagnostic disable-next-line
---@alias ThrottlingPriority Enum.ThrottlingPriority
---@class Enum.ThumbnailSize
---@field public Size48x48 number | '0'
---@field public Size180x180 number | '1'
---@field public Size420x420 number | '2'
---@field public Size60x60 number | '3'
---@field public Size100x100 number | '4'
---@field public Size150x150 number | '5'
---@field public Size352x352 number | '6'
---Describes the resolution of a user thumbnail being returned by
---GetUserThumbnailAsync.
---
local ThumbnailSize;
---Thumbnail resolution is 48 pixels x 48 pixels.
---
ThumbnailSize.Size48x48 = nil;
---Thumbnail resolution is 180 pixels x 180 pixels.
---
ThumbnailSize.Size180x180 = nil;
---Thumbnail resolution is 420 pixels x 420 pixels.
---
ThumbnailSize.Size420x420 = nil;
---Thumbnail resolution is 60 pixels x 60 pixels.
---
ThumbnailSize.Size60x60 = nil;
---Thumbnail resolution is 100 pixels x 100 pixels.
---
ThumbnailSize.Size100x100 = nil;
---Thumbnail resolution is 150 pixels x 150 pixels.
---
ThumbnailSize.Size150x150 = nil;
---Thumbnail resolution is 352 pixels x 352 pixels.
---
ThumbnailSize.Size352x352 = nil;
Enum.ThumbnailSize = ThumbnailSize;
---@diagnostic disable-next-line
---@alias ThumbnailSize Enum.ThumbnailSize
---@class Enum.ThumbnailType
---@field public HeadShot number | '0'
---@field public AvatarBust number | '1'
---@field public AvatarThumbnail number | '2'
---Describes the type of user thumbnail that should be returned by
---GetUserThumbnailAsync.
---
local ThumbnailType;
---The returned thumbnail shows just the headshot (head and up) of the user's
---avatar.
---
ThumbnailType.HeadShot = nil;
---The returned thumbnail shows the bust (chest up) of the user's avatar.
---
ThumbnailType.AvatarBust = nil;
---The returned thumbnail shows the entire body of the user's avatar.
---
ThumbnailType.AvatarThumbnail = nil;
Enum.ThumbnailType = ThumbnailType;
---@diagnostic disable-next-line
---@alias ThumbnailType Enum.ThumbnailType
---@class Enum.TickCountSampleMethod
---@field public Fast number | '0'
---@field public Benchmark number | '1'
---@field public Precise number | '2'
---Compute time using a faster, but less precise method.
---
local TickCountSampleMethod;
---Compute time using a faster, but less precise method.
---
TickCountSampleMethod.Fast = nil;
---Dynamically decide between using ''Fast'' and ''Precise'' depending on
---performance.
---
TickCountSampleMethod.Benchmark = nil;
---Compute time using a precise method.
---
TickCountSampleMethod.Precise = nil;
Enum.TickCountSampleMethod = TickCountSampleMethod;
---@diagnostic disable-next-line
---@alias TickCountSampleMethod Enum.TickCountSampleMethod
---@class Enum.TopBottom
---@field public Top number | '0'
---@field public Center number | '1'
---@field public Bottom number | '2'
---Sets where the object is on the side of its parent.
---
local TopBottom;
---The object is above its parent.
---
TopBottom.Top = nil;
---The object is centered around the center of its parent.
---
TopBottom.Center = nil;
---The object is below its parent.
---
TopBottom.Bottom = nil;
Enum.TopBottom = TopBottom;
---@diagnostic disable-next-line
---@alias TopBottom Enum.TopBottom
---@class Enum.TouchCameraMovementMode
---@field public Default number | '0'
---@field public Follow number | '2'
---@field public Classic number | '1'
---@field public Orbital number | '3'
---Changes the touch camera movement mode currently in-use by the client using a
---TouchEnabled device.
---
local TouchCameraMovementMode;
---Default mode used by Roblox Core Scripts.
---
TouchCameraMovementMode.Default = nil;
---Camera moves with the subject and rotates to keep the subject in the
---center.
---
TouchCameraMovementMode.Follow = nil;
---Default mode used by Roblox Core Scripts.
---
TouchCameraMovementMode.Classic = nil;
---The camera locks at a certain angle. Once it's set, players can rotate the
---camera, but it will always maintain a consistent angle to the ground.
---
TouchCameraMovementMode.Orbital = nil;
Enum.TouchCameraMovementMode = TouchCameraMovementMode;
---@diagnostic disable-next-line
---@alias TouchCameraMovementMode Enum.TouchCameraMovementMode
---@class Enum.TouchMovementMode
---@field public Default number | '0'
---@field public Thumbstick number | '1'
---@field public DPad number | '2'
---@field public Thumbpad number | '3'
---@field public ClickToMove number | '4'
---@field public DynamicThumbstick number | '5'
---The TouchMovementMode Enum is used to change the movement controller on Roblox
---Mobile.
---
local TouchMovementMode;
---The default movement controller.
---
TouchMovementMode.Default = nil;
---Change the movement controller to the classic thumbstick.
---
TouchMovementMode.Thumbstick = nil;
---Change the movement controller to the DPad.
---
TouchMovementMode.DPad = nil;
---Change the movement controller to the thumbpad.
---
TouchMovementMode.Thumbpad = nil;
---Change the movement controller to click to move.
---
TouchMovementMode.ClickToMove = nil;
---Change the movement controller to the dynamic thumbstick.
---
TouchMovementMode.DynamicThumbstick = nil;
Enum.TouchMovementMode = TouchMovementMode;
---@diagnostic disable-next-line
---@alias TouchMovementMode Enum.TouchMovementMode
---@class Enum.TriStateBoolean
---@field public Unknown number | '0'
---@field public True number | '1'
---@field public False number | '2'
local TriStateBoolean;
---
TriStateBoolean.Unknown = nil;
---
TriStateBoolean.True = nil;
---
TriStateBoolean.False = nil;
Enum.TriStateBoolean = TriStateBoolean;
---@diagnostic disable-next-line
---@alias TriStateBoolean Enum.TriStateBoolean
---@class Enum.TweenStatus
---@field public Canceled number | '0'
---@field public Completed number | '1'
---Describes the completion status of a `GuiObject` tween function.
---
---Passed as an argument to the callback function provided to
---`GuiObject/TweenPosition`, `GuiObject/TweenSize`, and
---`GuiObject/TweenSizeAndPosition`.
---
---Not to be confused for `Enum/PlaybackState` which is used with `TweenService`.
---
local TweenStatus;
---The tween was cancelled before completion.
---
TweenStatus.Canceled = nil;
---The Tween has successfully completed.
---
TweenStatus.Completed = nil;
Enum.TweenStatus = TweenStatus;
---@diagnostic disable-next-line
---@alias TweenStatus Enum.TweenStatus
---@class Enum.UITheme
---@field public Light number | '0'
---@field public Dark number | '1'
local UITheme;
---
UITheme.Light = nil;
---
UITheme.Dark = nil;
Enum.UITheme = UITheme;
---@diagnostic disable-next-line
---@alias UITheme Enum.UITheme
---@class Enum.UiMessageType
---@field public UiMessageError number | '0'
---@field public UiMessageInfo number | '1'
---Controls the UI message under the `GuiService`.
---
local UiMessageType;
---The message error.
---
UiMessageType.UiMessageError = nil;
---The message info.
---
UiMessageType.UiMessageInfo = nil;
Enum.UiMessageType = UiMessageType;
---@diagnostic disable-next-line
---@alias UiMessageType Enum.UiMessageType
---@class Enum.UsageContext
---@field public Default number | '0'
---@field public Preview number | '1'
local UsageContext;
---
UsageContext.Default = nil;
---
UsageContext.Preview = nil;
Enum.UsageContext = UsageContext;
---@diagnostic disable-next-line
---@alias UsageContext Enum.UsageContext
---@class Enum.UserCFrame
---@field public Head number | '0'
---@field public LeftHand number | '1'
---@field public RightHand number | '2'
---Determines what body part is being tracked by a VR device, and what its CFrame
---actually is.
---
local UserCFrame;
---The CFrame of the user's head.
---
UserCFrame.Head = nil;
---The CFrame of the user's left hand.
---
UserCFrame.LeftHand = nil;
---The CFrame of the user's right hand.
---
UserCFrame.RightHand = nil;
Enum.UserCFrame = UserCFrame;
---@diagnostic disable-next-line
---@alias UserCFrame Enum.UserCFrame
---@class Enum.UserInputState
---@field public Begin number | '0'
---@field public Change number | '1'
---@field public End number | '2'
---@field public Cancel number | '3'
---@field public None number | '4'
---The **UserInputState** enum describes the state of an input that is currently
---or was recently performed. It is used by the `InputObject/UserInputState`
---property of the same name, as well as various `UserInputService` and
---`GuiObject` events.
---
---Depending on the `enum/UserInputType`, input may follow states differently.
---
---- Simple button and key presses generally follow a simple **Begin** &rarr;
---  **End** flow.
---  - Gamepad trigger buttons are similar to button presses, but will use
---    **Change** as the state of the button changes.
---- Mouse movement generally follows **Begin** (mouse-over) &rarr; **Change**
---  &rarr; **End** (mouse-leave).
---  - Touch input behaves somewhat similarly to mouse movement. **Begin** and
---    **End** occur when the user starts or ends touching the screen,
---    respectively. The same `InputObject` is used for the same touch point.
---- Gamepad thumbstick controls will cause **Change** to occur each frame the
---  position changes.
---
---## Cancel
---
---In the context of `ContextActionService`, binding action-handling functions
---using `ContextActionService/BindAction|BindAction` provides a UserInputState
---to the action handler when a relevant input is performed. If an in-progress
---input associated with a bound action is then
---`ContextActionService/UnbindAction|unbound` or becomes relevant to a different
---input, the **Cancel** UserInputState is passed, indicating that the input is
---no longer relevant to the action.
---
local UserInputState;
---Occurs when an `InputObject` starts to interact with the game. For
---example, a mouse button down, or a key down, or when a touch begins
---touching the screen.
---
UserInputState.Begin = nil;
---Occurs each frame an `InputObject` has already begun interacting with the
---game and part of its state is changing. For example, a movement of the
---mouse position, a gamepad thumbstick, gamepad trigger button, or screen
---touch point.
---
UserInputState.Change = nil;
---When an `InputObject` finishes interacting with the game. For example, a
---mouse button up, or a key up, or when a touch stops touching the screen.
---
UserInputState.End = nil;
---A special circumstance state that indicates this input is no longer
---relevant, particularly with `ContextActionService`. For example, binding
---two action-handling functions will cause the first to Cancel if an input
---was already in-progress when the second was bound.
---
UserInputState.Cancel = nil;
---A state that should never be seen in a game, essentially just marks the
---end of the enum.
---
UserInputState.None = nil;
Enum.UserInputState = UserInputState;
---@diagnostic disable-next-line
---@alias UserInputState Enum.UserInputState
---@class Enum.UserInputType
---@field public MouseButton1 number | '0'
---@field public MouseButton2 number | '1'
---@field public MouseButton3 number | '2'
---@field public MouseWheel number | '3'
---@field public MouseMovement number | '4'
---@field public Touch number | '7'
---@field public Keyboard number | '8'
---@field public Focus number | '9'
---@field public Accelerometer number | '10'
---@field public Gyro number | '11'
---@field public Gamepad1 number | '12'
---@field public Gamepad2 number | '13'
---@field public Gamepad3 number | '14'
---@field public Gamepad4 number | '15'
---@field public Gamepad5 number | '16'
---@field public Gamepad6 number | '17'
---@field public Gamepad7 number | '18'
---@field public Gamepad8 number | '19'
---@field public TextInput number | '20'
---@field public InputMethod number | '21'
---@field public None number | '22'
---The **UserInputType** enum describes the kind of input being performed (mouse,
---keyboard, gamepad, touch, etc). This enum is used by the
---`InputObject/UserInputType` property of the same name, as well as various
---`UserInputService` and `GuiObject` events.
---
local UserInputType;
---The left mouse button.
---
UserInputType.MouseButton1 = nil;
---The right mouse button.
---
UserInputType.MouseButton2 = nil;
---The middle mouse button.
---
UserInputType.MouseButton3 = nil;
---The mouse wheel.
---
UserInputType.MouseWheel = nil;
---Movement of the mouse. Fires changed events each time the player's cursor
---position changes and when the move enters/leaves the game window.
---
UserInputType.MouseMovement = nil;
---A tap on the screen from a mobile device.
---
UserInputType.Touch = nil;
---Key press on a keyboard.
---
UserInputType.Keyboard = nil;
---The client regaining focus of the Roblox window.
---
UserInputType.Focus = nil;
---The accelerometer of a mobile device.
---
UserInputType.Accelerometer = nil;
---The Gyroscope of a mobile device.
---
UserInputType.Gyro = nil;
---Input from the 1st plugged in Gamepad.
---
UserInputType.Gamepad1 = nil;
---Input from the 2nd plugged in Gamepad.
---
UserInputType.Gamepad2 = nil;
---Input from the 3rd plugged in Gamepad.
---
UserInputType.Gamepad3 = nil;
---Input from the 4th plugged in Gamepad.
---
UserInputType.Gamepad4 = nil;
---Input from the 5th plugged in Gamepad.
---
UserInputType.Gamepad5 = nil;
---Input from the 6th plugged in Gamepad.
---
UserInputType.Gamepad6 = nil;
---Input from the 7th plugged in Gamepad.
---
UserInputType.Gamepad7 = nil;
---Input from the 8th plugged in Gamepad.
---
UserInputType.Gamepad8 = nil;
---Input of Text into a text-based `GuiObject`. Normally this is only a
---`TextBox`.
---
UserInputType.TextInput = nil;
---Text input from an input method editor (IME). `InputObject`s with this
---type aren't currently fired.
---
UserInputType.InputMethod = nil;
---Unknown UserInputType.
---
UserInputType.None = nil;
Enum.UserInputType = UserInputType;
---@diagnostic disable-next-line
---@alias UserInputType Enum.UserInputType
---@class Enum.VRTouchpad
---@field public Left number | '0'
---@field public Right number | '1'
---Used to universally identify a VR touchpad that is used by either the left, or
---right hand.
---
local VRTouchpad;
---Left hand touchpad.
---
VRTouchpad.Left = nil;
---Right hand touchpad.
---
VRTouchpad.Right = nil;
Enum.VRTouchpad = VRTouchpad;
---@diagnostic disable-next-line
---@alias VRTouchpad Enum.VRTouchpad
---@class Enum.VRTouchpadMode
---@field public Touch number | '0'
---@field public VirtualThumbstick number | '1'
---@field public ABXY number | '2'
---Used to identify the behavior of a specified VR touchpad.
---
local VRTouchpadMode;
---The touchpad is treated as ButtonB if it is the left touchpad, or ButtonA
---if it is the right touchpad.
---
VRTouchpadMode.Touch = nil;
---The touchpad will function as a gamepad joystick.
---
VRTouchpadMode.VirtualThumbstick = nil;
---The touchpad will function as a means of inputting the standard ABXY
---gamepad input, dividing it up into 4 diagonal pie slices.
---
VRTouchpadMode.ABXY = nil;
Enum.VRTouchpadMode = VRTouchpadMode;
---@diagnostic disable-next-line
---@alias VRTouchpadMode Enum.VRTouchpadMode
---@class Enum.VelocityConstraintMode
---@field public Line number | '0'
---@field public Plane number | '1'
---@field public Vector number | '2'
---The velocity constraint mode sets how the attachment velocity is constrained.
---The velocity can be constrained to a line, a plane or a vector. See each mode
---for more details.
---
local VelocityConstraintMode;
---The velocity component in the direction of the line is constrained to the
---specified value. The line direction is based on the RelativeTo property:
---
---- RelativeTo_Attachment0: The line direction is the primary axis of
---  attachment0.
---- RelativeTo_Attachment1: The line direction is the primary axis of
---  attachment1.
---- RelativeTo_World: The line direction must be specified.
---
VelocityConstraintMode.Line = nil;
---The velocity components in the plane are constrained to the specified
---values. The plane tangents are based on the RelativeTo property:
---
---- RelativeTo_Attachment0: The plane tangents are the two axes of
---  attachment0.
---- RelativeTo_Attachment1: The plane tangents are the two axes of
---  attachment1.
---- RelativeTo_World: The two plane tangents must be specified
---
VelocityConstraintMode.Plane = nil;
---The velocity components must be equal to the vector components specified.
---The coordinate system of the vector is based on the RelativeTo property:
---
---- RelativeTo_Attachment0: The vector components are in the coordinate
---  system defined by the axes of attachment0.
---- RelativeTo_Attachment1: The vector components are in the coordinate
---  system defined by the axes of attachment1.
---- RelativeTo_World: The coordinate system is in the world and the vector
---  components must be specified.
---
VelocityConstraintMode.Vector = nil;
Enum.VelocityConstraintMode = VelocityConstraintMode;
---@diagnostic disable-next-line
---@alias VelocityConstraintMode Enum.VelocityConstraintMode
---@class Enum.VerticalAlignment
---@field public Center number | '0'
---@field public Top number | '1'
---@field public Bottom number | '2'
---Determines how grid is placed within it's parent's container in the y
---direction.
---
local VerticalAlignment;
---Center of the grid.
---
VerticalAlignment.Center = nil;
---Top of the grid.
---
VerticalAlignment.Top = nil;
---Bottom of the grid.
---
VerticalAlignment.Bottom = nil;
Enum.VerticalAlignment = VerticalAlignment;
---@diagnostic disable-next-line
---@alias VerticalAlignment Enum.VerticalAlignment
---@class Enum.VerticalScrollBarPosition
---@field public Left number | '1'
---@field public Right number | '0'
---Indicates the side that the vertical scrollbar will be located at.
---
local VerticalScrollBarPosition;
---Left side of the `ScrollingFrame`.
---
VerticalScrollBarPosition.Left = nil;
---Right side of the `ScrollingFrame`.
---
VerticalScrollBarPosition.Right = nil;
Enum.VerticalScrollBarPosition = VerticalScrollBarPosition;
---@diagnostic disable-next-line
---@alias VerticalScrollBarPosition Enum.VerticalScrollBarPosition
---@class Enum.VibrationMotor
---@field public Large number | '0'
---@field public Small number | '1'
---@field public LeftTrigger number | '2'
---@field public RightTrigger number | '3'
---@field public LeftHand number | '4'
---@field public RightHand number | '5'
---Describes various types of motor size (Small and Large), with various triggers
---(LeftTrigger, RightTrigger, LeftHand, RightHand).
---
local VibrationMotor;
---Large motor.
---
VibrationMotor.Large = nil;
---Small motor.
---
VibrationMotor.Small = nil;
---Left motor trigger.
---
VibrationMotor.LeftTrigger = nil;
---Right motor trigger.
---
VibrationMotor.RightTrigger = nil;
---Left hand.
---
VibrationMotor.LeftHand = nil;
---Right hand.
---
VibrationMotor.RightHand = nil;
Enum.VibrationMotor = VibrationMotor;
---@diagnostic disable-next-line
---@alias VibrationMotor Enum.VibrationMotor
---@class Enum.VirtualCursorMode
---@field public Default number | '0'
---@field public Disabled number | '1'
---@field public Enabled number | '2'
---Enables Virtual Cursor mode within an experience. By default, this property is
---disabled.
---
local VirtualCursorMode;
---The Virtual Cursor is in the default state.
---
VirtualCursorMode.Default = nil;
---The Virtual Cursor is disabled.
---
VirtualCursorMode.Disabled = nil;
---The Virtual Cursor is enabled.
---
VirtualCursorMode.Enabled = nil;
Enum.VirtualCursorMode = VirtualCursorMode;
---@diagnostic disable-next-line
---@alias VirtualCursorMode Enum.VirtualCursorMode
---@class Enum.VirtualInputMode
---@field public Recording number | '1'
---@field public Playing number | '2'
---@field public None number | '0'
local VirtualInputMode;
---
VirtualInputMode.Recording = nil;
---
VirtualInputMode.Playing = nil;
---
VirtualInputMode.None = nil;
Enum.VirtualInputMode = VirtualInputMode;
---@diagnostic disable-next-line
---@alias VirtualInputMode Enum.VirtualInputMode
---@class Enum.VoiceChatState
---@field public Idle number | '0'
---@field public Joining number | '1'
---@field public JoiningRetry number | '2'
---@field public Joined number | '3'
---@field public Leaving number | '4'
---@field public Ended number | '5'
---@field public Failed number | '6'
local VoiceChatState;
---
VoiceChatState.Idle = nil;
---
VoiceChatState.Joining = nil;
---
VoiceChatState.JoiningRetry = nil;
---
VoiceChatState.Joined = nil;
---
VoiceChatState.Leaving = nil;
---
VoiceChatState.Ended = nil;
---
VoiceChatState.Failed = nil;
Enum.VoiceChatState = VoiceChatState;
---@diagnostic disable-next-line
---@alias VoiceChatState Enum.VoiceChatState
---@class Enum.WaterDirection
---@field public NegX number | '0'
---@field public X number | '1'
---@field public NegY number | '2'
---@field public Y number | '3'
---@field public NegZ number | '4'
---@field public Z number | '5'
---This Enum was once used to set the direction of `Terrain` water.
---
local WaterDirection;
---
WaterDirection.NegX = nil;
---
WaterDirection.X = nil;
---
WaterDirection.NegY = nil;
---
WaterDirection.Y = nil;
---
WaterDirection.NegZ = nil;
---
WaterDirection.Z = nil;
Enum.WaterDirection = WaterDirection;
---@diagnostic disable-next-line
---@alias WaterDirection Enum.WaterDirection
---@class Enum.WaterForce
---@field public None number | '0'
---@field public Small number | '1'
---@field public Medium number | '2'
---@field public Strong number | '3'
---@field public Max number | '4'
---The WaterForce Enum is used to work with `Terrain` water cells.
---
local WaterForce;
---
WaterForce.None = nil;
---
WaterForce.Small = nil;
---
WaterForce.Medium = nil;
---
WaterForce.Strong = nil;
---
WaterForce.Max = nil;
Enum.WaterForce = WaterForce;
---@diagnostic disable-next-line
---@alias WaterForce Enum.WaterForce
---@class Enum.WrapLayerDebugMode
---@field public None number | '0'
---@field public BoundCage number | '1'
---@field public LayerCage number | '2'
---@field public BoundCageAndLinks number | '3'
---@field public Reference number | '4'
---@field public Rbf number | '5'
---@field public OuterCage number | '6'
---@field public ReferenceMeshAfterMorph number | '7'
---@field public HSROuterDetail number | '8'
---@field public HSROuter number | '9'
---@field public HSRInner number | '10'
---@field public HSRInnerReverse number | '11'
---The "Editor only" property for visualizing Wrap Deformer internals and
---debugging cage mesh-related issues.
---
---This debug visualization only works when Wrap Deformer is active and does not
---work if Wrap Deformer is not active or incorrectly configured.
---
local WrapLayerDebugMode;
---This debug rendering mode does nothing. This is the default value.
---
WrapLayerDebugMode.None = nil;
---This debug mode visualizes corresponding cage mesh vertices bound to an
---underlying `WrapTarget`. In order to find corresponding vertices between
---different cages, the Wrap Deformer algorithm uses UV matching. As long as
---your `WrapLayer` cage mesh share the same UV layout as `WrapTarget`, its
---vertices will be marked as "bound".
---
WrapLayerDebugMode.BoundCage = nil;
---This debug mode shows the resulting layer mesh as a whole. The deformer
---will use vertex locations from the previous layer for all unbound
---vertices.
---
WrapLayerDebugMode.LayerCage = nil;
---The same as BoundCage but also visualizes how bound vertices were moved.
---You can use this mode to identify where they belong on a previous layer
---and where they are located on the current layer.
---
WrapLayerDebugMode.BoundCageAndLinks = nil;
---This debug mode shows the original inner cage mesh as it was created.
---
WrapLayerDebugMode.Reference = nil;
---This debug mode visualizes the internal RBF solver state. You can estimate
---the wrap deformer's expected behavior by looking at this state. All
---renderable mesh vertices move from a "big sphere" to a "small sphere"
---along a corresponding line connecting two spheres.
---
WrapLayerDebugMode.Rbf = nil;
---This debug mode shows the original outer cage mesh as it was created.
---
WrapLayerDebugMode.OuterCage = nil;
---
WrapLayerDebugMode.ReferenceMeshAfterMorph = nil;
---
WrapLayerDebugMode.HSROuterDetail = nil;
---
WrapLayerDebugMode.HSROuter = nil;
---
WrapLayerDebugMode.HSRInner = nil;
---
WrapLayerDebugMode.HSRInnerReverse = nil;
Enum.WrapLayerDebugMode = WrapLayerDebugMode;
---@diagnostic disable-next-line
---@alias WrapLayerDebugMode Enum.WrapLayerDebugMode
---@class Enum.WrapTargetDebugMode
---@field public None number | '0'
---@field public TargetCageOriginal number | '1'
---@field public TargetCageCompressed number | '2'
---@field public TargetCageInterface number | '3'
---@field public TargetLayerCageOriginal number | '4'
---@field public TargetLayerCageCompressed number | '5'
---@field public TargetLayerInterface number | '6'
---@field public Rbf number | '7'
---@field public OuterCageDetail number | '8'
---The "Editor only" property for visualizing Wrap Deformer internals and
---debugging cage mesh-related issues.
---
---This debug visualization only works when Wrap Deformer is active and does not
---work if Wrap Deformer is not active or incorrectly configured.
---
local WrapTargetDebugMode;
---This debug rendering mode does nothing, and this is the default value.
---
WrapTargetDebugMode.None = nil;
---This debug mode shows the original cage mesh as it was created.
---
WrapTargetDebugMode.TargetCageOriginal = nil;
---This debug mode shows corresponding cage mesh compressed by clothing
---layers above it. This debug mode is intended to validate that the
---compression algorithm and corresponding cages work as intended.
---
WrapTargetDebugMode.TargetCageCompressed = nil;
---This debug mode shows the resulting cage mesh for the corresponding Wrap
---Instance. This debug mode is intended to validate that the final deformed
---cage looks as intended.
---
WrapTargetDebugMode.TargetCageInterface = nil;
---The same as TargetCageOriginal but affects all WrapTargets that belong to
---the Wrap Deformer simultaneously. It doesn't matter which particular
---WrapTarget you enable this debug visualization option.
---
WrapTargetDebugMode.TargetLayerCageOriginal = nil;
---The same as TargetCageCompressed but affects all WrapTargets that belong
---to the Wrap Deformer simultaneously. It doesn't matter which particular
---WrapTarget you enable this debug visualization option.
---
WrapTargetDebugMode.TargetLayerCageCompressed = nil;
---The same as TargetCageInterface but affects all WrapTargets that belong to
---the Wrap Deformer simultaneously. It doesn't matter which particular
---WrapTarget you enable this debug visualization option.
---
WrapTargetDebugMode.TargetLayerInterface = nil;
---This debug mode visualizes the internal RBF solver state. You can estimate
---the wrap deformer expected behavior by looking at this state. All
---renderable mesh vertices move from a "big sphere" to a "small sphere"
---along a corresponding line connecting two spheres.
---
WrapTargetDebugMode.Rbf = nil;
---
WrapTargetDebugMode.OuterCageDetail = nil;
Enum.WrapTargetDebugMode = WrapTargetDebugMode;
---@diagnostic disable-next-line
---@alias WrapTargetDebugMode Enum.WrapTargetDebugMode
---@class Enum.ZIndexBehavior
---@field public Global number | '0'
---@field public Sibling number | '1'
---Used by `LayerCollector/ZIndexBehavior` to control how the `GuiObject/ZIndex`
---property behaves for descendants.
---
local ZIndexBehavior;
---The ZIndex property overrides the default value computed from the depth in
---the hierarchy.
---
ZIndexBehavior.Global = nil;
---The ZIndex property controls the order in which the GuiObject renders
---relative to its siblings.
---
ZIndexBehavior.Sibling = nil;
Enum.ZIndexBehavior = ZIndexBehavior;
---@diagnostic disable-next-line
---@alias ZIndexBehavior Enum.ZIndexBehavior
---@diagnostic disable
---@return PluginManager
---Returns the `PluginManager` which is a deprecated singleton that was
---previously required to create plugins. It still has applicable uses, such
---as if you need to create a Plugin object from Roblox Studio's command bar.
---
PluginManager = function() end;
---@return number
---Returns the amount of time, in seconds, that has elapsed since the current
---game instance started running. If the current game instance is not
---running, this will be `0`.
---
time = function() end;
---@return UserSettings
---Returns the `UserSettings` object, which is used to read information from
---the current user's game menu settings.
---
UserSettings = function() end;
---@param delayTime number
---@param callback function
---@return void
---Schedules a function to be executed after `delayTime` seconds have passed,
---without yielding the current thread. This function allows multiple Lua
---threads to be executed in parallel from the same stack. The delay will
---have a minimum duration of 29 milliseconds, but this minimum may be higher
---depending on the target framerate and various throttling conditions. If
---the `delayTime` parameter is not specified, the minimum duration will be
---used.
---
delay = function(delayTime, callback) end;
---@param object Variant
---@return string
---Returns the type of the object specified, as a string. This function is
---more accurate than Lua's native `type` function, as it does not denote
---Roblox-specific types as `userdata`.
---
typeof = function(object) end;
---@param seconds number
---@return number, number
---Yields the current thread until the specified amount of seconds have
---elapsed.
---
---The delay will have a minimum duration of 29 milliseconds, but this
---minimum may be higher depending on the target framerate and various
---throttling conditions. If the `seconds` parameter is not specified, the
---minimum duration will be used. This function returns:
---
---- Actual time yielded (in seconds).
---- Total time since the software was initialized (in seconds).
---
wait = function(seconds) end;
---@return Stats
---Returns the `Stats` service. It is preferred that developers use
---`ServiceProvider/GetService` to retrieve it instead.
---
stats = function() end;
---@return number
---Returns how much time has elapsed since the current instance of Roblox was
---started. In Roblox Studio, this begins counting up from the moment Roblox
---Studio starts running, not just when opening a place.
---
elapsedTime = function() end;
---@return number
---Returns how much time has elapsed, in seconds, since the UNIX epoch, on
---the current local session's computer. The UNIX epoch is represented by the
---date January 1st, 1970.
---
tick = function() end;
---@param libraryName string
---@return RbxLibrary
---LoadLibrary cannot be used anymore and will raise an error when called.
---However, it is still possible to load the modules that this function once
---did. Please see
---[this announcement post](https://devforum.roblox.com/t/loadlibrary-is-going-to-be-removed-on-february-3rd/382516)
---about its removal for more information. You can download
---[this Roblox Model file](https://devforum.roblox.com/uploads/short-url/bSMD1kiXg4uFGtNPDnTo2PpHu1A.rbxmx)
---which contains ModuleScripts that provide equivalent libraries.
---
---Returns a built-in Roblox library, based on the libraryName specified.
---There are currently 3 available libraries:
---
---- RbxGui
---- RbxUtility
---- RbxStamper
---
LoadLibrary = function(libraryName) end;
---@param params Tuple
---@return void
---Behaves identically to Lua's print function, except the output is styled
---as a warning, with yellow text and a timestamp. This function accepts any
---number of arguments, and will attempt to convert them into strings which
---will then be joined together with spaces between them.
---
warn = function(params) end;
---@return GlobalSettings
---Returns the `GlobalSettings` object, which can be used to access the
---settings objects that are used in Roblox Studio's settings menu.
---
settings = function() end;
---@return string
---Returns the current version of Roblox as a string. The integers in the
---version string are separated by periods, and each integers represent the
---following, in order:
---
---- Generation - The current generation of the application shell that is
---  hosting the client.
---- Version - The current release version of Roblox.
---- Patch - The current patch number for this version of Roblox.
---- Commit - The ID of the last internal commit that was accepted into this
---  version of the client.
---
version = function() end;
---@param callback function
---@return void
---Runs the specified callback function in a separate thread, without
---yielding the current thread.
---
---The function will be executed the next time Roblox's Task Scheduler runs
---an update cycle. This delay will take at least 29 milliseconds but can
---arbitrarily take longer, depending on the target framerate and various
---throttling conditions.
---
---The callback function is invoked with two arguments:
---
---1. The first being the amount of time which elapsed from when spawn was
---   called to when the function was invoked.
---2. The second being equivalent to elapsedTime() or roughly how long the
---   engine has been running.
---
---```lua
---spawn(print) -- 0.0079617658390703 451.55683163643
---```
---
spawn = function(callback) end;
---@return DebuggerManager
---Returns the `DebuggerManager` class, which acts as an interface for
---Roblox's Lua debugger feature.
---
DebuggerManager = function() end;
---@param prefix string
---@return void
---Prints `Current identity is [ID]` to the output, where [ID] corresponds to
---the current thread's security context level.
---
printidentity = function(prefix) end;
---@param module ModuleScript
---@return Variant
---Runs the supplied `ModuleScript` if it has not been run already, and
---returns what the ModuleScript returned (in both cases).
---
---If the ModuleScript the user wants to use has been uploaded to Roblox
---(with the instance's name being 'MainModule'), it can be loaded by using
---the require function on the asset ID of the ModuleScript, though only on
---the server.
---
require = function(module) end;
---@type Enums
Enum = nil;
---@type DataModel
game = nil;
---@type Plugin
plugin = nil;
---@type Array
shared = nil;
---@type LuaSourceContainer
script = nil;
---@type Workspace
workspace = nil;
---@diagnostic enable
---@class bit32
---This library is a back-ported feature from
---[Lua 5.2](https://www.lua.org/manual/5.2/manual.html#6.7) that provides
---functions to perform bitwise operations.
---
bit32 = nil;
---@param x number
---@param disp number
---@return number
---Returns the number `x` rotated `disp` bits to the left. The number `disp`
---may be any representable integer. For any valid displacement, the
---following identity holds:
---
---```lua
---assert(bit32.lrotate(x, disp) == bit32.lrotate(x, disp % 32))
---```
---
---In particular, negative displacements rotate to the right.
---
bit32.lrotate = function(x, disp) end;
---@param x number
---@param disp number
---@return number
---Returns the number `x` shifted `disp` bits to the left. The number `disp`
---may be any representable integer. Negative displacements shift to the
---right. In any direction, vacant bits are filled with zeros. In particular,
---displacements with absolute values higher than 31 result in zero (all bits
---are shifted out).
---
---For positive displacements, the following equality holds:
---
---```lua
---assert(bit32.lshift(b, disp) == (b * 2^disp) % 2^32)
---```
---
bit32.lshift = function(x, disp) end;
---@param x number
---@return number
---Returns the bitwise negation of `x`. For any integer `x`, the following
---identity holds:
---
---```lua
---assert(bit32.bnot(x) == (-1 - x) % 2^32)
---```
---
bit32.bnot = function(x) end;
---@param x number
---@param disp number
---@return number
---Returns the number `x` rotated `disp` bits to the right. The number `disp`
---may be any representable integer.
---
---For any valid displacement, the following identity holds:
---
---```lua
---assert(bit32.rrotate(x, disp) == bit32.rrotate(x , disp % 32))
---```
---
---In particular, negative displacements rotate to the left.
---
bit32.rrotate = function(x, disp) end;
---@param x number
---@param disp number
---@return number
---Returns the number `x` shifted `disp` bits to the right. The number `disp`
---may be any representable integer. Negative displacements shift to the
---left.
---
---This shift operation is what is called arithmetic shift. Vacant bits on
---the left are filled with copies of the higher bit of `x`; vacant bits on
---the right are filled with zeros. In particular, displacements with
---absolute values higher than 31 result in zero or 0xFFFFFFFF (all original
---bits are shifted out).
---
bit32.arshift = function(x, disp) end;
---@param x number
---@param disp number
---@return number
---Returns the number `x` shifted `disp` bits to the right. The number `disp`
---may be any representable integer. Negative displacements shift to the
---left. In any direction, vacant bits are filled with zeros. In particular,
---displacements with absolute values higher than 31 result in zero (all bits
---are shifted out).
---
---For positive displacements, the following equality holds:
---
---```lua
---assert(bit32.rshift(b, disp) == math.floor(b % 2^32 / 2^disp))
---```
---
---This shift operation is what is called logical shift.
---
bit32.rshift = function(x, disp) end;
---@param n number
---@param v number
---@param field number
---@param width number
---@return number
---Returns a copy of `n` with the bits `field` to `field + width - 1`
---replaced by the value `v`. See `bit32.extract` for details about `field`
---and `width`.
---
bit32.replace = function(n, v, field, width) end;
---@param numbers Tuple
---@return number
---Returns the bitwise _or_ of its operands.
---
bit32.bor = function(numbers) end;
---@param numbers Tuple
---@return number
---Returns the bitwise _and_ of its operands.
---
bit32.band = function(numbers) end;
---@param numbers Tuple
---@return number
---Returns the bitwise _exclusive or_ of its operands.
---
bit32.bxor = function(numbers) end;
---@param numbers Tuple
---@return boolean
---Returns a boolean signalling whether the bitwise _and_ of its operands is
---different from zero.
---
bit32.btest = function(numbers) end;
---@param n number
---@param field number
---@param width number
---@return number
---Returns the unsigned number formed by the bits `field` to
---`field + width - 1` from `n`. Bits are numbered from 0 (least significant)
---to 31 (most significant). All accessed bits must be in the range [0, 31].
---The default for `width` is 1.
---
bit32.extract = function(n, field, width) end;
---@class coroutine
---A **coroutine** is used to perform multiple tasks at the same time from within
---the same script. Such tasks might include producing values from inputs or
---performing work on a subroutine when solving a larger problem. A task doesn't
---even need to have a defined ending point, but it does need to define
---particular times at which it **yields** (pause) to let other things be worked
---on.
---
---## Using Coroutines
---
---A new coroutine can be created by providing a function to
---`coroutine.create()`. Once created, a coroutine doesn't begin running until
---the first call to `coroutine.resume()` which passes the arguments to the
---function. This call returns when the function either halts or calls
---`coroutine.yield()` and, when this happens, `coroutine.resume()` returns
---either the values returned by the function, the values sent to
---`coroutine.yield()`, or an error message. If it does error, the second return
---value is the thrown error.
---
---```lua
---local function task(...)
---	-- This function might do some work for a bit then yield some value
---	coroutine.yield("first")  -- To be returned by coroutine.resume()
---	-- The function continues once it is resumed again
---	return "second"
---end
---
---local taskCoro = coroutine.create(task)
----- Call resume for the first time, which runs the function from the beginning
---local success, result = coroutine.resume(taskCoro, ...)
---print(success, result)  --> true, first (task called coroutine.yield())
----- Continue running the function until it yields or halts
---success, result = coroutine.resume(taskCoro)
---print(success, result)  --> true, second (task halted because it returned "second")
---```
---
---During the lifetime of the coroutine, you can call `coroutine.status()` to
---inspect its status:
---
---<table>
---    <thead>
---        <tr>
---            <th>Status</th>
---            <th>Meaning</th>
---        </tr>
---    </thead>
---    <tbody>
---        <tr>
---            <td><b>suspended</b></td> <td>The coroutine is waiting to be
---            resumed. Coroutines begin in this state and enter it when their
---            function calls <code>coroutine.yield()</code>.</td>
---        </tr>
---        <tr>
---            <td><b>running</b></td>
---            <td>The coroutine is running right now.</td>
---        </tr>
---        <tr>
---            <td><b>normal</b></td> <td>The coroutine is awaiting the yield of
---            another coroutine; in other words, it has resumed another
---            coroutine.</td>
---        </tr>
---        <tr>
---            <td><b>dead</b></td> <td>The function has halted (returned or
---            thrown an&nbsp;error). The coroutine cannot be used further.</td>
---        </tr>
---    </tbody>
---</table>
---
---### Wrapping Coroutines
---
---When working with coroutines, you can also forgo the use of the coroutine
---object and instead use a wrapper function. Such a wrapper function will resume
---a particular coroutine when it is called and will return only the yielded
---values. You can do this using `coroutine.wrap()`:
---
---```lua
----- Create coroutine and return a wrapper function that resumes it
---local f = coroutine.wrap(task)
----- Resume the coroutine as if we called coroutine.resume()
---local result = f()
----- If an error occurs it will be raised here!
----- This differs from coroutine.resume() which acts similar to pcall()
---```
---
---The first value returned from `coroutine.resume()` describes whether a
---coroutine ran without errors. However, functions returned by
---`coroutine.wrap()` will not do this: instead they directly return the values
---returned or passed to `coroutine.yield()`, if any. Should an error have
---occurred while running the coroutine function, the error is raised on the call
---of the returned function.
---
---### Producer Pattern Example
---
---Imagine a task that produces repetitions of a word: each time it produces a
---repetition, the next one will produce one more. For example, providing `Hello`
---will produce `Hello`, `HelloHello`, `HelloHelloHello`, etc. To do this, you
---can define `repeatThis()`:
---
---```lua
----- This function repeats a word every time its coroutine is resumed
---local function repeatThis(word)
---	local repetition = ""
---	while true do
---		-- Do one repetition then yield the result
---		repetition = repetition .. word
---		coroutine.yield(repetition)
---	end
---end
---```
---
---To run this function as a coroutine, you can use `coroutine.create()` followed
---by multiple calls to `coroutine.resume()`:
---
---```lua
---local repetitionCoro = coroutine.create(repeatThis)
---print(coroutine.resume(repetitionCoro, "Hello"))  -- true, Hello
---print(coroutine.resume(repetitionCoro))           -- true, HelloHello
---print(coroutine.resume(repetitionCoro))           -- true, HelloHelloHello
---```
---
---For this producer function, you can also use `coroutine.wrap()` to get a
---function that produces values:
---
---```lua
---local f = coroutine.wrap(repeatThis)
---print(f("Hello"))  -- Hello
---print(f())         -- HelloHello
---print(f())         -- HelloHelloHello
---```
---
coroutine = nil;
---@vararg Tuple
---@return Tuple<Variant>
---Suspends the execution of the calling coroutine. Any arguments to yield
---are passed as extra results to resume.
---
coroutine.yield = function(...) end;
---@return thread
---Returns the running coroutine.
---
coroutine.running = function() end;
---@param co thread
---@return string
---Returns the status of coroutine co, as a string: 'running', if the
---coroutine is running (that is, it called status); 'suspended', if the
---coroutine is suspended in a call to yield, or if it has not started
---running yet; 'normal' if the coroutine is active but not running (that is,
---it has resumed another coroutine); and 'dead' if the coroutine has
---finished its body function, or if it has stopped with an error.
---
coroutine.status = function(co) end;
---@param f function
---@return thread
---Creates a new coroutine, with body f. f must be a Lua function.
---
coroutine.create = function(f) end;
---@param co thread
---@param val1 Variant
---@vararg Variant
---@return bool, Variant<Tuple, string>
---Starts or continues the execution of coroutine `co`. The first time you
---resume a coroutine, it starts running its body. The values val1, ... are
---passed as the arguments to the body function. If the coroutine has
---yielded, resume restarts it; the values val1, ... are passed as the
---results from the yield. If the coroutine runs without any errors, resume
---returns true plus any values passed to yield (if the coroutine yields) or
---any values returned by the body function (if the coroutine terminates). If
---there is any error, resume returns false plus the error message.
---
coroutine.resume = function(co, val1, ...) end;
---@param f function
---@return thread
---Creates a new coroutine, with body f. f must be a Lua function. Returns a
---function that resumes the coroutine each time it is called. Any arguments
---passed to the function behave as the extra arguments to resume. Returns
---the same values returned by resume, except the first boolean. In case of
---error, propagates the error.
---
coroutine.wrap = function(f) end;
---@class debug
---Provides a few basic functions for debugging code in Roblox. Unlike the
---`debug` library found in Lua natively, this version has been heavily
---sandboxed. Roblox does, however, have debugging functionality similar to Lua's
---native debugging functionality (see the `DebuggerManager` class).
---
debug = nil;
---@overload fun(kw_function: function, options: string): Tuple
---@overload fun(level: number, options: string): Tuple
---@param thread thread
---@param level number
---@param options string
---@return Tuple
---Allows programmatic inspection of the call stack.
---
---- `thread` (thread) - A thread as returned by `coroutine.create`.
---- `level` - A `number` to describe the point at which information from the
---  call stack information should be returned.
---  - A value of `1` represents the function which is calling `debug.info`.
---  - A value of `2` represents the function that called that function, and
---    so on. Out-of-bounds values result in no values returned.
---- `options` - A string that represents the information to be returned. It
---  must contain exactly 0 or 1 of each of the following characters and no
---  others: `slnaf`
---  - `s` - `string`. The function source identifier, equal to the full name
---    of the script the function is defined in
---  - `l` - `number`. If `functionOrLevel` is a function, the line the
---    function is defined on. If `functionOrLevel` is a number (examining a
---    stack frame), the line number of the function call
---  - `n` - `string`. The name of the function, may be nil for anonymous
---    functions and C functions without an assigned debug name.
---  - `a` - `number`, `boolean`. Arity of the function, which refers to the
---    parameter count and whether the function is variadic.
---  - `f` - `function`. The function which was inspected.
---
---This function differs from `debug.traceback` in that it guarantees the
---format of the data it returns. This is useful not only for general logging
---and filtering purposes, but also for sending the data to systems expecting
---structured input, such as crash aggregation.
---
---This function is similar to `debug.getinfo`, an unavailable part of the
---standard Lua library which serves a similar purpose.
---
debug.info = function(thread, level, options) end;
---@return void
---Stops profiling for the most recent MicroProfiler label that
---`debug.profilebegin` opened.
---
debug.profileend = function() end;
---@param label string
---@return void
---Starts profiling for a MicroProfiler label.
---
debug.profilebegin = function(label) end;
---@param tag string
---@return void
---Assigns a custom tag name to the current thread's memory category in the
---Developer Console. Useful for analyzing memory usage of multiple threads
---in the same script which would otherwise be grouped together under the
---same tag/name.
---
debug.setmemorycategory = function(tag) end;
---@return void
---Resets the tag assigned by `debug.setmemorycategory` to the automatically
---assigned value (typically, the script name).
---
debug.resetmemorycategory = function() end;
---@overload fun(thread: thread, message: string, level: number): string
---@param message string
---@param level number
---@return string
---Returns a traceback of the current function call stack as a string. In
---other words, a description of the functions that have been called up to
---this point. The `level` parameter specifies what level of the call stack
---to consider, with `1` being the call of `debug.traceback` itself, `2`
---being the call of the function calling `debug.traceback` (if there is one)
---and so on.
---
---During debugging, `debug.traceback` answers the question "how did my code
---get here?" much like an error stack trace, but without stopping the
---execution of the script. See the example below with several function
---calls: `c()` calls `b()`, `b()` calls `a()`, and `a()` calls
---`debug.traceback`.
---
---```lua
---local function a()
---	print(debug.traceback("Specific moment during a()"))
---end
---
---local function b()
---	a()
---end
---
---local function c()
---	b()
---end
---
---a()
---```
---
---The previous code produces an output similar to, but not guaranteed to be
---exactly like, the following:
---
---```lua
---Specific moment during a()
---ServerScriptService.Script:2 function a
---ServerScriptService.Script:6 function b
---ServerScriptService.Script:10 function c
---ServerScriptService.Script:13
---```
---
---<Alert severity='warning'> The format of the returned traceback is {'
---'}<strong>not defined</strong> and may change at any time; use only for
---debug diagnostics and error analytics. It's recommended that you {'
---'}<strong>never</strong> parse the return value of this function for
---specific information, such as script names or line numbers. </Alert>
---
debug.traceback = function(message, level) end;
---@class math
---@field public huge number
---@field public pi number
---This library is an interface to the standard C math library, providing all of
---its functions inside the `math` table.
---
math = nil;
---Returns the value HUGE_VAL, a value larger than or equal to any other
---numerical value.
---
math.huge = nil;
---The value of pi.
---
math.pi = nil;
---@param x number
---@return number
---Returns the angle x (given in radians) in degrees.
---
math.deg = function(x) end;
---@param x number
---@return number
---Returns the hyperbolic tangent of x.
---
math.tanh = function(x) end;
---@param x number
---@return number
---Returns the value e^x.
---
math.exp = function(x) end;
---@param x number
---@return number
---Returns the tangent of x (assumed to be in radians).
---
math.tan = function(x) end;
---@param x number
---@return int
---Returns the largest integer smaller than or equal to x.
---
math.floor = function(x) end;
---@param x number
---@return number
---Returns the square root of x. (You can also use the expression x^0.5 to
---compute this value.)
---
math.sqrt = function(x) end;
---@param x number
---@return number
---Returns the arc sine of x.
---
math.asin = function(x) end;
---@param x number
---@return number
---Returns the hyperbolic sine of x.
---
math.sinh = function(x) end;
---@param x number
---@return number
---Returns the arc tangent of x (in radians).
---
math.atan = function(x) end;
---@param x number
---@param y number
---@param z number
---@return number
---Returns a perlin noise value. The returned value is most often between the
---range [-1, 1].
---
---The returned value is sometimes will be outside of the range [-1,1], so if
---the interval is critical to you, you should use `math.clamp(noise, -1, 1)`
---on the output.
---
---If you leave arguments out, they will be interpreted as zero, so
---`math.noise(1.158)` is equivalent to `math.noise(1.158, 0, 0)` and
---`math.noise(1.158, 5.723)` is equivalent to `math.noise(1.158, 5.723, 0)`.
---
---The function uses a perlin noise algorithm to assign fixed values to
---coordinates. For example, `math.noise(1.158, 5.723)` will always return
---`0.48397532105446` and `math.noise(1.158, 6)` will always return
---`0.15315161645412`.
---
---If x, y and z are all integers, the return value will be 0. For fractional
---values of x, y and z, the return value will gradually fluctuate between
----0.5 and 0.5. For coordinates that are close to each other, the return
---values will also be close to each other.
---
math.noise = function(x, y, z) end;
---@param x number
---@return number, int
---Returns m and e such that x = m\*2^e, e is an integer and the absolute
---value of m is in the range [0.5, 1) (or zero when x is zero).
---
math.frexp = function(x) end;
---@param x number
---@return number
---Returns the sine of x (assumed to be in radians).
---
math.sin = function(x) end;
---@param x number
---@return int
---Returns -1 if x < 0, 0 if x == 0, or 1 if x > 0.
---
math.sign = function(x) end;
---@param x number
---@return number
---Returns the integer with the smallest difference between it and the given
---number. For example, the value 5.8 returns 6.
---
---For values like 0.5 that are equidistant to two integers, the value with
---the greater difference between it and zero is chosen. In other words, the
---function **rounds away from zero**: 0.5 rounds to 1; -0.5 rounds to -1.
---
math.round = function(x) end;
---@param x number
---@param e int
---@return number
---Returns x\*2^e (e should be an integer).
---
math.ldexp = function(x, e) end;
---@param x number
---@param y number
---@return number
---Returns x^y. (You can also use the expression x^y to compute this value.)
---
math.pow = function(x, y) end;
---@param x number
---@return int
---Returns the smallest integer larger than or equal to x.
---
math.ceil = function(x) end;
---@param x number
---@return number
---Returns the angle x (given in degrees) in radians.
---
math.rad = function(x) end;
---@param x number
---@param y number
---@return number
---Returns the remainder of the division of x by y that rounds the quotient
---towards zero.
---
math.fmod = function(x, y) end;
---@param m number
---@param n number
---@return number
---An interface to the simple pseudo-random generator function rand provided
---by ANSI C. (No guarantees can be given for its statistical properties.)
---When called without arguments, returns a uniform pseudo-random real number
---in the range [0,1). When called with an integer number m, math.random
---returns a uniform pseudo-random integer in the range [1, m]. When called
---with two integer numbers m and n, math.random returns a uniform
---pseudo-random integer in the range [m, n].
---
math.random = function(m, n) end;
---@param x number
---@param base number
---@return number
---Returns the logarithm of x using the given base, or the mathematical
---constant e if no base is provided (natural logarithm).
---
math.log = function(x, base) end;
---@param x number
---@return number, number
---Returns two numbers, the integral part of x and the fractional part of x.
---
math.modf = function(x) end;
---@param x number
---@vararg number
---@return number
---Returns the minimum value among the numbers passed to the function.
---
math.min = function(x, ...) end;
---@param x number
---@vararg number
---@return number
---Returns the maximum value among the numbers passed to the function.
---
math.max = function(x, ...) end;
---@param x number
---@return number
---Returns the absolute value of x.
---
math.abs = function(x) end;
---@param x number
---@return number
---Returns the arc cosine of x.
---
math.acos = function(x) end;
---@param x number
---@return number
---Returns the base-10 logarithm of x.
---
math.log10 = function(x) end;
---@param x number
---@return void
---Sets x as the seed for the pseudo-random generator: equal seeds produce
---equal sequences of numbers.
---
math.randomseed = function(x) end;
---@param x number
---@return number
---Returns the cosine of x (assumed to be in radians).
---
math.cos = function(x) end;
---@param y number
---@param x number
---@return number
---Returns the arc tangent of y/x (in radians), but uses the signs of both
---parameters to find the quadrant of the result. It also handles correctly
---the case of x being zero.
---
math.atan2 = function(y, x) end;
---@param x number
---@return number
---Returns the hyperbolic cosine of x.
---
math.cosh = function(x) end;
---@param x number
---@param min number
---@param max number
---@return number
---Returns a number between min and max, inclusive.
---
math.clamp = function(x, min, max) end;
---@class os
---This library currently serves the purpose of providing information about the
---system time under the UTC format. It has been heavily sandboxed from the
---standard Lua `os` library and does not allow you to perform any
---system-altering operations.
---
os = nil;
---@param t2 int
---@param t1 int
---@return int
---Returns the number of seconds from t1 to t2. The difference is computed
---assuming that t1 and t2 are correctly casted to the
---[time_t](http://en.cppreference.com/w/cpp/chrono/c/time_t) format.
---
os.difftime = function(t2, t1) end;
---@return double
---Returns the amount of CPU time used by Lua in seconds. This value has high
---precision, about 1 microsecond, and is intended for use in benchmarking.
---
---```lua
----- Record the initial time:
---local startTime = os.clock()
----- Do something you want to measure the performance of:
---local a, b = 0, 1
---for i = 1, 5000000 do
---    a, b = b, a
---end
----- Measure amount of time this took:
---local deltaTime = os.clock() - startTime
---print("Elapsed time: " .. deltaTime)
----->  Elapsed time: 0.044425600033719 (actual number may vary)
---```
---
os.clock = function() end;
---@param time table
---@return int
---Returns how many seconds have passed since the
---[Unix epoch](https://en.wikipedia.org/wiki/Unix_time) (1 January 1970,
---00:00:00), under current UTC time. If provided a table formatted similarly
---to that returned by `os.date`, it will return the number of seconds since
---that time instead.
---
---```lua
---print(os.time()) --> 1586982482 (ran at approx. April 15th, 2020 at 1:28 PM PST)
---print(os.time({
---   year=2020, month=4, day=15, -- Date components
---   hour=16, min=28, sec=0 -- Time components
---})) --> 1586968080
---```
---
os.time = function(time) end;
---@param formatString string
---@param time int
---@return Dictionary
---Formats the given `formatString` with date/time information based on the
---given time, or if not provided, the value returned by `os.time`. The
---following specifiers (based on the C function strftime) are supported:
---
---<table>
---  <thead>
---    <tr>
---      <th>Specifier</th>
---      <th>Meaning</th>
---      <th>Example<sup>&dagger;</sup></th>
---     </tr>
---  </thead>
---<tbody>
---<tr><td>%a</td><td>Abbreviated weekday name *</td> <td>Wed</td></tr>
---<tr><td>%A</td><td>Full weekday name *</td>        <td>Wednesday</td></tr>
---<tr><td>%b</td><td>Abbreviated month name *</td>   <td>Sep</td></tr>
---<tr><td>%B</td><td>Full month name *</td>          <td>September</td></tr>
---<tr><td>%c</td><td>Date and time *</td>            <td>09/16/98 23:48:10</td></tr>
---<tr><td>%d</td><td>Day of the month</td>         <td>16</td></tr>
---<tr><td>%H</td><td>Hour, using 24-hour clock</td><td>23</td></tr>
---<tr><td>%I</td><td>Hour, using 12-hour clock</td><td>11</td></tr>
---<tr><td>%j</td><td>Day of year</td>              <td>259</td></tr>
---<tr><td>%m</td><td>Month</td>                    <td>09</td></tr>
---<tr><td>%M</td><td>Minute</td>                   <td>48</td></tr>
---<tr><td>%p</td><td>Either "AM" or "PM"</td>      <td>pm</td></tr>
---<tr><td>%S</td><td>Second</td>                   <td>10</td></tr>
---<tr><td>%U</td><td>Week number (first Sunday as the first day of week one)</td><td>37</td></tr>
---<tr><td>%w</td><td>Weekday</td>                  <td>3</td></tr>
---<tr><td>%W</td><td>Week number (first Monday as the first day of week one)</td><td>37</td></tr>
---<tr><td>%x</td><td>Date *</td>                     <td>09/16/98</td></tr>
---<tr><td>%X</td><td>Time *</td>                     <td>23:48:10</td></tr>
---<tr><td>%y</td><td>Two-digit year</td>           <td>98</td></tr>
---<tr><td>%Y</td><td>Full year</td>                <td>1998</td></tr>
---<tr><td>%z</td><td>ISO 8601 offset from UTC in timezone (1 minute = 1, 1 hour = 100)</td><td>-0400</td></tr>
---<tr><td>%Z</td><td>Timezone name or abbreviation *</td><td>Eastern Daylight Time</td></tr>
---<tr><td>%%</td><td>The % character</td>          <td>%</td></tr>
---</tbody>
---</table>
---
---\* This value can vary depending on the current locale.
---
---&dagger; The example provided is for September 16th, 1998 (a Wednesday) at
---11:48:10 PM (23:48:10), ran using locale "en-us" in Eastern Time (ET).
---
---If the provided `formatString` is exactly `"*t"` (local time) or `"!*t"`
---(UTC time), this function instead returns a dictionary containing the
---following components, which are normally available in the specifiers
---above.
---
---<table>
---  <thead>
---    <tr>
---      <th>Field</th>
---      <th>Type</th>
---      <th>Description</th>
---    </tr>
---  </thead>
---<tbody>
---  <tr>
---    <td>year</td>
---    <td>int</td>
---    <td>An integer that describes the current year of the Current Era (ex. 2017)</td>
---  </tr>
---  <tr>
---    <td>month</td>
---    <td>int</td>
---    <td>An integer between 1 and 12 (starting from January) that describes the current month.</td>
---  </tr>
---  <tr>
---    <td>wday</td>
---    <td>int</td>
---    <td>An integer between 1 and 7 (starting from Sunday) that describes the current week day.</td>
---  </tr>
---  <tr>
---    <td>yday</td>
---    <td>int</td>
---    <td>An integer between 1 and 366 describing how many days we are into the year.<br />There can be 366 days if it is a leap year.</td>
---  </tr>
---  <tr>
---    <td>day</td>
---    <td>int</td>
---    <td>An integer between 1 and 31 describing the current day of the month.</td>
---  </tr>
---  <tr>
---    <td>hour</td>
---    <td>int</td>
---    <td>An integer between 1 and 24 describing the current hour of the day.</td>
---  </tr>
---  <tr>
---    <td>min</td>
---    <td>int</td>
---    <td>An integer between 0 and 59 describing the current minute of the hour.</td>
---  </tr>
---  <tr>
---    <td>sec</td>
---    <td>int</td>
---    <td>An integer between 0 and 60 describing the current second of the hour.<br />(60 because the function is described to indicate leap seconds, but in practice it probably doesn't).</td>
---  </tr>
---  <tr>
---    <td>isdst</td>
---    <td>bool</td>
---    <td>A boolean describing if daylight savings time is currently active.</td>
---  </tr>
---</tbody>
---</table>
---
os.date = function(formatString, time) end;
---@class string
---This library provides generic functions for string manipulation such as
---finding and extracting substrings and matching patterns. It provides all of
---its functions inside the global `string` variable.
---
---For practical details on these functions, see Formatting and Converting
---Strings and String Patterns.
---
string = nil;
---@param formatstring string
---@vararg string
---@return string
---Returns a formatted version of its variable number of arguments following
---the description given in its first argument (which must be a string).
---
string.format = function(formatstring, ...) end;
---@param s string
---@param n int
---@return string
---Returns a string that is the concatenation of `n` copies of the string
---`s`.
---
string.rep = function(s, n) end;
---@param s string
---@param pattern string
---@param replacement Variant
---@param replacements number
---@return string, number
---Short for global substitution. Returns a copy of `s` in which all (or the
---first n, if given) occurrences of the pattern are substituted (replaced)
---with the given `replacement`. The second value returned is the total
---number of substitutions made.
---
---The `replacement` can be one of several types, each used differently to
---determine the actual string:
---
---- string: The pattern is replaced with the string directly
---- table: The string that matched the pattern is looked up in the table as
---  a key, and the value (string) is what replaces it, if it exists.
---- function: Called with the string that matched the pattern, should return
---  the string to replace the matched pattern.
---
---An optional final argument can be provided which specifies the maximum
---number of substitutions to make (for example, stop after 2 replacements)
---
---#### Various Examples
---
---```lua
----- Simple replacement
---string.gsub("I love tacos!", "tacos", "Roblox") --> I love Roblox! 1
----- Using a pattern (hint: %w+ matches whole words)
---string.gsub("I like red!", "%w+", "word") --> word word word 3
----- Replacement table
---string.gsub("I play Roblox.", "%w+", {I="Je", play="joue à"}) --> Je joue à Roblox. 3
----- Replacement function
---string.gsub("I have 2 cats.", "%d+", function (n) return tonumber(n) * 12 end) --> I have 24 cats. 1
----- Replace only twice
---string.gsub("aaa", "a", "b", 2) --> "bba", 2
---```
---
string.gsub = function(s, pattern, replacement, replacements) end;
---@param s string
---@return string
---Returns a string that is the string `s` reversed.
---
string.reverse = function(s) end;
---@param s string
---@param separator string
---@return table
---Splits a string into parts based on the defined separator character(s),
---returning a table of ordered results.
---
---If an empty "slice" is located, that part will be returned as an empty
---string. For instance `string.split("abc||def", "|")` will return a table
---with three strings: `"abc"`, `""`, and `"def"`.
---
---```lua
---local values = input:split(",")
---print(values[1], values[2], values[3])
---```
---
---Also note that whitespace from the original string will be preserved, for
---example `string.split("abc _ def", "_")` will honor the whitespace on both
---sides of the `_` separator. By default, the separator character is `,` but
---you can specify an alternative character or series of characters.
---
---**Corner Cases**
---
---#### Empty String
---
---```lua
---"" --> ""
---```
---
---#### Empty Slices
---
---```lua
---"foo,,bar" --> "foo", "", "bar"
---",foo" --> "", "foo"
---"foo," --> "foo", ""
---"," --> "", ""
---",," --> "", "", ""
---```
---
---#### Whitespace Preserved
---
---```lua
---"   whitespace   " --> "   whitespace   "
---"foo , bar" --> "foo ", " bar"
---```
---
---#### Invalid UTF-8
---
---```lua
---"\xFF" --> "\xFF"
---"\xFD,\xFE" --> "\xFD", "\xFE"
---```
---
---#### Unicode
---
---```lua
---"，" --> U+FF0C FULLWIDTH COMMA
---"我很高兴，你呢？" --> "我很高兴", "你呢？"
---"•" --> U+2022 BULLET
---"hello•world" --> "hello", "world"
---```
---
string.split = function(s, separator) end;
---@vararg int
---@return string
---Receives zero or more integers and returns a string with length equal to
---the number of arguments that has each character has the internal numerical
---code equal to its corresponding argument.
---
string.char = function(...) end;
---@param s string
---@return string
---Returns a copy of a string with all uppercase letters changed to
---lowercase.
---
string.lower = function(s) end;
---@param s string
---@param pattern string
---@param init number
---@return string
---Looks for the first match of pattern in the string `s`. If a match is
---found, it is returned; otherwise, it returns nil. A third, optional
---numerical argument, init, specifies where to start the search; its default
---value is 1 and can be negative.
---
string.match = function(s, pattern, init) end;
---@param s string
---@param pattern string
---@param init number
---@param plain bool
---@return number, number
---Looks for the first match of pattern in the string `s`. If it finds a
---match, then it returns the indices of `s` where the occurrence starts and
---ends; otherwise, it returns nil. A third, optional numerical argument init
---specifies where to start the search; its default value is 1 and can be
---negative. A value of true as a fourth, optional argument plain turns off
---the pattern matching facilities, so the function does a plain "find
---substring" operation, with no characters in the pattern being considered
---"magic". Note that if _plain_ is given, then _init_ must be given as well.
---
string.find = function(s, pattern, init, plain) end;
---@param format string
---@vararg Variant
---@return string
---Returns a binary string containing the provided arguments. The description
---in the first argument, which must be a string, determines the way the
---remaining arguments are packed.
---
string.pack = function(format, ...) end;
---@param s string
---@return string
---Returns a copy of a string with all lowercase letters changed to
---uppercase.
---
string.upper = function(s) end;
---@param format string
---@param data string
---@param readStart string
---@return Tuple
---Extracts the values packed in the provided binary string based on the
---description in the first argument. The description should match the one
---originally used to pack the string. The optional third parameter
---determines the byte at which the reading starts.
---
string.unpack = function(format, data, readStart) end;
---@param s string
---@param pattern string
---@return function
---Returns an iterator function that returns the next captures from pattern
---over the string `s` each time it's called.
---
string.gmatch = function(s, pattern) end;
---@param s string
---@return int
---Returns the length of a string.
---
string.len = function(s) end;
---@param s string
---@param i number
---@param j number
---@return int
---Returns the internal numerical codes of the characters
---`s[i], s[i+1], ..., s[j]`. The default value for `i` is 1; the default
---value for `j` is `i`. These indices are corrected following the same rules
---of function string.sub.
---
string.byte = function(s, i, j) end;
---@param s string
---@param i int
---@param j int
---@return string
---Returns the substring of `s` that starts at `i` and continues until j. `i`
---and `j` can be negative. `i` defaults to 1 and `j` defaults to `-j`.
---
string.sub = function(s, i, j) end;
---@param format string
---@return number
---Returns the size in bytes of any string packed with a given description.
---You can't use `s` and `z` because they have variable lengths.
---
string.packsize = function(format) end;
---@class table
---This library provides generic functions for table/array manipulation,
---providing all its functions inside the global `table` variable. Most functions
---in the `table` library assume that the table represents an array or a list.
---For these functions, the "length" of a table means the result of the length
---operator.
---
table = nil;
---@param t table
---@return table
---This function makes the given table read-only, effectively "freezing" it
---in its current state. Attempting to modify a frozen table throws an error.
---
---This freezing effect is shallow, which means that you can write to a table
---within a frozen table. To deep freeze a table, call this function
---recursively on all of the descending tables.
---
table.freeze = function(t) end;
---@param t Array
---@return number
---Returns the number of elements in the table passed.
---
table.getn = function(t) end;
---@param count number
---@param value Variant
---@return table
---Creates a table with the array portion allocated to the given `number` of
---elements, optionally filled with the given `value`.
---
---```lua
---local t = table.create(3, "Roblox")
---print(table.concat(t)) --> RobloxRobloxRoblox
---```
---
---If you are inserting into large array-like tables and are certain of a
---reasonable upper limit to the number of elements, it's recommended to use
---this function to initialize the table. This ensures the table's array
---portion of its memory is sufficiently sized, as resizing it can be
---expensive. For small quantities this is typically not noticeable.
---
table.create = function(count, value) end;
---@overload fun(t: Array, value: Variant): void
---@param t Array
---@param pos number
---@param value Variant
---@return void
---Inserts the provided value to the target position of the array.
---
table.insert = function(t, pos, value) end;
---@vararg Variant
---@return Variant
---Returns a new table with all arguments stored into keys 1, 2, etc. and
---with a field "n" with the total number of arguments. Note that the
---resulting table may not be a sequence.
---
---```lua
---local t = table.pack(1, 2, 3)
---print(table.concat(t, ", ")) --> 1, 2, 3
---```
---
table.pack = function(...) end;
---@param haystack table
---@param needle Variant
---@param init number
---@return Variant
---Within the given array-like table `haystack`, find the first occurrence of
---value `needle`, starting from index `init` or the beginning if not
---provided. If the value is not found, `nil` is returned.
---
---A [linear search](https://en.wikipedia.org/wiki/Linear_search) algorithm
---is performed.
---
---```lua
---local t = {"a", "b", "c", "d", "e"}
---print(table.find(t, "d")) --> 4
---print(table.find(t, "z")) --> nil, because z is not in the table
---print(table.find(t, "b", 3)) --> nil, because b appears before index 3
---```
---
table.find = function(haystack, needle, init) end;
---@param t table
---@return table
---Returns an unfrozen shallow copy of the provided table.
---
table.clone = function(t) end;
---@param t Array
---@param comp function
---@return void
---Sorts elements of array t in a given order, from `t[1]` to `t[#t]`. If
---`comp` is given, then it must be a function that receives two elements and
---returns true when the first element must come before the second in the
---final order (so that not `comp(t[i+1],t[i])` will be true after the sort).
---If `comp` is not given, then the standard Lua operator `<` is used
---instead.
---
table.sort = function(t, comp) end;
---@param t Array
---@param f function
---@return void
---Iterates over the provided table, passing the key and value of each
---iteration over to the provided function.
---
table.foreach = function(t, f) end;
---@param list table
---@param i number
---@param j number
---@return Tuple
---Returns the elements from the given list. This function is equivalent to:
---
---```lua
---return list[i], list[i+1], ..., list[j]
---```
---
---By default, `i` is 1 and `j` is the length of `list`.
---
---```lua
---local t = {1, 2, 3}
---local one, two, three = table.unpack(t)
---print(one, two, three) -- 1 2 3
---```
---
---This same functionality is also provided by the built-in `unpack`
---function.
---
table.unpack = function(list, i, j) end;
---@param t Array
---@param sep string
---@param i int
---@param j int
---@return string
---Given an array where all elements are strings or numbers, returns the
---string `t[i] ... sep ... t[i+1] ... sep ... t[j]`. The default value for
---sep is an empty string, the default for `i` is 1, and the default for `j`
---is #t. If i is greater than `j`, returns the empty string.
---
table.concat = function(t, sep, i, j) end;
---@param t table
---@return bool
---This function returns `true` if the given table is frozen and `false` if
---it isn't frozen. You can freeze tables using `table.freeze()`.
---
table.isfrozen = function(t) end;
---@param t table
---@return number
---Returns the maximum numeric key of the provided table, or zero if the
---table has no numeric keys. Gaps in the table are ignored.
---
table.maxn = function(t) end;
---@param t Array
---@param f function
---@return void
---This is similar to table.foreach() except that index-value pairs are
---passed, not key-value pairs.
---
table.foreachi = function(t, f) end;
---@param a1 table
---@param f number
---@param e number
---@param t number
---@param a2 table
---@return table
---Moves elements from table `a1` to table `a2`, performing the equivalent to
---the following multiple assignment: `a2[t], ... = a1[f], ..., a1[e]`. The
---default for `a2` is `a1`. The destination range can overlap with the
---source range. The number of elements to be moved must fit in a Lua
---integer.
---
---Returns the destination table `a2`.
---
---```lua
---src = {"a", "b", "c", "d", "e"}
---dst = {"v", "w", "x", "y", "z"}
---table.move(src, 2, 4, 1, dst) -- Move index 2 through 4 in src to index 1 in dst
---print(table.concat(dst)) --> bcdyz
---```
---
table.move = function(a1, f, e, t, a2) end;
---@param table table
---@return void
---Sets the value for all keys within the given table to nil. This causes the
---`#` operator to return `0` for the given table. The allocated capacity of
---the table's array portion is maintained, which allows for efficient re-use
---of the space.
---
---```lua
---local grades = {95, 82, 71, 92, 100, 60}
---print(grades[4], #grades) --> 92, 6
---table.clear(grades)
---print(grades[4], #grades) --> nil, 0
----- If grades is filled again with the same number of entries,
----- no potentially expensive array resizing will occur
----- because the capacity was maintained by table.clear.
---```
---
---This function does not delete/destroy the table provided to it. This
---function is meant to be used specifically for tables that are to be
---re-used.
---
table.clear = function(table) end;
---@param t Array
---@param pos number
---@return Variant
---Removes from array t the element at position pos, returning the value of
---the removed element. When pos is an integer between `1` and `#t`, it
---shifts down the elements `t[pos+1], t[pos+2], ..., t[#t]` and erases
---element `t[#t]`. The index `pos` can also be `0` when `#t` is `0` or
---`#t+1`; in those cases, the function erases the element `t[pos]``.
---
table.remove = function(t, pos) end;
---@class task
---The **task** library allows for functions and threads to be scheduled with the
---Task Scheduler.
---
---The functions available in this library generally support functions and
---threads. In most cases using a function is sufficient, but for more advanced
---cases it's recommended you familiarize yourself with the
---[coroutine](./coroutine) library.
---
task = nil;
---@param duration number
---@param functionOrThread function | thread
---@vararg Variant
---@return thread
---Accepts a function or a thread (as returned by coroutine.create) and
---schedules it to be called/resumed on the next
---`RunService/Heartbeat|Heartbeat` after the given amount of time in seconds
---has elapsed. Arguments after the second are sent to the function/thread.
---
---This function differs from the deprecated global `delay` function in that
---**no throttling occurs**: on the very same Heartbeat step in which enough
---time has passed, the function is guaranteed to be called/resumed.
---Providing a duration of zero (0) will guarantee that the function is
---called on the very next Heartbeat.
---
---You can calculate the actual time passed by calling `os.clock` upon
---scheduling and in the scheduled function.
---
task.delay = function(duration, functionOrThread, ...) end;
---@param thread thread
---@return void
---Cancels a thread and closes it, preventing it from being resumed manually
---or by the task scheduler.
---
---This function can be used with other members of the task library that
---return a thread to cancel them before they are resumed. For example:
---
---```lua
---local thread = task.delay(5, function ()
---  print("Hello world!")
---end)
---
---task.cancel(thread)
---```
---
task.cancel = function(thread) end;
---@param functionOrThread function | thread
---@vararg Variant
---@return thread
---Accepts a function or a thread (as returned by coroutine.create) and
---calls/resumes it immediately through the engine's scheduler. Arguments
---after the first are sent to the function/thread. This function does not
---return any value, even if the provided function returns one immediately.
---
---This function is based on the fastSpawn pattern rather than being a
---replacement for the deprecated global `spawn` function. It is recommended
---that this function be used in place of fastSpawn.
---
task.spawn = function(functionOrThread, ...) end;
---@param duration? number
---@return number
---Yields the current thread until the given duration (in seconds) has
---elapsed, then resumes the thread on the next
---`RunService/Heartbeat|Heartbeat` step. The actual amount of time elapsed
---is returned.
---
---If no duration is given, it will default to zero (0). This means the
---thread resumes on the very next step, which is equivalent in behavior to
---`RunService.Heartbeat:Wait()`
---
---Unlike the deprecated global `wait`, this function **does not throttle**
---and guarantees the resumption of the thread on the first Heartbeat that
---occurs when it is due. This function also only returns the elapsed time
---and nothing else.
---
task.wait = function(duration) end;
---@param functionOrThread function | thread
---@vararg Variant
---@return thread
---Accepts a function or a thread (as returned by coroutine.create) and
---defers it until the next
---[resumption cycle](https://devforum.roblox.com/t/1240569), at which point
---it is resumed with the engine's scheduler like with `task.spawn`.
---Arguments after the first are sent to the function/thread. This function
---does not return any value, even if the provided function returns one
---immediately.
---
---This function should be used when a similar behavior to `task.spawn` is
---desirable, but the thread does not need to run immediately.
---
task.defer = function(functionOrThread, ...) end;
---@return void
---Causes the following code to be run in serial. If the script is already
---running in serial, no change occurs. For more information, see
---[Parallel Scripting](/scripting/scripts/parallel-scripting).
---
task.synchronize = function() end;
---@return void
---Causes the following code to be run in parallel. If the script is already
---running in parallel, no change occurs. For more information, see
---[Parallel Scripting](/scripting/scripts/parallel-scripting).
---
task.desynchronize = function() end;
---@class utf8
---@field public charpattern string
---This library provides basic support for `UTF-8` encoding. This library does
---not provide any support for Unicode other than the handling of the encoding.
---Any operation that needs the meaning of a character, such as character
---classification, is outside its scope.
---
---Unless stated otherwise, all functions that expect a byte position as a
---parameter assume that the given position is either the start of a byte
---sequence or one plus the length of the subject string. As in the string
---library, negative indices count from the end of the string.
---
---You can find a large catalog of usable `UTF-8`characters
---[here](https://www.w3schools.com/charsets/ref_html_utf8.asp).
---
utf8 = nil;
---The pattern `"[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*"`, which matches exactly
---zero or more UTF-8 byte sequence, assuming that the subject is a valid
---UTF-8 string.
---
utf8.charpattern = nil;
---@param str string
---@param i number
---@param j number
---@return function
---Returns an iterator function so that
---
---```lua
---for first, last in utf8.graphemes(str) do
---	local grapheme = s:sub(first, last)
---	-- body
---end
---```
---
---will iterate the grapheme clusters of the string.
---
utf8.graphemes = function(str, i, j) end;
---@param codepoints Tuple<int>
---@return string
---Receives zero or more codepoints as integers, converts each one to its
---corresponding UTF-8 byte sequence and returns a string with the
---concatenation of all these sequences.
---
utf8.char = function(codepoints) end;
---@param s string
---@param i int
---@param j int
---@return int
---Returns the number of UTF-8 codepoints in the string _str_ that start
---between positions `i` and `j` (both inclusive). The default for `i` is `1`
---and for `j` is `-1`. If it finds any invalid byte sequence, returns a nil
---value plus the position of the first invalid byte.
---
utf8.len = function(s, i, j) end;
---@param str string
---@return string
---Converts the input string to Normal Form D, which tries to break up
---composed characters into decomposed characters.
---
utf8.nfdnormalize = function(str) end;
---@param str string
---@return string
---Converts the input string to Normal Form C, which tries to convert
---decomposed characters into composed characters.
---
utf8.nfcnormalize = function(str) end;
---@param str string
---@param i int
---@param j int
---@return Tuple<int>
---Returns the codepoints (as integers) from all codepoints in the provided
---string (str) that start between byte positions `i` and `j` (both
---included). The default for `i` is `1` and for `j` is `i`. It raises an
---error if it meets any invalid byte sequence.
---
utf8.codepoint = function(str, i, j) end;
---@param str string
---@return function, string, int
---Returns an iterator function so that the construction:
---
---```lua
---for position, codepoint in utf8.codes(str) do
---	-- body
---end
---```
---
---will iterate over all codepoints in string `str`. It raises an error if it
---meets any invalid byte sequence.
---
utf8.codes = function(str) end;
---@param s string
---@param n int
---@param i int
---@return int
---Returns the position (in bytes) where the encoding of the n-th codepoint
---of `s` (counting from byte position `i`) starts. A negative `n` gets
---characters before position `i`. The default for `i` is `1` when `n` is
---non-negative and `#s + 1` otherwise, so that `utf8.offset(s, -n)` gets the
---offset of the n-th character from the end of the string. If the specified
---character is neither in the subject nor right after its end, the function
---returns `nil`.
---
utf8.offset = function(s, n, i) end;
---@class Enum.SelectionBehavior
---@field public Escape number | '0'
---@field public Stop number | '1'
---Customization options for gamepad selection when `GuiBase2d/SelectionGroup` is
---true.
---
local SelectionBehavior;
---Prioritizes GuiObjects within the same SelectionGroup but allows the
---selection to move to other outside GuiObjects if no suitable button is
---found.
---
SelectionBehavior.Escape = nil;
---Constrains gamepad selection to the SelectionGroup.
---
SelectionBehavior.Stop = nil;
Enum.SelectionBehavior = SelectionBehavior;
---@diagnostic disable-next-line
---@alias SelectionBehavior Enum.SelectionBehavior
---@class Enum.PropertyStatus
---@field public Ok number | '0'
---@field public Warning number | '1'
---@field public Error number | '2'
local PropertyStatus;
---
PropertyStatus.Ok = nil;
---
PropertyStatus.Warning = nil;
---
PropertyStatus.Error = nil;
Enum.PropertyStatus = PropertyStatus;
---@diagnostic disable-next-line
---@alias PropertyStatus Enum.PropertyStatus
---@class Enum.WrapLayerAutoSkin
---@field public Disabled number | '0'
---@field public EnabledPreserve number | '1'
---@field public EnabledOverride number | '2'
local WrapLayerAutoSkin;
---
WrapLayerAutoSkin.Disabled = nil;
---
WrapLayerAutoSkin.EnabledPreserve = nil;
---
WrapLayerAutoSkin.EnabledOverride = nil;
Enum.WrapLayerAutoSkin = WrapLayerAutoSkin;
---@diagnostic disable-next-line
---@alias WrapLayerAutoSkin Enum.WrapLayerAutoSkin
