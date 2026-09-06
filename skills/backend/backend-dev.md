# 后端开发技能

## 触发场景

当需要以下任务时使用此技能：
- API 开发
- 数据库操作
- 业务逻辑实现
- 代码审查
- 性能优化

## 核心能力

### 1. API 控制器模板

```typescript
import { Controller, Get, Post, Put, Delete, Body, Param, Query } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateUserDto, UpdateUserDto } from './dto';

@Controller('users')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Get()
  async findAll(@Query('page') page = 1, @Query('limit') limit = 10) {
    return this.userService.findAll({ page, limit });
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return this.userService.findOne(id);
  }

  @Post()
  async create(@Body() createDto: CreateUserDto) {
    return this.userService.create(createDto);
  }

  @Put(':id')
  async update(@Param('id') id: string, @Body() updateDto: UpdateUserDto) {
    return this.userService.update(id, updateDto);
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    return this.userService.remove(id);
  }
}
```

### 2. Service 业务逻辑模板

```typescript
@Injectable()
export class UserService {
  async findAll(query: PaginationQuery) {
    const { page, limit } = query;
    const skip = (page - 1) * limit;
    
    const [users, total] = await Promise.all([
      this.userRepository.findMany({ skip, take: limit }),
      this.userRepository.count(),
    ]);
    
    return {
      data: users,
      meta: { page, limit, total, totalPages: Math.ceil(total / limit) },
    };
  }

  async findOne(id: string) {
    const user = await this.userRepository.findOne(id);
    if (!user) {
      throw new NotFoundException('用户不存在');
    }
    return user;
  }

  async create(createDto: CreateUserDto) {
    // 1. 验证邮箱唯一性
    const exists = await this.userRepository.findByEmail(createDto.email);
    if (exists) {
      throw new ConflictException('邮箱已被使用');
    }
    
    // 2. 加密密码
    const hashedPassword = await this.hashPassword(createDto.password);
    
    // 3. 创建用户
    return this.userRepository.create({ ...createDto, password: hashedPassword });
  }
}
```

### 3. 数据库操作模板

```typescript
// Repository
@Injectable()
export class UserRepository {
  constructor(
    @InjectRepository(User)
    private repository: Repository<User>,
  ) {}

  async findOne(id: string): Promise<User | null> {
    return this.repository.findOne({ where: { id } });
  }

  async findByEmail(email: string): Promise<User | null> {
    return this.repository.findOne({ where: { email } });
  }

  async findAll(query: { skip: number; take: number }): Promise<[User[], number]> {
    return this.repository.findAndCount({
      skip: query.skip,
      take: query.take,
      order: { createdAt: 'DESC' },
    });
  }

  async create(data: Partial<User>): Promise<User> {
    const user = this.repository.create(data);
    return this.repository.save(user);
  }
}
```

### 4. DTO 模板

```typescript
import { IsEmail, IsString, MinLength, IsOptional, IsEnum } from 'class-validator';

export class CreateUserDto {
  @IsString()
  @MinLength(2)
  name: string;

  @IsEmail()
  email: string;

  @IsString()
  @MinLength(6)
  password: string;

  @IsOptional()
  @IsEnum(UserRole)
  role?: UserRole;
}

export class UpdateUserDto {
  @IsOptional()
  @IsString()
  @MinLength(2)
  name?: string;

  @IsOptional()
  @IsEnum(UserStatus)
  status?: UserStatus;
}
```

### 5. 统一响应格式

```typescript
// 成功响应
{
  "success": true,
  "data": { ... },
  "message": "操作成功"
}

// 分页响应
{
  "success": true,
  "data": [...],
  "meta": {
    "page": 1,
    "limit": 10,
    "total": 100,
    "totalPages": 10
  }
}

// 错误响应
{
  "success": false,
  "error": {
    "code": "USER_NOT_FOUND",
    "message": "用户不存在"
  }
}
```

### 6. 代码审查清单

- [ ] 参数有验证注解
- [ ] 有错误处理
- [ ] 有事务管理（需要时）
- [ ] SQL 有参数化
- [ ] 敏感数据加密
- [ ] 有日志记录
- [ ] 有接口文档
```
