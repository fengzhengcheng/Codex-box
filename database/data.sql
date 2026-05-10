USE aihub_pro;

INSERT INTO admin (username, password, nickname) VALUES ('admin', '123456', '超级管理员');

INSERT INTO user (username, password, nickname, email, status, role) VALUES
('test', '123456', '测试用户', 'test@example.com', 1, 0);

INSERT INTO tool_category (name, description, sort) VALUES
('AI聊天', 'AI对话聊天工具，支持多轮对话、上下文理解', 1),
('AI写代码', 'AI编程助手，支持代码生成、调试、重构', 2),
('AI生图', 'AI图像生成工具，支持文生图、图生图', 3),
('AI PPT', 'AI演示文稿生成工具，一键制作专业PPT', 4),
('AI视频', 'AI视频创作工具，支持文本转视频、视频编辑', 5),
('AI搜索', 'AI智能搜索引擎，提供精准答案而非链接列表', 6),
('AI翻译', 'AI翻译工具，支持多语言互译、文档翻译', 7),
('AI办公', 'AI办公效率工具，涵盖写作、设计、协作等场景', 8),
('AI部署', 'AI应用部署平台，快速上线你的AI项目', 9),
('AI论文', 'AI学术辅助工具，助力论文写作与文献管理', 10);

INSERT INTO ai_tool (category_id, name, logo, description, detail, website_url, screenshot, tags, is_free, rating, views) VALUES
(1, 'ChatGPT', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/ChatGPT_logo.svg.svg/120px-ChatGPT_logo.svg.svg.png',
'OpenAI旗下旗舰AI对话产品，基于GPT-4/GPT-4o大模型，支持文本对话、图像识别、代码执行、联网搜索等能力。',
'<p>ChatGPT是由OpenAI开发的先进人工智能对话系统，目前最新版本基于GPT-4o模型构建。</p><h3>核心功能</h3><ul><li><strong>智能对话：</strong>支持多轮自然语言对话，具备出色的上下文理解和推理能力</li><li><strong>图像识别：</strong>可上传图片进行分析、描述、OCR文字识别</li><li><strong>代码执行：</strong>内置Python解释器，可直接运行代码并查看结果</li><li><strong>联网搜索：</strong>实时获取网络信息，回答时效性问题</li><li><strong>插件生态：</strong>丰富的第三方插件扩展能力</li><li><strong>GPTs定制：</strong>可创建和分享自定义AI助手</li></ul><h3>适用场景</h3><p>文案写作、代码开发、数据分析、学习辅导、创意构思、问题解答等几乎所有知识工作场景。</p><h3>价格方案</h3><p>免费版：GPT-4o mini，有限制使用量；Plus版：$20/月，享受GPT-4o完整能力；Team/Enterprise版：面向团队和企业用户。</p>',
'https://chat.openai.com', NULL, 'AI聊天,GPT,OpenAI,对话,智能助手', 0, 5.0, 0),

(1, 'Claude', 'https://www.anthropic.com/images/icons/apple-touch-icon.png',
'Anthropic开发的AI助手，以安全性和长上下文处理著称，支持200K超长上下文窗口，擅长复杂分析和长文写作。',
'<p>Claude是Anthropic公司推出的AI对话助手，以其出色的安全性设计和超长上下文处理能力而闻名。</p><h3>核心优势</h3><ul><li><strong>超长上下文：</strong>Claude 3.5 Sonnet支持200K token上下文，相当于约15万汉字或500页文档</li><li><strong>安全可靠：</strong>采用Constitutional AI技术训练，输出更安全可控</li><li><strong>分析能力强：</strong>在复杂数据分析、长文档阅读、代码审查方面表现优异</li><li><strong>Artifacts功能：</strong>可将对话内容直接渲染为可交互的代码、文档、图表</li><li><strong>多模态支持：</strong>支持图片输入和分析</li></ul><h3>版本对比</h3><p>Haiiku：最快最轻量，适合简单任务；Sonnet：平衡性能与速度，适合大多数场景；Opus：最强性能，适合复杂推理任务。</p><h3>适用场景</h3><p>长文档分析与总结、学术论文辅助、代码架构设计、复杂逻辑推理、多步骤任务规划等专业领域。</p>',
'https://claude.ai', NULL, 'AI聊天,Claude,Anthropic,长上下文,安全AI', 0, 4.9, 0),

(1, 'Gemini', 'https://www.gstatic.com/lamda/images/gemini_sparkle_v002_d4735804ff6292a690345.svg',
'Google DeepMind打造的下一代AI模型，原生多模态设计，深度集成Google生态，支持图文音视频全模态交互。',
'<p>Gemini是Google DeepMind开发的新一代大语言模型，从底层就为多模态而设计。</p><h3>核心特性</h3><ul><li><strong>原生多模态：</strong>不同于"拼接"方式，Gemini从一开始就同时训练文本、图像、音频和视频</li><li><strong>Google生态集成：</strong>与Gmail、Docs、Drive、Maps等服务无缝衔接</li><li><strong>Gemini Advanced：</strong>付费订阅可使用Ultra 1.0最强模型</li><li><strong>Google Search联动：</strong>实时获取最新信息，答案附带来源引用</li><li><strong>代码执行：</strong>支持Python代码运行环境</li></ul><h3>模型版本</h3><p>Ultra 1.0：最强综合能力；Pro：日常高效使用；Flash：快速响应；Nano：端侧设备运行。</p><h3>适用场景</h3><p>信息检索与研究、Google Workspace协同办公、多模态内容创作、教育学习、旅行规划等需要结合Google服务的场景。</p>',
'https://gemini.google.com', NULL, 'AI聊天,Gemini,Google,多模态,DeepMind', 1, 4.8, 0),

(1, 'DeepSeek', 'https://deepseek.com/favicon.ico',
'国产顶尖AI大模型，开源开放，在数学推理和代码能力上表现卓越，提供免费的API服务。',
'<p>DeepSeek（深度求索）是中国领先的AI公司，其大模型在多项基准测试中达到世界一流水平。</p><h3>核心亮点</h3><ul><li><strong>超强数学推理：</strong>在MATH、GSM8K等数学基准测试中名列前茅</li><li><strong>代码能力突出：</strong>支持主流编程语言的代码生成、调试、解释</li><li><strong>完全开源：</strong>模型权重完全开源，支持本地部署</li><li><strong>API性价比高：</strong>提供极具竞争力的API定价，部分模型免费使用</li><li><strong>DeepSeek-R1：</strong>推理增强模型，展现思维链推理过程</li><li><strong>DeepSeek-V3：</strong>MoE架构超大模型，参数量达671B</li></ul><h3>适用场景</h3><p>数学计算与证明、算法设计与优化、代码开发、科学研究、技术文档撰写、逻辑推理等对推理能力要求高的场景。</p>',
'https://chat.deepseek.com', NULL, 'AI聊天,DeepSeek,国产AI,开源,数学推理,代码', 1, 4.7, 0),

(1, 'Kimi', 'https://kimi.moonshot.cn/favicon.ico',
'Moonshot AI（月之暗面）出品，以超长上下文处理为核心竞争力，支持上传文件进行深度分析，国产AI标杆产品之一。',
'<p>Kimi是月之暗面（Moonshot AI）开发的AI助手，最大的特色是其强大的长文本处理能力。</p><h3>核心功能</h3><ul><li><strong>超长上下文：</strong>支持输入长达200万字的内容，可一次性处理整本书籍</li><li><strong>文件解析：</strong>支持PDF、Word、Excel、PPT等多种格式文件上传与分析</li><li><strong>联网搜索：</strong>自动联网获取最新信息辅助回答</li><li><strong>深度阅读：</strong>对长文档进行结构化摘要、关键信息提取</li><li><strong>代码能力：</strong>支持代码编写、调试和项目级代码分析</li></ul><h3>适用场景</h3><p>学术论文阅读与整理、法律合同审查、长篇报告分析、技术文档研读、行业研究报告解读等需要处理大量文本的场景。</p>',
'https://kimi.moonshot.cn', NULL, 'AI聊天,Kimi,月之暗面,长上下文,文件解析,国产AI', 1, 4.6, 0),

(1, 'Qwen/通义千问', 'https://img.alicdn.com/imgextra/i3/O1CN01LmYnQ21pRbPYbzM_!!6000000005727-2-tps-200-200.png',
'阿里巴巴达摩院打造的大语言模型，中文能力出色，开源生态丰富，提供从轻量到超大模型的完整矩阵。',
'<p>通义千问（Qwen）是阿里巴巴达摩院自主研发的大语言模型系列，覆盖从端侧到云端的全尺寸模型矩阵。</p><h3>模型矩阵</h3><ul><li><strong>Qwen-Max：</strong>旗舰模型，综合能力最强，适合复杂任务</li><li><strong>Qwen-Plus：</strong>高性能模型，平衡效果与成本</li><li><strong>Qwen-Turbo：</strong>高速响应模型，适合高并发场景</li><li><strong>Qwen-VL：</strong>视觉语言模型，支持图像理解</li><li><strong>Qwen-Audio：</strong>语音理解模型，支持语音输入</li><li><strong>Qwen2.5系列：</strong>开源模型，支持本地部署</li></ul><h3>核心优势</h3><p>中文理解能力顶尖、开源社区活跃、阿里云深度集成、支持函数调用和Agent开发。</p><h3>适用场景</h3><p>中文内容创作、电商客服、企业知识库、智能客服、中文NLP任务开发等。</p>',
'https://qwen.aliyun.com', NULL, 'AI聊天,Qwen,通义千问,阿里云,中文AI,开源', 1, 4.7, 0),

(3, 'Midjourney', 'https://www.midjourney.com/favicon.ico',
'全球最知名的AI绘画工具，通过Discord交互，生成的图像艺术感强、质量极高，是设计师和创作者的首选。',
'<p>Midjourney是目前最受欢迎的AI图像生成工具之一，以其独特的艺术风格和高质量的输出著称。</p><h3>核心特性</h3><ul><li><strong>顶级画质：</strong>生成的图像细节丰富、构图精美、艺术感极强</li><li><strong>风格多样：</strong>支持摄影写实、油画水彩、动漫插画、3D渲染等多种风格</li><li><strong>Discord交互：</strong>通过Discord服务器使用，社区氛围活跃</li><li><strong>参数丰富：</strong>--ar宽高比、--s风格化、--chaos变化度等参数精细控制</li><li><strong>图生图：</strong>支持参考图像进行风格迁移和变体生成</li><li><strong>V6模型：</strong>最新版本支持文本渲染和更准确的提示词理解</li></ul><h3>价格方案</h3><p>基础版$10/月、标准版$30/月、专业版$60/月。按月订阅制，不同套餐对应不同的生成时长。</p><h3>适用场景</h3><p>概念艺术设计、商业插画创作、UI界面灵感、社交媒体配图、品牌视觉素材、游戏原画等创意设计场景。</p>',
'https://www.midjourney.com', NULL, 'AI生图,Midjourney,AI绘画,设计,Discord,艺术创作', 0, 4.9, 0),

(3, 'Stable Diffusion', 'https://stability.ai/favicon.ico',
'开源AI图像生成模型，可本地部署运行，拥有庞大的插件和模型生态，是AI绘画领域的核心技术底座。',
'<p>Stable Diffusion由Stability AI发布，是目前最重要的开源AI图像生成模型，催生了整个AIGC生态系统。</p><h3>核心优势</h3><ul><li><strong>完全开源：</strong>模型权重、代码全部开源，可自由使用和二次开发</li><li><strong>本地部署：</strong>支持消费级显卡本地运行，数据隐私有保障</li><li><strong>生态丰富：</strong>WebUI（AUTOMATIC1111/ComfyUI）、LoRA模型、ControlNet插件等生态极其繁荣</li><li><strong>高度可控：</strong>通过ControlNet实现精确的姿态、边缘、深度控制</li><li><strong>模型众多：</strong>SDXL、SD3、Flux等新一代模型持续进化</li><li><strong>训练友好：</strong>支持LoRA微调，可用少量图片训练专属风格</li></ul><h3>主流界面</h3><p>AUTOMATIC1111 WebUI：功能全面易上手；ComfyUI：节点式工作流，专业级控制；Fooocus：开箱即用简化版。</p><h3>适用场景</h3><p>个人创作、商业设计、游戏资产制作、AI写真、产品图生成、风格迁移、批量出图等需要高度定制化的场景。</p>',
'https://stability.ai', NULL, 'AI生图,Stable Diffusion,开源,本地部署,LoRA,ControlNet,AIGC', 1, 4.5, 0),

(8, 'Canva AI', 'https://www.canva.com/favicon.ico',
'全球领先的在线设计平台，集成AI能力后可实现一键生成设计稿、智能抠图、AI扩图等功能，非设计师也能做出专业作品。',
'<p>Canva是全球最大的在线设计平台，集成了强大的AI功能，让每个人都能轻松创作专业级别的设计作品。</p><h3>AI核心功能</h3><ul><li><strong>Magic Design：</strong>输入描述即可自动生成海报、社交媒体图、演示文稿等设计稿</li><li><strong>Magic Eraser：</strong>AI智能抠图擦除，一键去除背景或不需要的元素</li><li><strong>Magic Expand：</strong>AI智能扩图，将小图扩展为任意比例而不变形</li><li><strong>Magic Write：</strong>AI文案生成，自动撰写营销文案和标题</li><li><strong>文本转图：</strong>将文字描述直接转换为高质量图像</li><li><strong>模板海量：</strong>数百万个精美模板，覆盖几乎所有设计场景</li></ul><h3>价格方案</h3><p>免费版：基础功能可用；Pro版：$12.99/月/人，解锁全部AI功能和素材库；Teams版：团队协作功能。</p><h3>适用场景</h3><p>社交媒体运营、营销物料制作、PPT演示文稿、名片传单设计、品牌视觉统一、电商主图制作等非专业设计人员的日常设计需求。</p>',
'https://www.canva.com', NULL, 'AI办公,Canva,设计,在线设计,AI设计,模板,营销', 0, 4.6, 0),

(8, 'Notion AI', 'https://www.notion.so/favicon.ico',
'全能型知识管理和协作平台，内置AI助手可帮助写作、总结、翻译、头脑风暴，是个人和团队的知识库首选工具。',
'<p>Notion是一款集笔记、文档、项目管理、知识库于一体的全能协作工具，Notion AI为其注入了智能化能力。</p><h3>AI功能一览</h3><ul><li><strong>AI写作助手：</strong>帮助起草、改写、润色、调整语气和篇幅</li><li><strong>自动总结：</strong>一键总结长文档要点，快速把握核心内容</li><li><strong>智能翻译：</strong>支持多语言翻译，保持格式不变</li><li><strong>提取信息：</strong>从表格和数据库中提取关键数据</li><li><strong>头脑风暴：</strong>生成创意点子和方案建议</li><li><strong>数据库问答：</strong>用自然语言查询Notion数据库</li></ul><h3>核心价值</h3><p>All-in-One工作空间 + AI赋能 = 知识工作的终极解决方案。将笔记、项目、Wiki、文档统一管理，AI让信息处理效率倍增。</p><h3>适用场景</h3><p>个人知识管理、团队协作wiki、产品需求文档、会议记录整理、读书笔记、项目追踪、第二大脑搭建等知识密集型工作场景。</p>',
'https://www.notion.so', NULL, 'AI办公,Notion,知识管理,协作,笔记,AI写作,数据库', 0, 4.5, 0),

(2, 'Cursor', 'https://www.cursor.so/favicon.ico',
'专为AI编程设计的IDE编辑器，深度集成AI能力，支持代码补全、生成、重构、解释，被誉为程序员的AI副驾驶。',
'<p>Cursor是基于VS Code构建的AI原生代码编辑器，将AI能力深度融入编码的每一个环节。</p><h3>核心功能</h3><ul><li><strong>智能补全：</strong>Tab键触发AI代码补全，预测你想要写的下一行代码</li><li><strong>Cmd+K生成：</strong>选中区域后用自然语言描述，AI直接生成替换代码</li><li><strong>Chat面板：</strong>内置AI对话框，可询问代码问题、请求修改、解释逻辑</li><li><strong>Composer：</strong>多文件同时编辑，AI理解整个项目上下文进行跨文件修改</li><li><strong>@代码库引用：</strong>可在对话中引用项目中任意文件的代码作为上下文</li><li><strong>.cursorrules：</strong>项目级AI规则配置，统一团队的编码规范</li></ul><h3>价格方案</h3><p>免费版：每月2000次补全+50次慢速预测；Pro版：$20/月，无限次使用+优先速度；Business版：$40/月，管理员配置权限。</p><h3>适用场景</h3><p>日常代码开发、新项目搭建、代码重构、Bug修复、代码审查、技术栈学习、快速原型开发等所有编程场景。</p>',
'https://cursor.sh', NULL, 'AI写代码,Cursor,IDE,AI编程,VS Code,代码补全,副驾驶', 0, 4.8, 0),

(2, 'GitHub Copilot', 'https://github.githubassets.com/favicons/favicon.svg',
'GitHub与OpenAI联合推出的AI编程助手，支持多种IDE，可根据注释和上下文自动生成代码，开发者必备工具。',
'<p>GitHub Copilot是GitHub和OpenAI联合开发的AI结对编程助手，被数百万开发者广泛使用。</p><h3>核心能力</h3><ul><li><strong>代码补全：</strong>根据当前上下文和注释，实时建议完整的代码片段</li><li><strong>多语言支持：</strong>支持Python、JavaScript、TypeScript、Java、Go、Rust等数十种语言</li><li><strong>多IDE适配：</strong>VS Code、JetBrains IDEs、Visual Studio、Neovim等主流编辑器</li><li><strong>聊天模式：</strong>Copilot Chat可与AI对话，提问代码问题、生成单元测试、解释代码</li><li><strong>Copilot Enterprise：</strong>企业版可学习组织内部代码库，提供定制化建议</li></ul><h3>价格方案</h3><p>个人版：$10/月 或 $100/年；学生和热门开源项目维护者可免费使用；Business版：$19/月/人；Enterprise版：$39/月/人。</p><h3>适用场景</h3><p>全栈Web开发、移动应用开发、数据科学脚本、DevOps自动化、API接口开发、单元测试编写等所有软件开发场景。</p>',
'https://github.com/features/copilot', NULL, 'AI写代码,GitHub Copilot,OpenAI,结对编程,代码生成,IDE插件', 0, 4.7, 0),

(9, 'Vercel', 'https://vercel.com/favicon.ico',
'全球领先的前端云平台，支持一键部署Next.js/Nuxt/Vite等项目，提供边缘计算、Serverless Functions和无尽的速度。',
'<p>Vercel是Next.js背后的公司打造的前端云平台，为现代Web应用提供极致的开发和部署体验。</p><h3>核心功能</h3><ul><li><strong>零配置部署：</strong>连接Git仓库即可自动部署，推送即上线</li><li><strong>边缘网络：</strong>全球300+边缘节点，自动将用户路由到最近的节点</li><li><strong>Serverless Functions：</strong>无服务器函数，按需运行，自动扩缩容</li><li><strong>预览部署：</strong>每个PR自动生成预览链接，团队评审无需本地跑起来</li><li><strong>极速CDN：</strong>静态资源全球加速，首屏加载速度极快</li><li><strong>Analytics：</strong>内置Web Analytics，无需第三方追踪脚本</li></ul><h3>免费额度</h3><p>Hobby免费版：100GB带宽、Serverless Function 100GB-Hrs/月、无限静态站点、无限团队人数。对个人开发者和小项目非常友好。</p><h3>适用场景</h3><p>Next.js项目部署、前端静态站托管、Serverless API、全栈应用、个人博客、SaaS产品前端等现代Web项目。</p>',
'https://vercel.com', NULL, 'AI部署,Vercel,前端部署,Next.js,Serverless,CDN,边缘计算', 1, 4.6, 0),

(9, 'Zeabur', 'https://zeabur.com/favicon.ico',
'新一代一站式部署平台，国内访问友好，支持Docker/Nginx/数据库等各类服务的一键部署和管理。',
'<p>Zeabur是一站式应用部署平台，特别适合国内开发者使用，解决了Vercel等国外平台在国内访问不稳定的问题。</p><h3>核心功能</h3><ul><li><strong>一键部署：</strong>支持GitHub/GitLab仓库连接，自动检测技术栈并部署</li><li><strong>Docker容器：</strong>支持Dockerfile和预构建镜像部署</li><li><strong>数据库服务：</strong>内置MySQL、PostgreSQL、MongoDB、Redis等数据库一键开通</li><li><strong>国内加速：</strong>国内节点部署，访问速度快且稳定</li><li><strong>域名绑定：</strong>支持自定义域名绑定和自动HTTPS证书</li><li><strong>环境变量：</strong>可视化管理环境变量，敏感信息加密存储</li><li><strong>日志监控：</strong>实时日志查看和应用状态监控</li></ul><h3>价格方案</h3><p>免费版：足够个人项目和小型应用使用；Pro版：解锁更多资源和高级功能。对学生和开源项目有优惠政策。</p><h3>适用场景</h3><p>Spring Boot项目部署、前后端分离项目、全栈Web应用、个人博客/网站、课程作业/毕设项目部署、微信小程序后端等需要稳定国内访问的项目。</p>',
'https://zeabur.com', NULL, 'AI部署,Zeabur,一键部署,Docker,国内部署,数据库,容器化', 1, 4.5, 0);

INSERT INTO prompt_category (name, description, sort) VALUES
('生图提示词', 'AI绘画提示词模板，适用于Midjourney、Stable Diffusion等工具', 1),
('PPT提示词', 'AI生成高质量PPT的提示词模板', 2),
('前端UI提示词', 'AI生成前端页面和UI组件的提示词', 3),
('后端开发提示词', 'AI辅助后端开发的提示词，涵盖框架、数据库、部署等', 4),
('论文写作提示词', 'AI辅助学术论文写作的提示词模板', 5),
('简历优化提示词', 'AI优化简历和求职材料的提示词', 6),
('短视频文案提示词', 'AI创作短视频脚本文案的提示词', 7),
('电商项目提示词', 'AI辅助电商平台开发的提示词', 8);

INSERT INTO prompt (category_id, title, content, model_type, description, usage_tips, views, likes) VALUES
(1, 'AI生图写实摄影级提示词',
'## Midjourney / Stable Diffusion 写实摄影级提示词通用模板\n\n### 基础结构公式\n```\n[主体描述] + [环境/背景] + [光影效果] + [镜头/视角] + [风格修饰] + [画质参数]\n```\n\n### 完整示例\n```\nA young Asian woman sitting by a window in a cozy coffee shop, soft natural morning light streaming through vintage curtains, wearing a cream-colored knit sweater, holding a steaming latte with latte art, warm bokeh background with bookshelves, shot on Sony A7R IV, 85mm f/1.4 lens, shallow depth of field, golden hour lighting, photorealistic, hyper detailed, 8K resolution, cinematic color grading, film grain texture --ar 3:4 --style raw --v 6.0 --s 250 --q 2\n```\n\n### 关键要素拆解\n\n**1. 主体描述（Subject）**\n- 人物：年龄、性别、种族、表情、动作、服装、姿态\n- 物体：材质、颜色、形状、大小、状态\n- 动作：动词要具体（leaning, gazing, reaching, whispering）\n- 示例："a focused female software engineer, late 20s, wearing glasses and a dark blue hoodie"\n\n**2. 环境/背景（Environment）**\n- 室内：cozy apartment, modern office, rustic kitchen, minimalist studio\n- 户外：cherry blossom park, bustling Tokyo street, serene mountain lake, rainy London alley\n- 具体元素：添加具体物品增加画面层次\n- 示例："surrounded by dual monitors showing code, warm desk lamp illuminating scattered notes"\n\n**3. 光影效果（Lighting）**\n- 自然光：golden hour, blue hour, soft overcast light, dappled sunlight through leaves\n- 人造光：neon city lights, warm tungsten lamp, dramatic rim lighting, volumetric lighting\n- 摄影布光：Rembrandt lighting, butterfly lighting, three-point lighting\n- 示例："dramatic side lighting creating strong shadows, subtle rim light on hair outline"\n\n**4. 镜头/视角（Camera & Lens）**\n- 焦距：24mm广角、35mm街拍、50mm标准、85mm人像、135mm压缩\n- 光圈：f/1.2极致虚化、f/2.8柔和虚化、f/8风景清晰\n- 视角：eye level平视、low angle仰视、bird\'s eye俯视、Dutch angle倾斜\n- 示例："shot on Canon EOS R5, 85mm f/1.2 L lens, eye level perspective"\n\n**5. 风格修饰（Style Modifiers）**\n- 画质词：photorealistic, hyperrealistic, ultra detailed, sharp focus, 8K UHD\n- 风格词：cinematic, editorial, fine art photography, National Geographic style\n- 胶片模拟：Kodak Portra 400, Fujifilm Velvia, Cinestill 800T look\n- 后期调色：teal and orange, moody desaturated, vibrant saturated\n\n**6. Midjourney 参数**\n- `--ar 16:9` / `--ar 3:4` / `--ar 1:1` 控制宽高比\n- `--s 0~1000` 风格化强度（越高越艺术）\n- `--v 6.0` 使用V6模型\n- `--style raw` 减少MJ自带的艺术化处理\n- `--q 2` 最高质量\n- `--chaos 0~100` 变化程度\n\n### Stable Diffusion 专用补充\n- 使用 `(keyword:1.3)` 语法强调关键词权重\n- 负向提示词必须填写：low quality, blurry, deformed hands, extra fingers\n- 推荐checkpoint：Realistic Vision, MajicMix Realistic, XXMix_9realistic\n- 配合ControlNet使用参考图时效果更佳\n\n### 常见题材速查\n\n**人像摄影：**\nportrait photography, professional headshot, natural makeup, confident expression, catchlights in eyes\n\n**风景摄影：**\nlandscape photography, leading lines, atmospheric perspective, dramatic sky, long exposure water\n\n**产品摄影：**\nproduct photography, clean white background, soft box lighting, reflections on surface, commercial advertising style\n\n**街头摄影：**\nstreet photography, candid moment, urban geometry, decisive moment, black and white or selective color\n\n---\n\n💡 **使用建议：** 先用英文写好提示词，逐步添加元素观察效果变化。保存效果好的提示词作为模板复用。每次只调整1-2个变量来学习各参数的影响。',
'Midjourney/Stable Diffusion', '一套完整的AI写实摄影级图像生成提示词模板，包含公式、示例、各要素详解、参数说明和常见题材速查表。适用于Midjourney V6和Stable Diffusion。', '1. 先确定主体和环境这两个核心要素\n2. 根据需要的风格选择合适的光影描述\n3. 镜头参数根据构图需求调整\n4. Midjourney建议加--style raw获得更真实的效果\n5. SD务必填写负向提示词避免畸形\n6. 多生成几张选最好的，不要期望一次完美', 0, 0),

(2, 'PPT高级感设计提示词',
'## AI生成高级感PPT的完整提示词模板\n\n### 🎯 角色设定\n```\n你是一位拥有15年经验的资深PPT设计顾问，曾服务于世界500强企业的品牌展示和融资路演项目。\n你精通Mckinsey、BCG级别的咨询公司PPT规范，熟悉Apple、Google发布会幻灯片的视觉语言。\n请按照以下要求为我设计一份专业的PPT大纲和每页详细设计方案。\n```\n\n### 📋 项目信息收集（请先提供）\n- **PPT主题：** [例如：2024年度Q4业务汇报 / A轮融资路演 / 产品发布会]\n- **目标受众：** [例如：公司高管层 / 投资人 / 行业客户 / 学术评委]\n- **页数要求：** [例如：15-20页]\n- **设计风格偏好：** [商务简约 / 科技感 / 学术严谨 / 创意活泼]\n- **核心数据/内容：** [列出关键数据和要点]\n\n---\n\n### 🏗️ 完整PPT结构模板（以项目汇报为例）\n\n#### 第1页：封面页\n- **标题：** 主标题 + 副标题，字号对比明显\n- **布局：** 大面积留白 + 右下角或底部装饰性图形元素\n- **配色：** 品牌主色渐变背景或纯色+几何图形点缀\n- **字体：** 标题用粗黑体/思源黑体 Heavy，正文用常规体\n- **元素：** 可加入抽象的线条、色块、品牌Logo水印\n\n#### 第2页：目录页\n- **布局：** 左侧竖排目录 + 右侧大面积留白/配图\n- **编号：** 用大号数字01/02/03...配合简短标题\n- **动效建议：** 点击依次淡入，不要自动播放\n\n#### 第3页：项目概述\n- **核心原则：** 一页只讲一个核心观点\n- **布局建议：** 上方标题区30% + 中间核心内容区50% + 底部支撑信息20%\n- **可视化：** 用时间轴展示项目里程碑\n- **关键数据：** 用大号数字卡片突出核心指标\n\n#### 第4-N页：核心内容页（每页遵循以下规范）\n\n**📐 页面黄金法则：**\n```\n┌─────────────────────────────────┐\n│  标题区（页面结论/观点）       │  ← 15%高度\n├─────────────────────────────────┤\n│                                 │\n│  主内容区（论据/图表/可视化）   │  ← 70%高度\n│                                 │\n├─────────────────────────────────┤\n│  来源/注释/页码                  │  ← 15%高度\n└─────────────────────────────────┘\n```\n\n**📊 数据展示规范：**\n- 趋势数据 → 折线图/面积图（带数据标签）\n- 占比数据 → 环形图（不用饼图，更现代）\n- 对比数据 → 条形图（横向，便于读类别名）\n- 构成数据 → 堆叠柱状图/瀑布图\n- 单一关键数字 → 大字卡片 + 趋势箭头 + 对比数据\n\n**🎨 配色方案推荐：**\n\n| 风格 | 主色 | 辅助色 | 强调色 | 背景 |\n|------|------|--------|--------|------|\n| 商务蓝 | #1E3A5F | #4A90D9 | #FF6B35 | #F8FAFC |\n| 科技紫 | #0F0C29 | #302B63 | #A259FF | #0D0D0D |\n| 自然绿 | #1B4332 | #52B788 | #F4A261 | #FAFDFA |\n| 学术红 | #9D0208 | #E85D04 | #FFBA08 | #FEFEFE |\n\n**✍️ 文字排版规范：**\n- 标题字号：28-36pt，字重Bold/Heavy\n- 正文字号：14-18pt，行距1.5-1.8倍\n- 注释字号：10-12pt，灰色(#6B7280)\n- 每行不超过25个中文字\n- 每页文字不超过40个字的核心内容\n\n#### 倒数第2页：总结与下一步\n- **布局：** 三列式或时间轴式\n- **内容：** 核心成果回顾(3点) + 下一步计划(3点) + 所需资源\n- **视觉：** 用勾选图标✅表示已完成，用→箭头表示待办\n\n#### 最后1页：结束页\n- **内容：** Thank You / Q&A / 联系方式\n- **设计：** 与封面呼应，简洁大气\n- **可选：** 二维码（微信号/邮箱/官网）\n\n---\n\n### 🔧 给AI的具体指令（复制使用）\n\n```\n请帮我设计一份【{主题}】的PPT，具体要求如下：\n\n1. 目标受众：{受众}\n2. 总页数：{N}页\n3. 设计风格：{风格描述}\n4. 核心内容包括：{列出要点}\n5. 请输出：\n   - 完整的页面大纲（每页标题+核心内容要点）\n   - 每页的布局建议（文字/图表/图片的位置安排）\n   - 推荐的配色方案（具体色值）\n   - 每页的关键话术（演讲者说什么）\n   - 图表类型建议和数据可视化方案\n\n注意事项：\n- 每页遵循"一个核心观点"原则\n- 提供具体的配色色值（HEX格式）\n- 数据页必须说明用什么类型的图表\n- 给出演讲备注（Speaker Notes）\n```\n\n---\n\n💡 **使用建议：** \n1. 先让AI输出大纲，确认结构后再逐页细化\n2. 要求AI给出具体的色值而不是模糊的"蓝色""红色"\n3. 让AI帮你写每页的演讲备注，比光做PPT更有价值\n4. 用Gamma/Beautiful.ai/Tome等AI PPT工具可以快速生成初稿',
'GPT/Claude/Gemini', '一套完整的AI辅助PPT设计提示词模板，包含角色设定、结构模板、排版规范、配色方案、图表选用指南和可直接复制使用的指令模板。', '1. 先明确PPT的目的和受众，这决定了整体风格\n2. 让AI先出大纲再细化，不要一步到位\n3. 每页坚持"一个核心观点"原则\n4. 数据一定要可视化，纯文字没人看\n5. 配色不超过3种主色+1种强调色\n6. 演讲备注比幻灯片本身更重要', 0, 0),

(3, '前端UI页面生成提示词',
'## AI生成前端UI页面的完整Prompt模板\n\n### 🎯 角色与约束设定\n```\n你是一名资深前端工程师兼UI设计师，精通Vue3/React/Tailwind CSS/Framer Motion。\n你需要根据我的描述生成完整的前端页面代码。\n\n技术栈要求：\n- 框架：Vue 3 Composition API + <script setup>\n- 样式：Tailwind CSS 3.x\n- 动画：CSS transitions + 少量JS动画\n- 图标：Lucide Icons 或 Heroicons\n- 响应式：必须支持 mobile(375px) / tablet(768px) / desktop(1280px)\n\n代码规范：\n- 使用语义化HTML标签\n- 组件化拆分，单文件组件\n- 颜色用CSS变量定义在:root中\n- 不使用任何外部依赖除非我明确指定\n- 图片使用 picsum.photos 或 unsplash 占位图\n```\n\n---\n\n### 📦 页面生成万能模板\n\n```\n请为我生成一个【{页面名称}】的完整Vue3单文件组件。\n\n## 页面基本信息\n- 页面用途：{描述这个页面是做什么的}\n- 目标用户：{谁会用这个页面}\n- 设计风格：{如：现代简约/科技感/温暖亲和/学术严谨}\n- 参考网站/竞品：{可选，给AI参考方向}\n\n## 页面结构要求\n\n### Header导航栏\n- Logo + 站点名称\n- 导航菜单：{列出菜单项}\n- 右侧操作区：{搜索/登录/购物车等}\n- 滚动时需固定顶部(sticky)，加阴影效果\n\n### Hero/Banner区域（首页必填）\n- 大标题：{主标语}\n- 副标题：{补充说明}\n- CTA按钮：{按钮文字和目标}\n- 背景处理：{渐变色/大图/抽象图案}\n\n### 主内容区\n- 布局方式：{单栏/双栏(侧边栏+内容)/三栏/网格}\n- 内容模块：{逐一描述每个模块}\n- 卡片样式：{圆角/阴影/悬浮效果}\n\n### Footer页脚\n- 多列布局：关于我们/快速链接/联系方式/版权信息\n- 底部版权栏\n\n## 设计规范\n\n### 配色方案\n- 主色调(primary)：{#hex值} - 用于按钮、链接、重点\n- 辅助色(secondary)：{#hex值} - 用于次要元素\n- 背景色(background)：{#hex值}\n- 表面色(surface)：{#hex值} - 卡片/容器背景\n- 文字色(text)：{主文字#hex / 次文字#hex}\n- 边框色(border)：{#hex值}\n\n### 字体规范\n- 标题字体：{Inter/PingFang SC/...}\n- 正文字体：{同上或其他}\n- 标题字重：700(Bold)\n- 正文字重：400(Regular)\n- 基础字号：16px\n\n### 圆角与阴影\n- 小圆角(sm)：4px - 按钮/输入框/标签\n- 中圆角(md)：8px - 卡片/弹窗\n- 大圆角(lg)：16px - 大卡片/图片容器\n- 卡片阴影：0 1px 3px rgba(0,0,0,0.1), 0 1px 2px rgba(0,0,0,0.06)\n- 悬浮阴影：0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05)\n\n### 间距系统\n- 基于4px网格：4/8/12/16/24/32/48/64px\n- section间距：64-80px\n- card内边距：24px\n- 元素间距：16px\n\n## 交互要求\n- 导航菜单hover效果\n- 按钮hover状态变化\n- 卡片hover上浮动画(translateY -4px)\n- 平滑滚动(scroll-behavior: smooth)\n- 移动端汉堡菜单\n\n## 响应式断点\n- Mobile (<640px): 单列布局，隐藏次要信息\n- Tablet (640-1024px): 双列布局\n- Desktop (>1024px): 完整布局\n\n请输出完整的.vue单文件组件代码，包含<template>、<script setup>和<style scoped>三个部分。\n代码要有适当的注释说明每个区域的作用。\n```\n\n---\n\n### 🎨 常用UI模块快捷指令\n\n**导航栏Navbar：**\n```\n生成一个现代化的固定顶部导航栏组件，包含：左侧Logo+品牌名、中间导航链接(首页/产品/关于/联系)、右侧搜索图标+用户头像下拉菜单。移动端显示汉堡菜单按钮，点击展开侧滑抽屉。滚动超过50px后添加背景模糊和阴影效果。使用Tailwind CSS。\n```\n\n**Hero Banner：**\n```\n生成一个全宽Hero区域，包含：左侧大标题(48px bold)+副标题(18px gray)+两个CTA按钮(主色填充+描边)、右侧放置一张640x480的产品展示图(picsum.photos)。背景用浅灰到白色的渐变。添加浮动的装饰性几何元素(圆形/方块)。响应式：移动端改为垂直居中布局。\n```\n\n**卡片网格Grid：**\n```\n生成一个响应式卡片网格区域，桌面端3列、平板2列、手机1列。每张卡片包含：顶部图片(16:9比例，object-fit cover，圆角顶部)、中间标题+描述文字(2行截断)、底部标签+更多链接。卡片hover时有上浮+阴影加深动画。使用picsum.photos的不同seed作为图片源。\n```\n\n**数据统计Stats：**\n```\n生成一行4个统计数据展示组件，每个包含：大号数字(48px bold，渐变色)+标签文字(16px gray)+上升趋势图标(green)。下方有一条细线分隔。数字可以用渐变色(text-transparent bg-clip-text bg-gradient-to-r)。响应式：手机端变为2x2网格。\n```\n\n**定价 Pricing：**\n```\n生成三列定价卡片，左普通/中推荐(突出显示，放大1.05倍，带"最受欢迎"角标)/右普通。每张卡包含：方案名称/月价/年价(划线)/功能列表(勾选图标)/CTA按钮。推荐卡的边框用主色加粗。使用Tailwind的group-hover效果。\n```\n\n**页脚Footer：**\n```\n生成深色系页脚，分4列：公司简介+产品链接+支持链接+订阅输入框。底部有分割线和版权信息+社交图标链接。响应式：移动端堆叠为单列。\n```\n\n---\n\n### ⚡ Vercel v0 专用指令\n\n如果你在使用 **Vercel v0** 生成UI，使用以下精简指令：\n\n```\nBuild a {页面类型} page for a {产品类型} website.\nStyle: {风格描述}, colors: {主色} primary.\nSections: nav, hero with CTA, {功能模块}, footer.\nResponsive: mobile-first approach.\nUse Tailwind CSS, shadcn/ui components.\nInclude hover animations and micro-interactions.\n```\n\n---\n\n💡 **使用建议：**\n1. 先描述整体布局再细化每个模块\n2. 给出参考网站截图或URL效果最好\n3. 明确指定技术栈，否则AI可能用你不熟悉的框架\n4. 颜色一定要给具体HEX值\n5. 先生成框架再逐步填充内容\n6. 用v0/ bolt.new等工具可以实时预览和迭代',
'GPT/Claude/Vercel v0', '一套完整的前端UI页面AI生成提示词模板，包含角色设定、万能页面模板、常用UI模块快捷指令、设计规范（配色/字体/间距/圆角/阴影）和v0专用指令。', '1. 必须明确指定技术栈（Vue3/React/Tailwind等）\n2. 颜色给HEX色值，不要说"好看的蓝色"\n3. 先让AI搭框架再填充细节\n4. 响应式是必须的，不是可选的\n5. 用v0/bolt.new等工具可以实时看到效果\n6. 保存好的prompt模板，换几个关键词就能复用', 0, 0),

(4, 'Spring Boot项目开发提示词',
'## Spring Boot项目AI辅助开发完整Prompt\n\n### 🎯 角色设定\n```\n你是一名拥有10年经验的Java后端架构师，精通Spring Boot/Spring Cloud/MyBatis/MySQL/Maven技术栈。\n你曾主导过多个企业级项目的后端开发，熟悉RESTful API设计、数据库设计优化、安全认证、缓存策略等。\n请严格按照以下规范帮我完成Spring Boot项目的开发任务。\n```\n\n---\n\n### 🏗️ 项目初始化 Prompt\n\n```\n请帮我搭建一个Spring Boot项目的完整骨架。\n\n## 项目信息\n- 项目名称：{artifactId}\n- Group ID：{com.example.xxx}\n- Java版本：17\n- Spring Boot版本：3.2.x\n\n## 技术栈\n- Web：Spring MVC (Spring Boot Starter Web)\n- ORM：MyBatis Plus\n- 数据库：MySQL 8.0\n- 工具：Lombok、Hutool、Knife4j(Swagger)\n- 安全：Spring Security + JWT（如果需要登录功能）\n\n## 项目结构要求\n```\ncom.example.xxx\n├── config          # 配置类\n│   ├── CorsConfig.java\n│   ├── MybatisPlusConfig.java\n│   └── SwaggerConfig.java\n├── common           # 公共模块\n│   ├── Result.java        # 统一返回结果\n│── PageResult.java     # 分页结果\n│   └── BusinessException.java  # 自定义异常\n├── entity           # 实体类\n├── mapper           # MyBatis Mapper接口\n├── service          # 服务层接口\n│   └── impl         # 服务层实现\n├── controller       # 控制器层\n├── dto              # 数据传输对象\n│   ├── request      # 请求DTO\n│   └── response     # 响应DTO\n├── utils            # 工具类\n└── XxxxApplication.java  # 启动类\n```\n\n## 请输出\n1. pom.xml完整依赖配置\n2. application.yml完整配置（含MySQL、MyBatis、端口等）\n3. 统一返回Result类的代码\n4. 全局异常处理器代码\n5. 跨域配置代码\n6. MyBatis Plus分页插件配置\n7. Swagger/Knife4j配置\n8. 各层的Base模板代码（以User模块为例）\n9. 启动类代码\n```\n\n---\n\n### 📝 单模块CRUD开发 Prompt\n\n```\n请在现有Spring Boot项目中完成【{模块名}】功能的完整后端开发。\n\n## 数据库表信息\n```sql\nCREATE TABLE {table_name} (\n    id BIGINT PRIMARY KEY AUTO_INCREMENT,\n    -- {列出所有字段}\n    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,\n    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT=\'{表注释}\';\n```\n\n## 功能需求\n\n### 基础CRUD接口\n1. **分页查询** GET /api/{module}/page\n   - 请求参数：pageNum, pageSize, {查询条件字段}\n   - 返回：分页数据列表\n\n2. **详情查询** GET /api/{module}/{id}\n   - 返回：单条详细信息\n\n3. **新增** POST /api/{module}\n   - 请求体：{字段JSON}\n   - 校验：@Valid注解校验必填项\n\n4. **修改** PUT /api/{module}\n   - 请求体：包含id的完整字段JSON\n\n5. **删除** DELETE /api/{module}/{ids}\n   - 支持批量删除，ids逗号分隔\n\n### 高级功能（按需选择）\n- [ ] 状态变更（启用/禁用）\n- [ ] 导出Excel\n- [ ] 上传文件/图片\n- [ ] 树形结构查询\n\n## 代码规范要求\n1. Controller层只做参数接收和调用Service，不写业务逻辑\n2. Service接口 + Impl实现分层\n3. Mapper继承BaseMapper<T>\n4. DTO与Entity分离，禁止Entity直接暴露给前端\n5. 使用MyBatis Plus的QueryWrapper/LambdaQueryWrapper构建条件\n6. 所有接口返回统一的Result<T>包装\n7. 分页使用Page<T>对象\n8. 关键业务操作需要日志记录\n9. 敏感操作需要记录操作日志\n\n请输出完整的代码：\n- Entity实体类（含字段注解和表名映射）\n- Request DTO（含@Valid校验注解）\n- Response VO\n- Mapper接口\n- Service接口\n- ServiceImpl实现类\n- Controller控制器（含Swagger注解）\n```\n\n---\n\n### 🔐 登录认证模块 Prompt\n\n```\n请在Spring Boot项目中实现JWT登录认证功能。\n\n## 技术方案\n- 认证框架：Spring Security\n- Token方案：JWT (jjwt库)\n- 密码加密：BCryptPasswordEncoder\n- 存储方式：Redis存储Token（可选）或无状态JWT\n\n## 需要实现的接口\n1. POST /api/auth/login - 登录\n   - 请求：{username, password}\n   - 返回：{token, userInfo}\n\n2. POST /api/auth/register - 注册\n   - 请求：{username, password, nickname, email}\n\n3. GET /api/auth/info - 获取当前用户信息\n   - Header: Authorization: Bearer {token}\n\n4. POST /api/auth/logout - 登出\n\n## 安全配置要求\n1. 白名单路径：/auth/**, /doc.html, /swagger-resources/**\n2. 其他路径都需要认证\n3. CORS跨域允许前端域名\n4. Token过期时间：7天（可配置）\n5. 支持Token刷新机制\n\n请输出：\n1. JwtUtil工具类（生成/解析/验证Token）\n2. JwtAuthenticationFilter过滤器\n3. UserDetailsServiceImpl实现\n4. SecurityConfig配置类\n5. AuthController完整代码\n6. 相关VO/DTO\n7. application.yml中的jwt配置项\n```\n\n---\n\n### 🗄️ 数据库设计辅助 Prompt\n\n```\n请根据以下业务需求设计完整的MySQL数据库方案。\n\n## 业务背景\n{描述这个系统是做什么的，有哪些角色，核心流程是什么}\n\n## 设计要求\n1. 符合第三范式(3NF)\n2. 至少8张表\n3. 覆盖一对一、一对多、多对多关系\n4. 每张表必须有：自增主键id、create_time、update_time\n5. 外键命名规范：fk_{子表}_{父表}\n6. 字段命名：下划线命名法(snake_case)\n7. 必须包含索引设计\n8. 每张表至少5条初始化数据\n\n请输出：\n1. E-R关系描述（文字版）\n2. 每张表的完整DDL语句（含注释）\n3. 表之间的关系说明\n4. 初始化数据的INSERT语句\n5. 关键索引的设计理由\n```\n\n---\n\n### 🚀 部署相关 Prompt\n\n```\n请帮我准备Spring Boot项目的生产环境部署。\n\n## 当前情况\n- 框架：Spring Boot 3.x + MyBatis Plus + MySQL\n- 前端：Vue3 (npm run build后dist目录)\n- 目标平台：Zeabur / Vercel / 阿里云ECS\n\n## 需要你提供\n1. application-prod.yml 生产环境配置\n   - 数据库连接改为环境变量读取\n   - 日志级别调整为INFO\n   - 关闭dev-tools\n\n2. Dockerfile（如果需要容器化部署）\n   - 多阶段构建减小镜像体积\n   - OpenJDK 17 JRE镜像\n\n3. docker-compose.yml（如果需要）\n   - 包含app + mysql + redis服务\n\n4. Nginx配置（前后端分离部署）\n   - API反向代理\n   - 前端静态资源\n   - Gzip压缩\n   - 缓存策略\n\n5. 部署检查清单\n   - 环境变量清单\n   - 端口开放确认\n   - 数据库迁移脚本\n   - 健康检查接口\n```\n\n---\n\n💡 **使用建议：**\n1. 把这些Prompt保存为模板，每次改几个关键字就能复用\n2. 先让AI输出设计再写代码，减少返工\n3. 数据库设计让AI先画ER图再给DDL\n4. 每个模块独立开发，最后组装\n5. 安全相关的代码一定要仔细review',
'GPT/Claude/DeepSeek/Cursor', 'Spring Boot项目全生命周期开发的AI提示词合集，涵盖项目初始化、CRUD开发、JWT认证、数据库设计和生产部署五大场景。', '1. 先确定技术栈版本，不同版本写法差异很大\n2. 数据库设计先行，表结构定了后面才顺畅\n3. 每个模块单独开发，用Prompt模板标准化\n4. Controller要薄，业务逻辑放Service\n5. 部署前一定要有prod配置文件\n6. 安全认证模块建议用现成的starter', 0, 0),

(4, '数据库设计提示词',
'## AI辅助MySQL数据库设计专业Prompt\n\n### 🎯 核心设计Prompt\n```\n你是一名资深DBA（数据库管理员），拥有15年的数据库设计和优化经验。\n你精通MySQL 8.0、Oracle、PostgreSQL等主流数据库。\n你擅长从业务需求出发，设计符合第三范式的高质量数据库方案。\n\n请根据以下业务需求，设计一套完整的MySQL数据库方案。\n\n## 业务需求\n{在此详细描述你要做的系统是什么，有哪些功能模块，哪些用户角色，核心业务流程是什么}\n\n## 设计约束\n1. **范式要求：** 所有表必须满足第三范式(3NF)\n2. **表数量：** 至少8张表\n3. **关系覆盖：** 必须包含一对一(1:1)、一对多(1:N)、多对多(N:M)三种关系\n4. **字符集：** utf8mb4，排序规则utf8mb4_general_ci\n5. **引擎：** InnoDB（支持事务和外键）\n6. **命名规范：**\n   - 表名：小写下划线_snake_case_\n   - 字段名：小写下划线_snake_case_\n   - 主键：id BIGINT AUTO_INCREMENT\n   - 外键：fk_{本表名}_{关联表名}_{字段名}\n   - 索引：idx_{表名}_{字段名}\n   - 唯一索引：uk_{表名}_{字段名}\n7. **审计字段：** 每张表必须包含 create_time 和 update_time\n8. **初始化数据：** 每张表至少5条合理的测试数据\n\n## 请按以下顺序输出\n\n### 第一部分：需求分析\n- 列出涉及的实体（名词）\n- 分析实体间的关系\n- 画出文字版的E-R关系图\n\n### 第二部分：表结构设计\n每张表输出：\n```sql\nCREATE TABLE `{表名}` (\n    -- 每个字段都要有COMMENT注释\n    -- 主键、外键、索引都要标注清楚\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT=\'{表注释}\';\n```\n\n### 第三部分：关系说明\n- 用文字描述每两张表之间的关系类型\n- 说明外键引用关系\n- 特别说明多对多的中间表设计\n\n### 第四部分：索引设计\n- 列出每张表的索引\n- 说明为什么需要这个索引（查询场景）\n- 标注哪些是联合索引\n\n### 第五部分：初始化数据\n- 每张表的INSERT语句\n- 数据之间要有关联性（外键能对应上）\n- 数据要真实合理，不要全是"测试数据"这种无意义内容\n\n### 第六部分：设计决策说明\n- 为什么这样划分表？\n- 为什么某些字段这样设计？\n- 有哪些可以优化的地方？\n```\n\n---\n\n### 🔄 从旧设计优化的Prompt\n\n```\n请审查并优化以下MySQL数据库设计方案。\n\n## 当前表结构\n{粘贴现有的SQL建表语句}\n\n## 存在的问题（已知的）\n{列出你已经发现的问题，如果没有就让AI自己找}\n\n## 优化要求\n1. 检查是否满足第三范式，如果不满足请指出并修正\n2. 检查字段类型是否合理（如VARCHAR长度是否合适）\n3. 检查是否缺少必要的索引\n4. 检查外键关系是否正确\n5. 检查是否有冗余字段\n6. 评估查询性能瓶颈并提出优化建议\n7. 检查是否缺少审计字段\n8. 建议添加哪些查询常用的视图(View)\n\n请输出：\n1. 问题清单（按严重程度排序）\n2. 优化后的完整DDL语句\n3. 数据迁移SQL（如果有结构性改动）\n4. 优化前后的对比说明\n```\n\n---\n\n### 📊 特定场景模板\n\n**电商系统数据库：**\n```\n设计一个电商平台的数据库，包含：商品管理、订单管理、用户系统、购物车、支付、评价、优惠券、搜索等功能。\n至少12张表。需要考虑：SKU/SPU设计、库存扣减、订单状态机、退款流程、优惠券使用规则。\n重点关注并发场景下的数据一致性设计。\n```\n\n**内容管理系统(CMS)：**\n```\n设计一个CMS内容管理系统的数据库，包含：文章管理、分类标签、评论系统、用户权限、媒体库、菜单管理、SEO设置。\n需要支持：文章多分类、标签系统、嵌套评论、富文本内容、草稿/发布状态、定时发布。\n```\n\n**在线教育平台：**\n```\n设计一个在线教育平台的数据库，包含：课程管理、章节课时、视频资源、学员报名、学习进度、作业考试、证书、讲师管理、支付订单。\n需要考虑：课程目录树形结构、视频播放记录、作业批改流程、学习进度百分比计算。\n```\n\n**医院管理系统：**\n```\n设计一个医院管理系统的数据库，包含：患者管理、医生排班、挂号预约、就诊记录、处方药品、检查检验、住院管理、费用结算。\n需要考虑：患者隐私保护、医嘱执行流程、药品库存管理、医保结算对接。\n注意数据安全和合规性要求。\n```\n\n---\n\n💡 **使用建议：**\n1. 业务需求描述越详细，数据库设计越准确\n2. 先让AI分析实体和关系，再出DDL\n3. 特别关注多对多关系的中间表设计\n4. 索引不是越多越好，按查询需求设计\n5. 初始化数据要有关联性，方便测试联表查询\n6. 拿到方案后自己在Navicat里跑一遍验证',
'GPT/Claude', '专业的MySQL数据库设计AI提示词，包含完整设计流程、范式检查、优化审查和常见业务场景模板（电商/CMS/教育/医疗）。', '1. 业务需求写得越详细，出来的设计越好\n2. 一定要让AI先分析实体和关系再建表\n3. 多对多关系最容易出错，重点检查中间表\n4. 索引按实际查询场景设计，不要过度索引\n5. 初始化数据要能关联上，方便测联表查询\n6. 在Navicat里跑一遍验证外键关系是否正确', 0, 0),

(5, '学术论文写作提示词',
'## AI辅助学术论文写作完整Prompt体系\n\n### 🎯 核心角色设定\n```\n你是一位学术写作专家，具有博士学位，发表过20+篇SCI/EI/核心期刊论文。\n你精通计算机领域的学术写作规范，熟悉IEEE/ACM/国内核心期刊的论文格式要求。\n你能帮助学生和研究者完成从选题到投稿的全流程学术写作指导。\n\n重要约束：\n- 你提供的思路和框架供参考，核心创新点和实验数据必须是作者自己的\n- 引用的文献需要作者自行验证真实性\n- 不得代写涉及抄袭的内容\n- 代码和技术实现可以协助，但理论创新必须是原创的\n```\n\n---\n\n### 📝 论文各章节写作Prompt\n\n#### 第一章：绪论/引言\n```\n请帮我撰写计算机类本科毕业论文的【第一章 绪论】。\n\n## 论文题目\n{你的论文题目}\n\n## 论文基本信息\n- 专业：计算机科学与技术\n- 类型：本科毕业论文\n- 字数要求：绪论部分约3000字\n\n## 绪论需要包含的内容\n\n### 1.1 研究背景与意义（约800字）\n- 从宏观到微观：行业发展 → 技术趋势 → 具体问题\n- 国内外现状对比（引用近3-5年的数据和报告）\n- 研究的理论意义和实践意义\n\n### 1.2 国内外研究现状（约1200字）\n- 国内研究现状（至少引用5篇中文文献）\n- 国外研究现状（至少引用5篇英文文献）\n- 研究现状评述（指出已有研究的不足）\n- 用表格形式对比主要方法的优劣\n\n### 1.3 研究内容与方法（约600字）\n- 本文的主要研究内容（分点列出，3-5点）\n- 采用的研究方法（文献研究法/实验法/对比分析法等）\n- 技术路线（用文字描述，后续我会画流程图）\n\n### 1.4 论文组织结构（约400字）\n- 介绍各章节的主要内容安排\n\n## 写作要求\n- 语言风格：学术正式，客观严谨\n- 逻辑结构：层层递进，因果关系清晰\n- 避免口语化和主观表述\n- 适当使用过渡句连接各段落\n- 引用格式：(作者, 年份) 或 [编号]\n\n请输出完整的绪论章节正文。\n```\n\n#### 第二章：相关技术介绍\n```\n请帮我撰写论文的【第二章 相关技术介绍】。\n\n## 论文题目\n{题目}\n\n## 本章需要介绍的技术\n1. {技术1名称} - 在本项目中的应用场景\n2. {技术2名称} - 在本项目中的应用场景\n3. {技术3名称} - 在本项目中的应用场景\n...\n\n## 每个技术的介绍结构\n### X.X {技术名称}\n\n#### X.X.1 概述（200-300字）\n- 什么是这个技术/框架\n- 由谁开发、何时发布、当前版本\n- 核心定位和设计理念\n\n#### X.X.2 核心原理/架构（400-500字）\n- 技术架构图（用文字描述，后续画图）\n- 核心组件及其职责\n- 工作原理/运行机制\n- 关键概念解释\n\n#### X.X.3 关键特性（200-300字）\n- 列出5-8个核心特性\n- 每个特性用一句话说明\n\n#### X.X.4 技术选型理由（150-200字）\n- 为什么在本项目中选择该技术\n- 与同类技术的对比优势\n- 与本项目的契合度分析\n\n## 写作要求\n- 技术介绍要深入浅出，既专业又易懂\n- 结合本项目实际应用场景来写，不要泛泛而谈\n- 可以加入架构图/流程图的文字描述（占位符）\n- 引用官方文档和技术博客作为参考来源\n- 章末有小结，说明本章技术与后续实现的关联\n```\n\n#### 第三章：系统需求分析与设计\n```\n请帮我撰写论文的【第三章 系统需求分析与设计】。\n\n## 论文题目\n{题目}\n\n## 3.1 需求分析\n### 3.1.1 功能性需求\n- 列出系统的所有功能模块\n- 每个功能模块的详细描述\n- 用表格形式：功能编号、功能名称、功能描述、优先级\n\n### 3.1.2 非功能性需求\n- 性能需求（响应时间、并发用户数）\n- 安全需求（认证授权、数据加密）\n- 可用性需求（正常运行时间）\n- 兼容性需求（浏览器、分辨率）\n\n### 3.1.3 用例分析\n- 识别系统角色（Actor）\n- 每个角色的用例列表\n- 核心用例的文字描述（用例名称、参与者、前置条件、基本事件流、后置条件）\n\n## 3.2 系统设计\n### 3.2.1 系统架构设计\n- 整体架构（B/S架构、前后端分离等）\n- 技术选型及理由（前端/后端/数据库/部署）\n- 架构图文字描述\n\n### 3.2.2 功能结构设计\n- 系统功能模块树状结构\n- 各模块的子功能分解\n\n### 3.2.3 数据库设计\n- E-R图设计（实体、属性、关系描述）\n- 数据库表结构（每张表的字段说明）\n- 数据字典\n\n### 3.2.4 接口设计\n- RESTful API接口列表\n- 接口规范（请求/响应格式）\n\n请输出完整的第三章内容，包含所有图表的文字描述。\n```\n\n---\n\n### ✨ 论文润色与降重Prompt\n\n```\n请对我以下的学术论文段落进行润色和优化。\n\n## 原文\n{粘贴需要润色的段落}\n\n## 润色要求\n1. **学术化提升：** 将口语化表达改为学术用语\n2. **逻辑优化：** 调整句子和段落的逻辑顺序\n3. **精炼表达：** 去除冗余词汇，提高信息密度\n4. **语法修正：** 修正语法错误和不规范表达\n5. **主动变被动：** 适当使用被动语态增强客观性\n6. **增加衔接：** 添加过渡词和衔接句\n\n## 注意事项\n- 保持原文的核心意思不变\n- 不能引入原文没有的信息\n- 适当增加专业术语的使用\n- 保持与全文风格一致\n\n## 输出格式\n- 【修改后正文】：润色后的完整段落\n- 【修改说明】：逐条说明做了哪些修改以及原因\n```\n\n---\n\n### 📚 文献检索与管理Prompt\n\n```\n请帮我制定【{研究主题}】的文献调研计划。\n\n## 研究主题\n{你的研究方向或论文题目}\n\n## 需要输出的内容\n\n### 1. 检索关键词（中英文）\n- 中文关键词组合（用于知网、万方）\n- 英文关键词组合（用于IEEE Xplore、ACM DL、Google Scholar）\n- 同义词和相关词扩展\n\n### 2. 推荐检索的数据库\n- 中文数据库：CNKI知网、万方、维普\n- 英文数据库：IEEE Xplore、ACM DL、Springer、Elsevier ScienceDirect\n- 预印本：arXiv\n\n### 3. 文献筛选标准\n- 时间范围：近5年（2020-2025）为主，经典文献不限\n- 质量：核心期刊、EI/SCI收录、顶会论文\n- 相关度：与本研究主题高度相关\n- 数量：中文10-15篇，英文10-15篇\n\n### 4. 文献分类框架\n请提供一个文献分类表格模板，包含：\n- 分类维度（按技术方法/按应用场景/按年份等）\n- 每篇文献的核心贡献\n- 与本研究的关联点\n- 可借鉴的方法或思路\n\n### 5. 文献综述写作建议\n- 如何组织文献综述的结构\n- 如何避免简单的罗列堆砌\n- 如何找出研究空白(Gap)\n```\n\n---\n\n💡 **使用建议：**\n1. 绪论最重要，花最多时间打磨\n2. 技术介绍章节要结合自己的项目来写\n3. 每一章写之前先给AI你的论文提纲\n4. 润色时分段落进行，不要一次丢太多\n5. 文献一定要自己去查，AI给的参考文献可能是编的\n6. 代码和实现可以让AI帮忙，但创新思想要是自己的',
'GPT/Claude/Kimi/Qwen', '完整的学术论文AI辅助写作提示词体系，涵盖绪论、技术介绍、需求分析、系统设计各章节的写作模板，以及润色降重和文献管理方法。', '1. 先写好论文提纲再逐章展开\n2. 绪论最重要，决定论文的第一印象\n3. 技术介绍要结合自己的项目来写\n4. AI写的文献可能是假的，一定要自己核实\n5. 代码可以让AI帮忙，但创新思想必须是自己的\n6. 分段落润色，不要一次丢太多内容', 0, 0),

(6, '简历优化提示词',
'## AI简历优化专业Prompt\n\n### 🎯 核心优化Prompt\n```\n你是一位资深职业咨询师和简历专家，曾帮助500+求职者成功进入BAT、TMD等互联网大厂。\n你精通互联网行业的招聘标准和HR筛选简历的逻辑。\n请对我的简历进行全面优化。\n\n## 我的原始简历信息\n\n### 基本信息\n- 姓名：{姓名}\n- 学历：{学校} {专业} {学历} {预计毕业时间}\n- 电话：{电话}\n- 邮箱：{邮箱}\n- GitHub：{链接}\n- 博客：{链接}\n\n### 求职目标\n- 目标岗位：{如：Java后端开发工程师 / 前端开发工程师}\n- 目标公司类型：{如：互联网大厂 / 初创公司 / 外企}\n- 目标城市：{城市}\n\n### 教育/项目经历\n{粘贴你目前的经历描述}\n\n## 优化要求\n\n### 1. 自我评价/个人优势（重新撰写）\n- 3-4条核心优势\n- 每条要有具体的技术关键词\n- 用数据或成果量化能力\n- 避免空话套话（如"吃苦耐劳"、"学习能力强"）\n\n### 2. 项目经历优化（STAR法则）\n对每个项目按照STAR法则重写：\n- **S (Situation) 情境：** 项目背景、规模、团队人数\n- **T (Task) 任务：** 你的职责范围、承担的角色\n- **A (Action) 行动：** 你具体做了什么（用技术术语）\n- **R (Result) 结果：** 取得了什么成果（用量化数据）\n\n### 3. 技能关键词优化\n- 将技能分为"熟练掌握"/"熟悉"/"了解"三级\n- 匹配目标岗位JD的关键词\n- 加入当前市场热门的技术栈\n- 去除过时或不相关的技能\n\n### 4. 简历结构与排版建议\n- 最优的模块排列顺序\n- 每个部分的篇幅占比\n- 应该突出的亮点\n- 需要删除或弱化的内容\n\n### 5. 针对性优化\n根据以下目标岗位JD进行关键词匹配：\n{粘贴目标公司的职位描述JD}\n\n## 输出格式\n1. 优化后的完整简历（可直接复制使用）\n2. 修改对照表（原文 vs 优化后 + 修改原因）\n3. 针对该岗位的面试可能问到的问题预测\n4. 还需要补充的能力或经历建议\n```\n\n---\n\n### 💼 不同岗位专项优化\n\n**Java后端开发岗：**\n```\n请针对Java后端开发工程师岗位优化我的简历。\n\n目标公司层级：{大厂/中厂/初创}\n\n重点突出：\n1. Spring Boot/Spring Cloud实际项目经验\n2. MySQL数据库设计和优化经验\n3. Redis缓存使用经验\n4. 分布式/微服务相关经验（如有）\n5. 高并发场景处理经验（如有）\n6. 开源项目或技术博客（如有）\n\n技术关键词必须包含：\nSpring Boot, MyBatis, MySQL, Redis, Maven, Git, Linux, RESTful API, JWT\n\n项目描述要用到这些动词：\n设计并实现、搭建、优化、重构、集成、封装、解决、提升\n\n量化指标参考：\n- QPS从X提升到Y\n- 接口响应时间降低X%\n- 数据库查询优化X倍\n- 支撑X万用户并发\n- 代码覆盖率X%\n- 系统可用性达到X%\n```\n\n**前端开发岗：**\n```\n请针对前端开发工程师岗位优化我的简历。\n\n重点突出：\n1. Vue3/React实际项目经验\n2. 组件化开发和工程化实践\n3. 性能优化经验（首屏加载、渲染优化）\n4. 移动端适配/H5开发经验\n5. TypeScript使用经验\n6. UI/UX sense（如有设计作品）\n\n技术关键词：\nVue3, React, TypeScript, Tailwind CSS, Vite, Pinia/Redux, Axios, Element Plus/Ant Design, ECharts, Git\n\n项目描述重点：\n- 负责了哪些模块/页面的开发\n- 解决了什么技术难点\n- 做了哪些性能优化\n- 组件复用率和封装情况\n- 与后端的协作方式\n```\n\n---\n\n### 📧 求职信/自我介绍Prompt\n\n```\n请帮我写一封求职信/邮件自我介绍。\n\n## 基本信息\n- 应聘岗位：{岗位名}\n- 公司名称：{公司名}\n- 我的背景：{简要背景}\n\n## 求职信要求\n1. 开头：表明应聘意向和信息来源\n2. 第一段：我是谁，核心竞争力是什么\n3. 第二段：与岗位最匹配的1-2个项目经历\n4. 第三段：为什么选择这家公司（表现出做过功课）\n5. 结尾：表达面试期待和联系方式\n\n风格要求：\n- 自信但不自负\n- 简洁有力，控制在300字以内\n- 有记忆点，让HR能记住你\n- 避免模板化，体现个性化\n\n同时请生成一个1分钟口头自我介绍的版本（用于面试开场）。\n```\n\n---\n\n### ❓ 面试准备Prompt\n\n```\n请根据我的简历和目标岗位，预测面试可能问到的问题并给出参考答案。\n\n## 我的简历（优化后的版本）\n{粘贴优化后的简历}\n\n## 目标岗位\n{岗位名} @ {公司名}\n\n## 请按以下分类输出面试问题和参考答案\n\n### 第一类：项目深挖（必考）\n对简历中每个项目准备：\n1. 这个项目的背景是什么？为什么要做？\n2. 你在这个项目中负责什么？具体做了哪些模块？\n3. 项目中遇到的最大技术难点是什么？怎么解决的？\n4. 如果让你重新做这个项目，你会怎么改进？\n5. 项目用到的技术为什么选这个而不选别的？\n\n### 第二类：技术基础\n根据岗位技术栈准备：\n- Java基础（集合、并发、JVM）\n- Spring家族（IOC/AOP/MVC/Boot）\n- 数据库（MySQL索引、事务、锁、优化）\n- Redis（数据结构、缓存策略、穿透/击穿/雪崩）\n- 计算机网络（HTTP/TCP/IP）\n- 操作系统（进程/线程、内存管理）\n\n### 第三类：场景设计题\n- 如何设计一个秒杀系统？\n- 如何设计一个短链接系统？\n- 如何设计一个消息推送系统？\n- 数据库千万级数据如何分页查询？\n\n### 第四类：HR软技能问题\n- 你的优点和缺点是什么？\n- 为什么从上一家公司离职？\n- 未来3-5年的职业规划？\n- 你的期望薪资是多少？\n- 你对我们公司有什么了解？\n\n每个问题给出：\n- 参考回答（分点作答，有逻辑）\n- 回答要点提醒\n- 加分项提示\n- 避坑指南\n```\n\n---\n\n💡 **使用建议：**\n1. 简历要针对每个岗位定制，不要一份投所有\n2. 项目经历用STAR法则重写，效果立竿见影\n3. 量化数据能让经历更有说服力\n4. 技术关键词要匹配JD，帮助过简历筛选\n5. 面试前把每个项目都深挖一遍\n6. 自我介绍控制在1分钟以内，练到脱口而出',
'GPT/Claude', '全方位的AI简历优化提示词，包含简历重写（STAR法则）、不同岗位专项优化、求职信撰写和面试准备四个维度。', '1. 用STAR法则重写项目经历是最有效的优化手段\n2. 针对每个岗位的JD定制简历，不要一份投所有\n3. 量化数据比形容词有说服力10倍\n4. 技术关键词要和目标岗位JD匹配\n5. 面试前把简历上每个项目都深挖一遍\n6. 自我介绍练到1分钟内说完且流畅', 0, 0),

(7, '短视频爆款文案提示词',
'## AI短视频爆款文案创作Prompt\n\n### 🎯 核心创作Prompt\n```\n你是一名抖音/小红书/B站的头部内容创作者，粉丝量500W+。\n你精通短视频文案创作，了解各平台的内容推荐算法和用户心理。\n你创作的视频平均播放量100W+，点赞率5%以上。\n\n请根据以下要求创作短视频文案。\n\n## 平台与账号信息\n- 发布平台：{抖音/小红书/B站/视频号}\n- 账号定位：{如：科技科普/学习博主/职场干货/生活vlog}\n- 目标受众：{如：大学生/职场新人/程序员/考研党}\n- 视频时长：{如：30秒/1分钟/3分钟}\n\n## 主题/话题\n{你想做什么主题的视频}\n\n## 文案要求\n\n### 1. 黄金开头（前3秒定生死）\n- 必须在前3秒抓住注意力\n- 可用手法：悬念提问/反常识 statement/数据冲击/痛点共鸣/热点借力\n- 禁止：缓慢铺垫、"大家好我是XX"式无聊开场\n- 给出3个不同风格的开口选项\n\n### 2. 正文结构（起承转合）\n- **起（10%）**：抛出问题/现象，建立共鸣\n- **承（40%）**：核心内容交付，分点论述\n- **转（30%）**：反转/深化/进阶/案例\n- **合（20%）**：总结+行动号召(CTA)\n\n### 3. 爆款元素植入\n- [ ] 金句（可以被截图转发的那句话）\n- [ ] 情绪钩子（愤怒/惊讶/感动/焦虑/爽感）\n- [ ] 信息增量（观众不知道的有用信息）\n- [ ] 互动埋点（引导评论的问题）\n- [ ] 记忆锚点（重复出现的口号/动作/口头禅）\n\n### 4. 平台适配\n**抖音特点：**\n- 节奏快，前3秒最重要\n- 适合情绪化、争议性内容\n- BGM卡点是加分项\n- 文案要口语化，像在和朋友聊天\n- 结尾要有明确的关注引导\n\n**小红书特点：**\n- 标题要"标题党"但不夸张\n- 正文多用emoji增加可读性\n- 分段短，适合手机快速浏览\n- 种草属性强，实用价值第一\n- 标签要打满\n\n**B站特点：**\n- 可以更长更深度\n- 弹幕互动文化\n- 内容质量要求更高\n- 适合教程/评测/深度分析\n- 可以有个人风格和梗\n\n### 5. 画面/拍摄建议\n- 每段文案对应的画面内容\n- 需要准备的道具/素材\n- BGM风格建议\n- 字幕/贴纸/特效建议\n\n## 输出格式\n1. **标题选项**（5个，标注推荐指数⭐）\n2. **完整文案脚本**（含画面提示和时间戳）\n3. **封面文案**（封面大字+副标题）\n4. **标签/话题标签**（#话题）\n5. **发布最佳时间建议**\n6. **预期数据表现预估**\n```\n\n---\n\n### 🎬 常见题材快捷模板\n\n**知识科普类：**\n```\n创作一条{主题}的科普短视频，目标时长60秒。\n核心知识点：{列出要讲的点}\n要把专业知识用大白话讲出来，打个生动的比喻。\n结尾要有一个"原来如此"的恍然大悟时刻。\n风格参考：半佛仙人/罗翔说刑法/何同学的风格融合。\n```\n\n**好物推荐/种草类：**\n```\n创作一条{产品名}的种草视频文案。\n真实体验感受，不要硬广感。\n结构：痛点引入 → 产品登场 → 使用体验 → 效果展示 → 购买建议\n要提到1-2个缺点增加可信度（欲扬先抑）。\n小红书风格，emoji丰富，分段清晰。\n```\n\n**职场/成长类：**\n```\n创作一条关于"{职场话题}"的励志/干货短视频。\n目标受众：刚入职场的年轻人/大学生。\n要先戳中痛点和焦虑，再给出解决方案。\n要有"我当年也是这样..."的共情叙述。\n金句要能让人截图发朋友圈。\n参考博主：李佳琦（不是）/刘媛媛/房琪的风格。\n```\n\n**技术教程类：**\n```\n创作一条"{软件/工具/技术}"的快速上手教程视频。\n目标时长：90秒内讲清楚核心用法。\n结构：它能干什么(10s) → 怎么用(50s) → 进阶技巧(20s) → 关注我看更多(10s)\n录屏+人脸出镜讲解结合。\n语速要快但清晰，信息密度要高。\n```\n\n---\n\n### 📈 爆款标题生成器\n\n```\n请为以下内容生成20个爆款短视频标题。\n\n内容主题：{描述}\n平台：{抖音/小红书/B站}\n\n标题类型分布：\n- 数字型（5个）：用具体数字吸引点击\n- 悬念型（5个）：引发好奇心\n- 痛点型（5个）：直击目标受众痛点\n- 反差型（3个）：打破常规认知\n- 热点型（2个）：蹭热度/借势\n\n每个标题标注：\n- 适用平台\n- 预估点击率（低/中/高）\n- 推荐理由（为什么这个标题有效）\n\n最终推荐TOP 3标题并说明选择理由。\n```\n\n---\n\n💡 **使用建议：**\n1. 前3秒定生死，开头一定要炸\n2. 一个视频只讲一个核心观点\n3. 金句是传播的关键，精心设计那一句能被截图的话\n4. 模仿对标博主的风格比自己摸索快10倍\n5. 发布后看数据反馈，数据差的复盘优化\n6. 保持更新频率，算法喜欢活跃账号',
'GPT/Claude/Kimi', '全面的短视频文案AI创作提示词，包含黄金开头公式、正文结构模板、平台适配策略、常见题材快捷模板和爆款标题生成器。', '1. 前3秒定生死，开头一定要抓眼球\n2. 一个视频只讲一个核心观点，贪多嚼不烂\n3. 精心设计一句能被截图的金句\n4. 先找对标账号模仿，再发展自己的风格\n5. 发布后根据数据反馈不断优化\n6. 保持稳定的更新频率', 0, 0),

(4, 'Zeabur部署排错提示词',
'## Zeabur部署问题排查AI诊断Prompt\n\n### 🎯 核心排查Prompt\n```\n你是一位DevOps工程师和云平台技术专家，精通各种PaaS平台的部署和运维。\n你有丰富的Zeabur/Vercel/Railway/Render等平台的使用经验和排错经验。\n\n我在Zeabur上部署项目遇到了问题，请帮我诊断和解决。\n\n## 项目信息\n- 项目类型：{Spring Boot / Vue / Next.js / Express / 其他}\n- 部署方式：{Git仓库部署 / Docker镜像部署 / 预构建}\n- 项目仓库地址：{GitHub/GitLab URL}\n- 分支：{main/master/dev}\n\n## 问题描述\n{详细描述遇到了什么问题}\n\n## 错误信息\n{粘贴完整的错误日志/报错信息/浏览器报错}\n\n## 我已经尝试过的解决方法\n{列出你已经尝试过的方法和结果}\n\n## 请按以下步骤帮我排查\n\n### Step 1: 问题分类\n- 这是哪一类问题？（构建失败/运行时错误/网络问题/配置问题/数据库问题）\n- 问题的紧急程度和影响范围\n\n### Step 2: 可能的原因分析\n列出所有可能导致此问题的原因，按可能性从高到低排序。\n对每个原因说明：\n- 为什么会导致这个问题\n- 如何验证是否是这个原因\n\n### Step 3: 解决方案\n对每个可能的原因提供：\n- 具体的解决步骤（一步一步来）\n- 需要修改的代码或配置\n- 验证修复是否成功的命令\n\n### Step 4: 预防措施\n如何避免类似问题再次发生：\n- 最佳实践建议\n- 需要添加的配置或检查项\n- 部署前的checklist\n\n### Step 5: 如果以上都不行\n- 下一步应该怎么排查\n- 需要提供什么额外的信息给你\n- Zeabur官方支持的联系方式\n```\n\n---\n\n### 🔥 常见问题速查Prompt\n\n**Spring Boot部署白屏/502：**\n```\n我的Spring Boot项目部署到Zeabur后出现502 Bad Gateway或白屏。\n\n项目信息：\n- Spring Boot 3.x + MyBatis Plus + MySQL\n- 本地运行正常，部署后无法访问\n- Zeabur日志显示：{粘贴日志}\n\n请帮我按以下顺序排查：\n1. 端口绑定问题（是否监听PORT环境变量）\n2. 数据库连接问题（连接字符串是否正确配置为环境变量）\n3. 依赖打包问题（是否正确包含了所有依赖）\n4. Profile激活问题（是否使用了spring.profiles.active）\n5. 资源限制问题（内存是否足够）\n\n请给出每种情况的判断方法和解决方案。\n```\n\n**Vue/React前端部署后空白：**\n```\n我的Vue3项目部署到Zeabur后页面空白，F12控制台报错。\n\n项目信息：\n- Vue 3 + Vite + Router\n- npm run build成功\n- 本地npm run preview正常\n- 部署后空白页 + 控制台报错：{粘贴错误}\n\n请帮我排查：\n1. base路径配置问题（vue.config.js/vite.config.js的base）\n2. Router的history模式问题（是否需要配置rewrites）\n3. 环境变量问题（.env.production是否正确配置API地址）\n4. 静态资源路径问题（相对路径vs绝对路径）\n5. 构建输出目录配置问题（distDir设置）\n```\n\n**数据库连接失败：**\n```\nZeabur上部署的应用连不上MySQL数据库。\n\n当前配置：\n- 数据库：Zeabur内置MySQL / 外部MySQL\n- 连接方式：{JDBC URL}\n- 错误信息：{Connection refused / Timeout / Access denied}\n\n请帮我排查：\n1. 如果是Zeabur内置MySQL：服务名/主机名是否正确\n2. 如果是外部MySQL：网络连通性和防火墙\n3. 连接池配置是否合理\n4. 时区和字符集配置\n5. 连接URL格式是否正确（特别是Zeabur的环境变量引用方式）\n```\n\n---\n\n### 📋 部署前Checklist Prompt\n```\n请帮我生成一份【{项目类型}】部署到Zeabur的完整Checklist。\n\n## Checklist分类\n\n### 代码层面\n- [ ] 端口使用环境变量PORT\n- [ ] 数据库连接使用环境变量\n- [ ] 生产环境Profile配置\n- [ ] .env文件不在Git仓库中\n- [ ] 静态资源路径使用相对路径\n- [ ] CORS配置允许Zeabur域名\n- [ ] 日志输出到stdout（不是文件）\n- [ ] 依赖版本锁定（package-lock.json / pom.xml）\n\n### 配置层面\n- [ ] zeabur.yml配置正确（如果有）\n- [ ] Build Command正确\n- [ ] Output Directory正确\n- [ ] 环境变量全部配置\n- [ ] 数据库服务已创建并启动\n- [ ] 域名/DNS配置（如果用自定义域名）\n\n### 测试层面\n- [ ] 本地build成功\n- [ ] 本地用production profile运行成功\n- [ ] API接口测试通过\n- [ ] 前后端联调成功\n- [ ] 数据库初始化脚本可执行\n\n### 监控层面\n- [ ] 健康检查接口(/health)已配置\n- [ ] 日志级别设置为INFO\n- [ ] 错误告警机制（如有）\n\n请输出一个Markdown格式的Checklist，我可以逐项打勾确认。\n```\n\n---\n\n💡 **使用建议：**\n1. 出问题时先把完整错误日志复制给AI，不要只说"报错了"\n2. 最常见的问题是端口绑定和环境变量，先查这两个\n3. Zeabur的服务间通信用服务名而不是localhost\n4. 查看实时日志是最好的排错方式\n5. 本地能跑不代表部署一定能成功，环境差异很大\n6. 保留一份部署成功的配置备份',
'GPT/Claude/DeepSeek', 'Zeabur部署问题AI诊断提示词，包含系统性排查流程、常见问题速查（502/白屏/数据库连接失败）和部署前完整Checklist。', '1. 出问题第一时间看日志，把完整报错贴给AI\n2. 最常见原因：端口绑定、环境变量、数据库连接\n3. Zeabur内部服务用服务名通信，不是localhost\n4. 部署前跑一遍Checklist能避免80%的问题\n5. 保留一份能正常运行的配置做备份\n6. Zeabur官方Discord社区也很活跃，可以去问', 0, 0),

(4, 'Codex项目修复提示词',
'## AI辅助项目Bug修复与代码优化Prompt\n\n### 🎯 Bug修复核心Prompt\n```\n你是一名高级软件工程师，拥有丰富的调试和Bug修复经验。\n你擅长通过错误信息快速定位问题根因，并提供优雅的修复方案。\n\n请帮我修复以下代码问题。\n\n## 项目信息\n- 项目类型：{Spring Boot / Vue3 / React / 其他}\n- 技术栈：{列出主要技术}\n- IDE：{IntelliJ IDEA / VS Code / 其他}\n\n## 问题描述\n{详细描述bug的表现，什么时候出现，什么操作触发的}\n\n## 错误信息\n### 控制台/终端错误\n```\n{粘贴完整的错误堆栈/日志}\n```\n\n### 浏览器报错（如果是前端）\n```\n{粘贴F12 Console的错误}\n```\n\n### 预期行为 vs 实际行为\n- **预期：** {应该是什么样的}\n- **实际：** {实际上是什么样的}\n\n## 相关代码\n{粘贴你认为可能有问题的代码文件内容}\n\n## 请按以下格式输出\n\n### 1. 问题诊断\n- **根本原因：** 一句话说明问题的本质\n- **错误链分析：** 从表象到底层的推导过程\n- **影响范围：** 这个bug还会影响到哪些功能\n\n### 2. 修复方案\n- **方案一（推荐）：** {最优方案的代码和说明}\n- **方案二（备选）：** {替代方案的代码和说明}\n- 每个方案给出：修复原理、优缺点、风险点\n\n### 3. 修复后的完整代码\n直接输出修复后的完整代码块，标注修改的地方。\n\n### 4. 防御措施\n- 如何防止类似bug再次发生\n- 需要添加的单元测试\n- 代码审查checklist\n\n### 5. 学习要点\n从这个bug中学到了什么知识/踩到了什么坑\n```\n\n---\n\n### 🔍 常见Bug类型速修Prompt\n\n**404/路由问题：**\n```\n我的前端项目刷新页面后出现404 Not Found。\n\n项目信息：\n- Vue 3 + Vue Router + Vite\n- 部署在{Zeabur/Nginx/其他}\n- Router使用的是history模式\n\n本地开发一切正常，部署后刷新页面就404。\n请告诉我具体原因和所有可行的解决方案。\n```\n\n**跨域CORS问题：**\n```\n前端调用后端接口时报跨域错误：Access-Control-Allow-Origin\n\n前端：http://localhost:5173\n后端：http://localhost:8080\n\n请求类型：{GET/POST/PUT/DELETE}\n接口路径：{/api/xxx}\n\n请给出前端和后端各自的解决方案，包括开发环境和生产环境的区别。\n```\n\n**MyBatis SQL错误：**\n```\nMyBatis执行SQL时报错：{粘贴错误信息}\n\nXML映射文件：\n{粘贴Mapper XML}\n\nEntity类：\n{粘贴Entity类代码}\n\n请检查：\n1. resultType/resultMap是否正确\n2. 参数绑定是否正确（#{}/${的区别）\n3. 字段名和属性名是否对应（下划线vs驼峰）\n4. SQL语法是否有误\n5. 是否有多对一/一对多的映射问题\n```\n\n**前端样式错乱：**\n```\n我的{Vue/React}组件样式出现了问题：\n\n问题描述：{样式表现}\n预期效果：{应该什么样}\n\n当前代码：\n{粘贴组件代码}\n\n请检查：\n1. CSS作用域问题（scoped的影响）\n2. 样式优先级/覆盖问题\n3. 响应式断点问题\n4. Flex/Grid布局问题\n5. Tailwind CSS类名是否正确\n```\n\n---\n\n### 📖 代码审查Prompt\n```\n请对以下代码进行专业的Code Review。\n\n## 代码文件\n{粘贴代码或文件路径}\n\n## 审查维度\n\n### 1. 正确性\n- 逻辑是否正确\n- 边界条件是否处理\n- 是否有空指针风险\n- 异常处理是否完善\n\n### 2. 性能\n- 是否有不必要的循环/查询\n- 是否有N+1查询问题\n- 内存使用是否合理\n- 算法复杂度是否最优\n\n### 3. 安全性\n- SQL注入风险\n- XSS攻击风险\n- 敏感信息泄露\n- 权限校验是否到位\n\n### 4. 可维护性\n- 命名是否清晰规范\n- 代码结构是否合理\n- 是否有重复代码可以抽取\n- 注释是否充分\n\n### 5. 规范性\n- 是否符合项目/团队编码规范\n- 是否符合语言最佳实践\n- 设计模式使用是否恰当\n\n## 输出格式\n- 总体评分（1-10分）\n- 问题列表（按严重程度：🔴严重 / 🟡中等 / 🟢建议）\n- 每个问题：位置 + 问题说明 + 修改建议 + 参考代码\n- 亮点表扬（做得好的地方）\n- 重构建议（如果有更好的写法）\n```\n\n---\n\n### ⚡ 代码优化Prompt\n```\n请优化以下代码，提升质量和性能。\n\n## 待优化代码\n{粘贴代码}\n\n## 优化目标（可多选）\n- [ ] 提升执行性能\n- [ ] 提高代码可读性\n- [ ] 减少代码冗余\n- [ ] 增强健壮性\n- [ ] 符合设计模式\n- [ ] 降低圈复杂度\n\n## 约束条件\n- 不能改变对外接口的行为\n- 保持向后兼容\n- 需要解释每处修改的理由\n\n## 输出要求\n1. 优化前后的对比\n2. 每处修改的解释（Why）\n3. 性能提升的量化分析（如果能量化）\n4. 是否引入了新的风险\n```\n\n---\n\n💡 **使用建议：**\n1. 报错信息一定要完整复制，包括堆栈跟踪\n2. 说明"预期 vs 实际"，帮AI缩小排查范围\n3. 同时贴相关代码，不要让AI猜你的代码结构\n4. 先让AI诊断原因，再让它给修复方案\n5. 修复后要自己测试验证\n6. 每个bug都是学习机会，总结踩坑经验',
'GPT/Claude/Codex', '全方位的AI辅助代码问题解决提示词，涵盖Bug修复（含诊断流程）、常见问题速修（404/跨域/SQL/样式）、Code Review和代码优化四大场景。', '1. 报错信息要完整复制，包括堆栈跟踪\n2. 说清"预期vs实际"，帮AI缩小排查范围\n3. 相关代码一起贴过去，不要让AI猜\n4. 先诊断原因再给方案，不要跳步\n5. 修复后一定要自己测试验证\n6. 每个bug都是学习机会，记下来避免再犯', 0, 0);

INSERT INTO article (title, cover, summary, content, views) VALUES
('如何选择适合自己的AI工具',
'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800',
'面对市面上数百款AI工具，很多同学不知道该如何选择。本文将从使用场景、预算、技术门槛等多个维度，帮你找到最适合你的AI工具组合。',
'<h2>为什么选择合适的AI工具如此重要</h2>
<p>2024年以来，AI工具呈爆发式增长。据统计，仅AI聊天类工具就有超过50款主流产品，AI绘图、AI写作、AI编程等领域更是百花齐放。面对如此多的选择，很多同学陷入了"工具焦虑"——装了一堆APP却不知道用哪个好。</p>
<p>其实，<strong>工具不在多而在精</strong>。找到适合自己的2-3款核心AI工具，远比安装几十个却吃灰要有效得多。本文将帮你建立AI工具选择的思维框架，让你能够根据自己的需求和场景做出明智的选择。</p>

<h2>第一步：明确你的核心需求</h2>
<p>在选择AI工具之前，先问自己三个问题：</p>
<ul>
<li><strong>我最常做的事情是什么？</strong> 写代码？写论文？做设计？学英语？</li>
<li><strong>我愿意为此付出多少成本？</strong> 完全免费还是愿意每月花费几十元？</li>
<li><strong>我对技术门槛的接受度如何？</strong> 希望开箱即用还是愿意折腾配置？</li>
</ul>
<p>这三个问题的答案，基本决定了你应该往哪个方向去选工具。</p>

<h2>按使用场景推荐</h2>

<h3>🤖 AI对话与写作</h3>
<table>
<tr><th>工具</th><th>适合人群</th><th>核心优势</th><th>价格</th></tr>
<tr><td>ChatGPT</td><td>通用用户，追求综合能力</td><td>生态最成熟，插件丰富</td><td>$20/月(Plus)</td></tr>
<tr><td>Claude</td><td>长文档处理、深度分析</td><td>200K超长上下文，安全性好</td><td>$20/月(Pro)</td></tr>
<tr><td>DeepSeek</td><td>学生党、预算有限</td><td>免费好用，数学和代码强</td><td>免费</td></tr>
<tr><td>Kimi</td><td>需要处理大量文档</td><td>支持200万字输入，文件解析强</td><td>免费</td></tr>
<tr><td>通义千问</td><td>中文场景为主</td><td>中文理解能力顶尖</td><td>免费</td></tr>
</table>

<h3>🎨 AI绘图与设计</h3>
<table>
<tr><th>工具</th><th>适合人群</th><th>核心优势</th><th>价格</th></tr>
<tr><td>Midjourney</td><td>设计师、内容创作者</td><td>画质最高，艺术感最强</td><td>$10-60/月</td></tr>
<tr><td>Stable Diffusion</td><td>技术人员、追求可控性</td><td>完全开源，可本地部署</td><td>免费(本地)</td></tr>
<tr><td>Canva AI</td><td>非设计人员做设计</td><td>模板丰富，上手简单</td><td>$12.99/月</td></tr>
</table>

<h3>💻 AI编程</h3>
<table>
<tr><th>工具</th><th>适合人群</th><th>核心优势</th><th>价格</th></tr>
<tr><td>Cursor</td><td>追求极致编码效率</td><td>AI原生IDE，体验最好</td><td>$20/月</td></tr>
<tr><td>GitHub Copilot</td><td>VS Code/JetBrains用户</td><td>IDE集成度高，社区大</td><td>$10/月</td></tr>
</table>

<h2>省钱攻略：免费工具组合方案</h2>
<p>如果你是学生或者预算有限，以下<strong>零成本组合</strong>已经能覆盖大部分场景：</p>
<ol>
<li><strong>AI对话：</strong>DeepSeek（主力）+ Kimi（长文档）+ 通义千问（中文）</li>
<li><strong>AI绘图：</strong>Stable Diffusion本地部署（需要显卡）或使用在线免费版</li>
<li><strong>AI编程：</strong>Copilot学生版免费申请 + Cursor免费额度</li>
<li><strong>AI办公：</strong>Notion AI免费额度 + Canva免费版</li>
</ol>
<p>这套组合完全可以满足日常学习和项目开发的需求，总花费：<strong>0元</strong>。</p>

<h2>避坑指南</h2>
<ul>
<li><strong>不要盲目追新：</strong> 新工具层出不穷，但经过验证的老工具往往更靠谱</li>
<li><strong>注意数据隐私：</strong> 不要把敏感代码和私密信息发给不可信的AI</li>
<li><strong>警惕订阅陷阱：</strong> 很多工具免费版够用，不要冲动订阅年费</li>
<li><strong>善用免费额度：</strong> 大多数付费工具都有免费试用或免费额度</li>
</ul>

<h2>总结</h2>
<p>选择AI工具的核心原则：<strong>从需求出发，从小处开始，逐步迭代</strong>。先选一款主力工具用熟，再根据需要扩展工具链。记住，工具是为你服务的，不要被工具绑架。真正的高手，是用最简单的工具创造最大的价值。</p>', 0),

('如何写出高质量AI提示词',
'https://images.unsplash.com/photo-1684487741552-7d88a63b36b2?w=800',
'同样的AI工具，有人用它产出惊艳的结果，有人却只能得到平庸的回答。差距就在于提示词(Prompt)的质量。本文教你掌握提示词工程的核心方法论。',
'<h2>什么是提示词工程</h2>
<p>提示词工程（Prompt Engineering）是指<strong>设计和优化输入给AI的指令</strong>，以获得最优质输出的技术和方法。你可以把它理解为"和AI沟通的语言艺术"——你说得越清楚、越具体，AI给你的回报就越精准、越有价值。</p>
<p>很多人觉得提示词就是随便打几句话，这是最大的误区。<strong>一个好的提示词和差的提示词，输出质量可能相差10倍</strong>。</p>

<h2>提示词的核心公式</h2>
<p>经过大量实践验证，高质量提示词通常遵循以下结构：</p>
<pre>
📌 角色设定 + 📋 任务背景 + 📝 具体要求 + 🎯 输出格式 + ⚠️ 约束条件
</pre>
<p>让我们用一个例子来拆解：</p>
<h3>❌ 差的提示词：</h3>
<p>"帮我写一篇关于Spring Boot的文章"</p>
<h3>✅ 好的提示词：</h3>
<p>"你是一名拥有10年Java开发经验的资深技术博主，擅长将复杂的技术概念用通俗易懂的方式讲解出来。请帮我写一篇面向初学者的Spring Boot入门教程文章。要求：1)从什么是Spring Boot讲起 2)包含一个Hello World的完整代码示例 3)解释核心概念IOC和DI 4)字数2000字左右 5)用类比和生活中的例子来解释技术概念 6)语气亲切友好，像学长在给学弟讲课。请用Markdown格式输出，包含适当的代码块和表格。"</p>
<p>看到了吗？后者给了AI足够的<strong>上下文、角色、要求和约束</strong>，输出质量自然会大幅提升。</p>

<h2>六大技巧让你的提示词升级</h2>

<h3>技巧1：赋予AI明确的角色</h3>
<p>不要让AI以默认身份回答，而是给它一个专业角色：</p>
<ul>
<li>"你是一位资深DBA..."</li>
<li>"你是一名拥有15年经验的UI设计师..."</li>
<li>"你是一位学术论文审稿人..."</li>
</ul>
<p>角色设定会让AI的回答风格、专业度和深度都完全不同。</p>

<h3>技巧2：提供充分的上下文</h3>
<p>把你已知的信息都告诉AI，包括：</p>
<ul>
<li>你的技术水平（初学者/有经验/专家）</li>
<li>使用场景（学习/工作/比赛）</li>
<li>已有的代码/资料/想法</li>
<li>限制条件（时间/字数/工具版本）</li>
</ul>

<h3>技巧3：分步骤下达指令</h3>
<p>复杂的任务不要一口气说完，而是分步骤：</p>
<ol>
<li>先让AI出大纲/方案</li>
<li>确认后再让AI展开某一部分</li>
<li>不满意的地方单独要求修改</li>
</ul>
<p>这种<strong>迭代式对话</strong>比一次性长提示词效果更好。</p>

<h3技巧4：给出示例（Few-Shot Learning）</h3>
<p>给AI1-2个你期望的输出示例，它就能模仿你的风格和质量：</p>
<p>"参考以下格式输出：[你的示例]"</p>
<p>这是提升输出质量最有效的方法之一。</p>

<h3>技巧5：明确输出格式</h3>
<p>告诉AI你想要的格式：</p>
<ul>
<li>Markdown格式（含标题层级、表格、代码块）</li>
<li>JSON格式（用于程序调用）</li>
<li>特定模板（如：论文格式、邮件格式、PRD格式）</li>
</ul>

<h3>技巧6：设置约束条件</h3>
<p>告诉AI<strong>不要</strong>做什么同样重要：</p>
<ul>
<li>"不要使用过于专业的术语"</li>
<li>"不要超过500字"</li>
<li>"不要使用外部链接，因为你可能会编造"</li>
<li>"每段不超过3句话"</li>
</ul>

<h2>实战案例对比</h2>
<h3>场景：让AI帮你设计数据库</h3>
<p><strong>❌ 普通版：</strong>"帮我设计一个商城数据库"</p>
<p><strong>✅ 进阶版：</strong>"你是资深DBA，请帮我设计一个电商平台的MySQL数据库。要求：1)符合第三范式 2)至少8张表 3)包含用户/商品/订单/购物车/支付/评价/优惠券/搜索模块 4)覆盖1:1、1:N、N:M三种关系 5)每张表有create_time/update_time审计字段 6)每张表至少5条初始化数据 7)输出完整DDL和INSERT语句。"</p>

<h2>进阶：提示词模板化</h2>
<p>当你发现某个提示词反复使用时，把它做成<strong>模板</strong>：</p>
<pre>
# 角色设定（固定）
你是一名{角色}...

# 任务背景（填空）
我正在做一个{项目描述}...

# 具体要求（可选项）
- [ ] 要求1
- [ ] 要求2

# 输出格式（固定）
请按以下格式输出：
...
</pre>
<p>把模板保存下来，每次换个关键词就能复用，效率极高。</p>

<h2>总结</h2>
<p>提示词工程的核心在于：<strong>把你的需求尽可能清晰、完整地传达给AI</strong>。就像给人布置任务一样，说得越清楚，结果越接近预期。多练习、多总结、多积累自己的提示词模板库，你会发现AI的能力远比你想象的大。记住：<strong>AI的上限，取决于你提示词的下限</strong>。</p>', 0),

('如何把Spring Boot项目部署到Zeabur',
'https://images.unsplash.com/photo-1627398242454-45a1465c2479?w=800',
'Spring Boot项目写好了，怎么让别人也能访问？本文手把手教你把项目免费部署到Zeabur平台，实现公网访问，从零到上线全程详解。',
'<h2>为什么选择Zeabur</h2>
<p>对于学生和开发者来说，Zeabur是一个非常适合部署项目的平台：</p>
<ul>
<li><strong>国内访问友好：</strong> 不像Vercel等国外平台需要翻墙</li>
<li><strong>免费额度充足：</strong> 个人项目基本够用</li>
<li><strong>一键部署：</strong> 连接GitHub仓库即可自动部署</li>
<li><strong>内置数据库：</strong> MySQL、PostgreSQL、Redis一键开通</li>
<li><strong>自定义域名：</strong> 支持绑定自己的域名</li>
</ul>
<p>接下来我们一步步把一个Spring Boot项目部署上去。</p>

<h2>准备工作</h2>
<h3>1. 项目代码推送到GitHub</h3>
<p>确保你的Spring Boot项目已经推送到GitHub仓库。如果还没有：</p>
<pre><code># 创建GitHub仓库后
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/你的用户名/仓库名.git
git push -u origin main
</code></pre>

<h3>2. 修改项目配置</h3>
<p>为了让项目能在Zeabur上正确运行，需要做一些适配：</p>
<h4>application.yml 修改：</h4>
<pre><code>server:
  port: ${PORT:8080}

spring:
  datasource:
    url: jdbc:mysql://${MYSQL_HOST:localhost}:${MYSQL_PORT:3306}/${MYSQL_DATABASE:testdb}?useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true
    username: ${MYSQL_USERNAME:root}
    password: ${MYSQL_PASSWORD:123456}
</code></pre>
<p>关键点：数据库连接信息使用环境变量，这样在Zeabur上可以直接通过平台配置。</p>

<h3>3. 确保pom.xml配置正确</h3>
<pre><code>&lt;packaging&gt;jar&lt;/packaging&gt;

&lt;build&gt;
  &lt;plugins&gt;
    &lt;plugin&gt;
      &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;
      &lt;artifactId&gt;spring-boot-maven-plugin&lt;/artifactId&gt;
      &lt;configuration&gt;
        &lt;excludes&gt;
          &lt;exclude&gt;
            &lt;groupId&gt;org.projectlombok&lt;/groupId&gt;
            &lt;artifactId&gt;lombok&lt;/artifactId&gt;
          &lt;/exclude&gt;
        &lt;/excludes&gt;
      &lt;/configuration&gt;
    &lt;/plugin&gt;
  &lt;/plugins&gt;
&lt;/build&gt;
</code></pre>

<h2>开始部署</h2>

<h3>Step 1：注册Zeabur账号</h3>
<ol>
<li>访问 <a href="https://zeabur.com">zeabur.com</a></li>
<li>使用GitHub账号登录（推荐）</li>
<li>完成注册后会进入控制台Dashboard</li>
</ol>

<h3>Step 2：创建数据库服务</h3>
<ol>
<li>在Dashboard点击「+ New Project」</li>
<li>选择「Database」→「MySQL」</li>
<li>等待MySQL服务创建完成（约30秒）</li>
<li>点击进入MySQL服务，记录连接信息（后续会用到）</li>
</ol>

<h3>Step 3：部署Spring Boot应用</h3>
<ol>
<li>在同一个Project中点击「+ Deploy Service」</li>
<li>选择「GitHub」→ 选择你的仓库和分支</li>
<li>Zeabur会自动检测到这是一个Maven项目</li>
<li>配置Build Command：<code>mvn clean package -DskipTests</code></li>
<li>配置Start Command：<code>java -jar target/xxx.jar</code></li>
<li>点击Deploy，等待构建完成</li>
</ol>

<h3>Step 4：配置环境变量</h3>
<p>在应用的Settings → Variables中添加：</p>
<ul>
<li><code>MYSQL_HOST</code> → 填写MySQL服务的主机名（在MySQL服务详情页可以看到）</li>
<li><code>MYSQL_PORT</code> → <code>3306</code></li>
<li><code>MYSQL_DATABASE</code> → 你的数据库名</li>
<li><code>MYSQL_USERNAME</code> → MySQL用户名</li>
<li><code>MYSQL_PASSWORD</code> → MySQL密码</li>
</ul>

<h3>Step 5：导入数据库</h3>
<p>可以通过Zeabur的MySQL管理面板导入你的schema.sql和data.sql，或者使用MySQL客户端连接后导入。</p>

<h3>Step 6：验证部署</h3>
<p>部署完成后，Zeabur会给你的应用分配一个公网域名（类似 xxx.zeabur.app）。访问这个域名，看看你的项目是否能正常运行！</p>

<h2>常见问题排查</h2>

<h3>Q1: 部署后502 Bad Gateway</h3>
<p><strong>原因：</strong> 应用没有正确监听PORT环境变量<br>
<strong>解决：</strong> 确保application.yml中使用 <code>${PORT:8080}</code></p>

<h3>Q2: 数据库连接失败</h3>
<p><strong>原因：</strong> 主机名填写错误<br>
<strong>解决：</strong> Zeabur内部服务通信使用服务名而不是localhost，在MySQL服务详情页复制正确的主机名</p>

<h3>Q3: 构建超时</h3>
<p><strong>原因：</strong> Maven下载依赖太慢<br>
<strong>解决：</strong> 在pom.xml中配置阿里云Maven镜像加速</p>

<h3>Q4: 内存不足OOM</h3>
<p><strong>原因：</strong> 免费版内存限制256MB<br>
<strong>解决：</strong> 优化JVM参数：-Xmx192m，或者在Settings中升级资源配置</p>

<h2>绑定自定义域名（可选）</h2>
<ol>
<li>在域名服务商处添加CNAME记录指向Zeabur的域名</li>
<li>在Zeabur的Domain设置中添加你的域名</li>
<li>等待DNS生效（通常几分钟到几小时）</li>
<li>启用HTTPS（Zeabur自动提供Let\'s Encrypt证书）</li>
</ol>

<h2>总结</h2>
<p>把Spring Boot项目部署到Zeabur只需要6步：推代码 → 创建数据库 → 部署应用 → 配置环境变量 → 导入数据 → 验证访问。整个过程大约15-30分钟就能完成。对于课程设计、毕业设计、个人项目来说，Zeabur是一个非常友好的部署选择——免费、快速、国内可访问。赶紧试试吧！</p>', 0),

('如何用AI提高学习和开发效率',
'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800',
'AI不仅是聊天机器人，它可以是你的私人导师、编程搭档、写作助手和学习伙伴。本文分享AI在学习场景下的10种高效用法，帮你事半功倍。',
'<h2>AI时代的学习新范式</h2>
<p>在过去，遇到不会的问题只能百度、查书、问老师。现在，有了AI工具，学习的效率和方式发生了质的改变。<strong>AI不是一个搜索引擎，它是一个能思考、能推理、能创造的知识引擎</strong>。</p>
<p>作为一名计算机专业的学生，我把AI融入日常学习和开发的各个环节，效率提升了不止一点点。下面是我的实战经验分享。</p>

<h2>💻 编程开发：AI是你的超级搭档</h2>

<h3>1. 代码生成与补全</h3>
<p>以前写一个CRUD模块可能需要半天，现在用Cursor或Copilot，<strong>描述需求就能生成80%的代码</strong>。我的做法是：</p>
<ul>
<li>先用自然语言描述要实现的功能</li>
<li>让AI生成初始代码框架</li>
<li>在此基础上修改和完善</li>
<li>遇到不懂的代码立刻问AI解释</li>
</ul>

<h3>2. Bug调试神器</h3>
<p>遇到报错不再慌张。把错误信息丢给AI，它通常能：</p>
<ul>
<li>准确定位错误原因</li>
<li>解释错误的含义</li>
<li>提供修复方案</li>
<li>告诉你为什么会犯这个错误（预防下次）</li>
</ul>
<p><strong>实际案例：</strong>有一次MyBatis的一直报NullPointer异常，我花了2小时没找到原因。把错误日志丢给DeepSeek后，它一眼看出是resultType和resultMap搞混了，1分钟解决。</p>

<h3>3. 代码审查与优化</h3>
<p>写完代码后，让AI做Code Review：</p>
<pre>
"请审查这段代码的正确性、性能、安全性和可维护性，
按严重程度列出问题并给出修改建议。"
</pre>
<p>经常能发现你自己忽略的问题，比如SQL注入风险、N+1查询、空指针隐患等。</p>

<h2>📚 知识学习：AI是24小时私教</h2>

<h3>4. 概念解释：用类比法理解难点</h3>
<p>计算机有很多抽象概念很难理解。让AI用类比法解释：</p>
<p><strong>比如问："用生活中的例子解释什么是Spring的IOC"</strong></p>
<p>AI会说："想象你去餐厅吃饭。传统方式是你自己做菜（自己new对象），而IOC就像是服务员把菜端到你面前（容器帮你创建和注入对象）。你只需要告诉服务员你要什么菜（声明依赖），不需要关心菜是怎么做的。" —— 一下子就懂了！</p>

<h3>5. 制定学习路线</h3>
<p>想学新技术不知道从哪开始？问AI：</p>
<pre>
"我想学习Vue3全栈开发，目前会Java基础和HTML/CSS。
请帮我制定一个为期8周的学习计划，
每周的学习目标、具体内容和练习项目。"
</pre>
<p>AI会给你一份结构化的学习路线，比网上搜的碎片化教程有用得多。</p>

<h3>6. 技术选型决策</h3>
<p>做项目时纠结用什么技术栈？让AI帮你分析：</p>
<pre>
"我要做一个校园二手交易平台，用户量约5000人。
请帮我分析前端用Vue3还是React？
后端用Spring Boot还是Node.js？
数据库用MySQL还是MongoDB？
请从开发效率、性能、维护成本、学习曲线等角度对比。"
</pre>

<h2>✍️ 学术写作：AI是你的写作助理</h2>

<h3>7. 论文框架搭建</h3>
<p>写论文最难的是开头。让AI帮你：</p>
<ul>
<li>生成论文大纲和各章节要点</li>
<li>撰写文献综述的框架</li>
<li>梳理论文的逻辑结构</li>
<li>检查论证是否严密</li>
</ul>

<h3>8. 语言润色与降重</h3>
<p>写完初稿后：</p>
<ul>
<li>让AI检查语法错误和表达不通顺的地方</li>
<li>把口语化表达改为学术用语</li>
<li>优化段落之间的逻辑衔接</li>
<li>注意：核心观点和创新必须是自己的，AI只是辅助表达</li>
</ul>

<h3>9. PPT制作加速</h3>
<p>课程答辩PPT再也不用手动排版：</p>
<pre>
"帮我设计一份15页的Spring Boot项目答辩PPT。
项目是一个在线考试系统。
风格：科技蓝配色，简洁大方。
每页包含：标题、要点、演讲备注。"
</pre>
<p>再用Canva AI或Gamma一键生成，效率提升10倍。</p>

<h2>🎯 效率提升：AI是时间管理大师</h2>

<h3>10. 信息提炼与总结</h3>
<p>面对长篇技术文档、英文论文、开源项目README：</p>
<pre>
"请总结这篇文章的核心观点，
提取关键技术要点，
标注重要的参数和配置，
用表格形式呈现。"
</pre>
<p>原本需要1小时读完的文章，5分钟就能抓住重点。</p>

<h2>⚠️ 使用AI的正确姿势</h2>
<ul>
<li><strong>✅ 要做的：</strong>用AI理解概念、生成框架、Debug排查、效率工具</li>
<li><strong>❌ 不要做的：</strong>直接让AI写论文交差、复制粘贴不理解就提交、完全依赖AI丧失思考能力</li>
</ul>
<p>核心原则：<strong>AI是副驾驶，你是主驾驶</strong>。AI帮你加速，但方向和决策必须由你来把控。</p>

<h2>工具推荐：我的AI工具箱</h2>
<table>
<tr><th>场景</th><th>首选工具</th><th>备选工具</th></tr>
<tr><td>日常对话</td><td>DeepSeek</td><td>Kimi / 通义千问</td></tr>
<tr><td>长文档分析</td><td>Claude</td><td>Kimi</td></tr>
<tr><td>代码开发</td><td>Cursor</td><td>GitHub Copilot</td></tr>
<tr><td>论文辅助</td><td>Claude + Kimi</td><td>通义千问</td></tr>
<tr><td>PPT制作</td><td>Canva AI</td><td>Gamma</td></tr>
<tr><td>信息搜索</td><td>Perplexity</td><td>Gemini</td></tr>
</table>

<h2>总结</h2>
<p>AI不是来取代我们的，而是来放大我们的能力的。学会用好AI，你的学习和开发效率会有质的飞跃。关键是：<strong>保持主动思考的习惯，把AI当作最强大的工具，而不是偷懒的借口</strong>。未来属于那些善于利用AI的人——从现在开始，让AI成为你的超级外挂吧！</p>', 0);

INSERT INTO banner (title, image_url, link_url, sort, status) VALUES
('探索AI工具世界', 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=1200', '/tools', 1, 1),
('高质量提示词库', 'https://images.unsplash.com/photo-1684487741552-7d88a63b36b2?w=1200', '/prompts', 2, 1),
('AI学习资源中心', 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=1200', '/articles', 3, 1);
